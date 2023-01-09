import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_search_cache_repository.dart';
import 'package:rxdart/rxdart.dart';

/// Model for places search page
class PlacesSearchModel extends ElementaryModel {
  /// The state of filtered places, which were
  /// filtered by their name.
  final foundPlacesState = EntityStateNotifier<Iterable<Place>>.value([]);

  /// List of previous queries (search history)
  ///  of user place's search.
  final searchHistory = StateNotifier<List<String>>();

  final IPlacesListRepository _placesListRepository;

  final IPlacesSearchCacheRepository _placesSearchCacheRepository;

  final _searchStreamController = BehaviorSubject<String>();

  late StreamSubscription _streamSubscription;

  String _lastQuery = '';

  Stream<String> get _searchStream =>
      _searchStreamController.stream.debounceTime(
        const Duration(seconds: 1),
      );

  /// Constructor for [PlacesSearchModel].
  PlacesSearchModel(
    ErrorHandler errorHandler,
    this._placesListRepository,
    this._placesSearchCacheRepository,
  ) : super(errorHandler: errorHandler);

  @override
  void init() {
    _loadHistoryFromCache();

    _renewSubscription();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();

    _searchStreamController.close();

    _cacheHistory();

    searchHistory.dispose();

    foundPlacesState.dispose();
  }

  /// React on user input: add query to the stream.
  void onSearch(String search) {
    /// If input is empty...
    if (search.isEmpty) {
      foundPlacesState.content([]);

      /// In order to stop previous events debouncing.
      _streamSubscription.cancel();

      _renewSubscription();

      return;
    }

    _searchStreamController.add(search);
  }

  /// Removes history recording
  /// at given [index].
  void deleteHistoryAt(int index) {
    final historyList = List.of(searchHistory.value!);

    // ignore: cascade_invocations
    historyList.removeAt(index);

    searchHistory.accept(historyList);
  }

  /// Saves given query in device cache.
  void saveSearch(String query) {
    final historyList = List.of(searchHistory.value!);

    if (historyList.contains(query)) return;

    searchHistory.accept(
      [
        query,
        ...historyList,
      ],
    );
  }

  /// Deletes all recordings from list of history.
  void clearHistory() => searchHistory.accept([]);

  Future<void> _loadPlacesFromSearch(String query) async {
    if (_lastQuery == query || query.length == 1) return;

    _lastQuery = query;

    try {
      final places = await _placesListRepository.getFilteredPlaces(
        name: query,
      );

      foundPlacesState.content(places);
    } on Exception catch (e) {
      foundPlacesState.error(e);
    }
  }

  void _loadHistoryFromCache() => searchHistory.accept(
        _placesSearchCacheRepository.getSearchHistory(),
      );

  void _renewSubscription() =>
      _streamSubscription = _searchStream.listen(_loadPlacesFromSearch);

  Future<void> _cacheHistory() =>
      _placesSearchCacheRepository.cacheSearchHistory(
        searchHistory.value!,
      );
}
