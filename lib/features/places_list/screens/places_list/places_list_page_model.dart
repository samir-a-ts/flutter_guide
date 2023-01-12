import 'dart:async';

import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_widget.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Model for `PlacesListPage`.
class PlacesListPageModel extends ElementaryModel {
  /// State of list of places,
  /// returned from filtered search.
  final filteredPlacesListState =
      EntityStateNotifier<Iterable<Place>>.value([]);

  /// Whether to show places loaded in [filteredPlacesListState].
  final showFilteredPlacesState = StateNotifier<bool>(initValue: false);

  /// State of list of places viewed on a screen.
  final placesListState = EntityStateNotifier<Iterable<Place>>.value([]);

  /// Whether places are being loaded initially.
  /// (to determine whether show `new place` button or not)
  final arePlacesLoaded = StateNotifier<bool>(initValue: false);

  /// Whether additional places are being loaded
  /// currently.
  /// (to determine whether to show
  /// loader in the end of a places list)
  final arePlacesReloading = StateNotifier<bool>(initValue: false);

  /// Controller of pull-to-refresh
  /// on places list (for reload).
  final _refreshController = StreamController<SwipeRefreshState>.broadcast();

  final IPlacesListRepository _repository;

  /// Current flow of states
  /// from [_refreshController].
  Stream<SwipeRefreshState> get refreshStream => _refreshController.stream;

  var _page = 0;

  /// Constructor for [PlacesListPageModel].
  PlacesListPageModel(this._repository);

  @override
  void init() {
    loadPlacesList();
  }

  @override
  void dispose() {
    _refreshController.close();
  }

  /// Pull-to-refresh functionality:
  /// Resets the list of places and
  /// returns all the way to the first page.
  /// The, reloads.
  Future<void> refresh() async {
    _page = 0;

    filteredPlacesListState.content([]);

    showFilteredPlacesState.accept(false);

    await _requestPlaces(refreshList: true);

    _refreshController.sink.add(SwipeRefreshState.hidden);
  }

  /// Loads filtered list of places,
  /// taking data from [filterParameters]
  Future<void> applyFilter(PlacesFilterParameters filterParameters) async {
    if (filterParameters.isEmpty) {
      filteredPlacesListState.content([]);

      showFilteredPlacesState.accept(false);

      return;
    }

    showFilteredPlacesState.accept(true);

    filteredPlacesListState.loading();

    try {
      final result = await _repository.getFilteredPlaces(
        latitude: filterParameters.location.latitude,
        longitude: filterParameters.location.longitude,
        radius: filterParameters.range,
        types: filterParameters.types
            .map(
              (e) => e.toString(),
            )
            .toList(),
      );

      filteredPlacesListState.content(result);
    } on DioError catch (e) {
      filteredPlacesListState.error(e);
    }
  }

  /// Loads places from current [_page].
  /// Handles all state transfer.
  Future<void> loadPlacesList() async {
    if (placesListState.value!.isLoading) return;

    if (showFilteredPlacesState.value!) return;

    final previousData = placesListState.value?.data;

    placesListState.loading(previousData);

    arePlacesReloading.accept(previousData!.isNotEmpty);

    await _requestPlaces();

    arePlacesLoaded.accept(placesListState.value!.data!.isNotEmpty);

    arePlacesReloading.accept(false);
  }

  Future<void> _requestPlaces({bool refreshList = false}) async {
    final previousData = placesListState.value?.data;

    try {
      final result = await _repository.getAllPlaces(_page);

      placesListState.content(
        refreshList ? result : previousData!.followedBy(result),
      );

      _page++;
    } on DioError catch (e) {
      placesListState.error(e, previousData);
    }
  }
}
