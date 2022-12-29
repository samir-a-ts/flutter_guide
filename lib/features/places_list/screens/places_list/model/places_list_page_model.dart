import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Model for `PlacesListPage`.
class PlacesListPageModel extends ElementaryModel {
  /// State of list of places viewed on a screen.
  final placesListState = EntityStateNotifier<Iterable<Place>>.value([]);

  /// Whether places are being loaded initially.
  /// (to determine whether show `new place` button or not)
  final arePlacesLoading = StateNotifier<bool>(initValue: false);

  /// Whether additional places are being loaded
  /// currently.
  /// (to determine whether to show
  /// loader in the end of a places list)
  final arePlacesReloading = StateNotifier<bool>(initValue: false);

  /// Controller of pull-to-refresh
  /// on places list (for reload).
  final _refreshController = StreamController<SwipeRefreshState>();

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

    await _requestPlaces(refreshList: true);

    _refreshController.sink.add(SwipeRefreshState.hidden);
  }

  /// Loads places from current [_page].
  /// Handles all state transfer.
  Future<void> loadPlacesList() async {
    if (placesListState.value!.isLoading) return;

    final previousData = placesListState.value?.data;

    placesListState.loading(previousData);

    arePlacesReloading.accept(previousData!.isNotEmpty);

    await _requestPlaces();

    arePlacesLoading.accept(placesListState.value!.data!.isNotEmpty);

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
    } on Exception catch (e) {
      placesListState.error(e, previousData);
    }
  }
}
