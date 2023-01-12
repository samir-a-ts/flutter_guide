import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/entity/location.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_model.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_widget.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Widget model for [PlacesFilterPage].
abstract class IPlacesFilterWidgetModel extends IWidgetModel {
  /// Whether the current user position on world
  /// map is loading or loaded.
  EntityStateNotifier<Location?> get userLocationState;

  /// State of selected on filter places types.
  StateNotifier<Set<PlaceType>> get filterPlacesTypesState;

  /// State of selected on filter range of geo-search.
  StateNotifier<double> get rangeState;

  /// Translated text of app bar's clear button.
  String get clearButtonText;

  /// Translated categories section label text.
  String get categoriesText;

  /// Translated bottom show button text.
  String get showButtonText;

  /// Translated text on bottom button
  /// when location is being loaded.
  String get loadingText;

  /// Color of range selection slider.
  Color get sliderColor;

  /// Color of inactive line of the slider.
  Color get inactiveSliderPartColor;

  /// Color of inactive line of the slider.
  Color get disabledBottomButtonColor;

  /// If user suddenly wants to return
  /// to places list page, the
  /// [PlacesFilterParameters.empty] will be returned.
  Future<bool> returnToListWithoutFilter();

  /// Defaults all chosen filters.
  void clearFilter();

  /// Adds given [type] to the [filterPlacesTypesState].
  void chooseType(PlaceType type);

  /// Set ups the [range] to [rangeState].
  void setRange(double range);

  /// Reads out all fields and returns back
  /// to list page with specified filter.
  void returnToListWithFilter();
}

/// Widget model implementation for [PlacesFilterPage].
class PlacesFilterWidgetModel
    extends WidgetModel<PlacesFilterPage, PlacesFilterModel>
    implements IPlacesFilterWidgetModel {
  @override
  EntityStateNotifier<Location?> get userLocationState =>
      model.userLocationState;

  @override
  StateNotifier<Set<PlaceType>> get filterPlacesTypesState =>
      model.filterPlacesTypesState;

  @override
  StateNotifier<double> get rangeState => model.rangeState;

  @override
  String get categoriesText => AppTranslations.of(context).categories;

  @override
  String get clearButtonText => AppTranslations.of(context).clear;

  @override
  Color get sliderColor => Theme.of(context).primaryColor;

  @override
  Color get inactiveSliderPartColor =>
      Theme.of(context).disabledColor.withOpacity(0.56);

  @override
  Color get disabledBottomButtonColor =>
      Theme.of(context).disabledColor.withOpacity(0.56);

  @override
  String get loadingText => AppTranslations.of(context).loading;

  @override
  String get showButtonText => AppTranslations.of(context).showFiltered;

  /// Constructor for [PlacesFilterWidgetModel].
  PlacesFilterWidgetModel(PlacesFilterModel model) : super(model);

  @override
  Future<bool> returnToListWithoutFilter() {
    AutoRouter.of(context).popForced<PlacesFilterParameters>(
      PlacesFilterParameters.empty(),
    );

    return Future.value(false);
  }

  @override
  void returnToListWithFilter() =>
      AutoRouter.of(context).popForced<PlacesFilterParameters>(
        PlacesFilterParameters(
          location: userLocationState.value!.data!,
          range: rangeState.value! * 1000,

          /// in metres.
          types: filterPlacesTypesState.value!.toList(),
        ),
      );

  @override
  void clearFilter() => model.clearFilter();

  @override
  void chooseType(PlaceType type) => model.chooseType(type);

  @override
  void setRange(double range) => model.setRange(range);
}
