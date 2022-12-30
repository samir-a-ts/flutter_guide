import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/entity/search_history.dart';
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
  final searchHistory = StateNotifier<SearchHistory>();

  final IPlacesListRepository _placesListRepository;

  final IPlacesSearchCacheRepository _placesSearchCacheRepository;

  final _searchStreamController = BehaviorSubject<String>();

  late StreamSubscription _streamSubscription;

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

    _streamSubscription = _searchStream.listen(_loadPlacesFromSearch);
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
    if (search == (_searchStreamController.valueOrNull ?? '')) return;

    /// If input is empty...
    if (search.isEmpty) {
      foundPlacesState.content([]);

      /// In order to stop previous events debouncing.
      _streamSubscription.cancel();

      _streamSubscription = _searchStream.listen(_loadPlacesFromSearch);

      return;
    }

    _searchStreamController.add(search);
  }

  /// Removes [SearchHistory] recording
  /// at given [index].
  void deleteHistoryAt(int index) => searchHistory.accept(
        searchHistory.value!..remove(index),
      );

  /// Saves given query in device cache.
  void saveSearch(String query) => searchHistory.value!.add(query);

  Future<void> _loadPlacesFromSearch(String query) async {
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

  Future<void> _cacheHistory() =>
      _placesSearchCacheRepository.cacheSearchHistory(
        searchHistory.value!,
      );
}
