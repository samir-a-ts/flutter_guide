import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/features/places_list/domain/repository/geolocation_repository.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_model.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_wm.dart';

/// Default factory for [PlacesFilterWidgetModel]
PlacesFilterWidgetModel defaultPlacesFilterWidgetModelFactory(
  BuildContext context,
) {
  return PlacesFilterWidgetModel(
    PlacesFilterModel(
      LocationRepository(),
    ),
  );
}

/// Widget for PlacesFilter module.
class PlacesFilterPage extends ElementaryWidget<IPlacesFilterWidgetModel> {
  /// Constructor for [PlacesFilterPage]
  const PlacesFilterPage({
    Key? key,
    WidgetModelFactory wmFactory = defaultPlacesFilterWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesFilterWidgetModel wm) {
    return Container();
  }
}
