import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/model/places_list_page_model.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/widget/places_list_page.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Interface of [PlacesListPageWidgetModel]
abstract class IPlacesListPageWidgetModel extends IWidgetModel {
  /// State of list of places viewed on a screen.
  ListenableState<EntityState<Iterable<Place>>> get placesListState;

  /// Whether places are being loaded initially.
  /// (to determine whether show `new place` button or not)
  ListenableState<bool> get arePlacesLoading;

  /// Translated app bar title.
  String get appBarTitle;

  /// Controller of places list.
  /// (for pagination)
  ScrollController get scrollController;

  /// Controller of pull-to-refresh
  /// on places list (for reload).
  Stream<SwipeRefreshState> get refreshStream;

  /// Whether additional places are being loaded
  /// currently.
  /// (to determine whether to show
  /// loader in the end of a places list)
  ListenableState<bool> get arePlacesReloading;

  /// Pull-to-refresh functionality:
  /// Resets the list of places and
  /// returns all the way to the first page.
  /// The, reloads.
  Future<void> refresh();
}

/// Widget Model for [PlacesListPage]
class PlacesListPageWidgetModel
    extends WidgetModel<PlacesListPage, PlacesListPageModel>
    implements IPlacesListPageWidgetModel {
  @override
  ListenableState<EntityState<Iterable<Place>>> get placesListState =>
      model.placesListState;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  ListenableState<bool> get arePlacesLoading => model.arePlacesLoading;

  @override
  ScrollController get scrollController => model.scroll;

  @override
  ListenableState<bool> get arePlacesReloading => model.arePlacesReloading;

  @override
  Stream<SwipeRefreshState> get refreshStream => model.refreshStream;

  /// Constructor for [PlacesListPageWidgetModel].
  PlacesListPageWidgetModel(super.model);

  /// Pull-to-refresh functionality:
  /// Resets the list of places and
  /// returns all the way to the first page.
  /// The, reloads.
  @override
  Future<void> refresh() => model.refresh();

  @override
  void initWidgetModel() {
    placesListState.addListener(_errorListener);

    super.initWidgetModel();
  }

  @override
  void dispose() {
    placesListState.removeListener(_errorListener);

    super.dispose();
  }

  void _errorListener() {
    final state = placesListState.value;

    if (state!.hasError && state.data!.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Some error occurred!'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
    }
  }
}

/// Factory for [PlacesListPageWidgetModel].
PlacesListPageWidgetModel placesListPageWmFactory(
  BuildContext context,
) {
  final placesList = Provider.of<IPlacesListScope>(context, listen: false);

  final model = PlacesListPageModel(placesList.repository);

  return PlacesListPageWidgetModel(model);
}
