import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/common/widgets/app_error_snack_bar.dart';
import 'package:flutter_guide/features/navigation/service/app_router.gr.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/domain/entity/places_filter_parameters.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page_model.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Interface of [PlacesListPageWidgetModel]
abstract class IPlacesListPageWidgetModel extends IWidgetModel {
  /// State of list of places viewed on a screen.
  ListenableState<EntityState<Iterable<Place>>> get placesListState;

  /// State of list of places viewed on a screen.
  ListenableState<EntityState<Iterable<Place>>> get filteredPlacesListState;

  /// Whether places are being loaded initially.
  /// (to determine whether show `new place` button or not)
  ListenableState<bool> get arePlacesLoaded;

  /// Whether to show places loaded in [filteredPlacesListState].
  ListenableState<PlacesFilterParameters> get placesFilterState;

  /// Translated app bar title.
  String get appBarTitle;

  /// Translated string in case of any error
  /// ocurred.
  String get errorText;

  /// Translated error widget message.
  String get errorMessage;

  /// Translated string in case of any error
  /// ocurred.
  String get emptyText;

  /// Translated error widget message.
  String get emptyMessage;

  /// Color, in which the filter button
  /// on search input will be painted.
  Color get inputTrailingFilterIconColor;

  /// Controller of pull-to-refresh
  /// on places list (for reload).
  Stream<SwipeRefreshState> get refreshStream;

  /// Whether additional places are being loaded
  /// currently.
  /// (to determine whether to show
  /// loader in the end of a places list)
  ListenableState<bool> get arePlacesReloading;

  /// Scroll controller of [ListView] of [Place]s.
  /// (for pagination)
  ScrollController get scrollController;

  /// Pull-to-refresh functionality:
  /// Resets the list of places and
  /// returns all the way to the first page.
  /// The, reloads.
  Future<void> refresh();

  /// Navigates to places search page.
  void onSearchInputTap();

  /// Handle tap on filter icon
  /// in search input.
  void onFilterIconTap();

  /// Navigates to `NewPlacePage`
  /// for creating user's own place.
  void onNewPlaceButtonTap();
}

/// Widget Model for [PlacesListPage]
class PlacesListPageWidgetModel
    extends WidgetModel<PlacesListContentWidget, PlacesListPageModel>
    implements IPlacesListPageWidgetModel {
  /// Scroll controller  of [ListView] of [Place]s instance.
  /// (for pagination)
  final _scrollController = ScrollController();

  @override
  ListenableState<EntityState<Iterable<Place>>> get placesListState =>
      model.placesListState;

  @override
  ListenableState<EntityState<Iterable<Place>>> get filteredPlacesListState =>
      model.filteredPlacesListState;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  ListenableState<bool> get arePlacesLoaded => model.arePlacesLoaded;

  @override
  ListenableState<bool> get arePlacesReloading => model.arePlacesReloading;

  @override
  ListenableState<PlacesFilterParameters> get placesFilterState =>
      model.placesFilterState;

  @override
  Stream<SwipeRefreshState> get refreshStream => model.refreshStream;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  String get errorText => AppTranslations.of(context).error;

  @override
  String get errorMessage => AppTranslations.of(context).somethingWrong;

  @override
  String get emptyMessage => AppTranslations.of(context).emptyMessage;

  @override
  String get emptyText => AppTranslations.of(context).emptyTitle;

  @override
  Color get inputTrailingFilterIconColor => Theme.of(context).primaryColor;

  /// Constructor for [PlacesListPageWidgetModel].
  PlacesListPageWidgetModel(super.model);

  /// Pull-to-refresh functionality:
  /// Resets the list of places and
  /// returns all the way to the first page.
  /// The, reloads.
  @override
  Future<void> refresh() => model.refresh();

  @override
  void onSearchInputTap() =>
      AutoRouter.of(context).push(const PlacesSearchRoute());

  @override
  Future<void> onFilterIconTap() async {
    final result = await AutoRouter.of(context).push<PlacesFilterParameters>(
      PlacesFilterRoute(
        initialParams: placesFilterState.value,
      ),
    );

    return model.applyFilter(result!);
  }

  @override
  void onNewPlaceButtonTap() =>
      AutoRouter.of(context).push(const NewPlaceRoute());

  @override
  void initWidgetModel() {
    placesListState.addListener(_errorListener);

    super.initWidgetModel();

    _scrollController.addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadMore)
      ..dispose();

    super.dispose();

    placesListState.removeListener(_errorListener);
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter == 0 &&
        placesFilterState.value == null) model.loadPlacesList();
  }

  void _errorListener() {
    final state = placesListState.value;

    if (state!.hasError && state.data!.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const AppErrorSnackBar() as SnackBar,
      );
    }
  }
}

/// Factory for [PlacesListPageWidgetModel].
PlacesListPageWidgetModel placesListPageWmFactory(
  BuildContext context,
) {
  final placesList = Provider.of<IPlacesListScope>(context, listen: false);

  final model = PlacesListPageModel(placesList.placesRepository);

  return PlacesListPageWidgetModel(model);
}
