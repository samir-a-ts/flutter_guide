import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/features/map/di/map_scope.dart';
import 'package:flutter_guide/features/map/screens/map_model.dart';
import 'package:flutter_guide/features/map/screens/map_widget.dart';
import 'package:provider/provider.dart';

/// Widget model interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {}

/// Widget model for [MapWidget].
class MapWidgetModel extends WidgetModel<MapWidget, MapModel>
    implements IMapWidgetModel {
  /// Constructor for [MapWidgetModel].
  MapWidgetModel(MapModel model) : super(model);
}

/// Default factory for [MapWidgetModel]
MapWidgetModel defaultMapWidgetModelFactory(BuildContext context) {
  final mapScope = Provider.of<IMapScope>(context);

  return MapWidgetModel(
    MapModel(
      mapScope.placesListRepository,
      mapScope.locationRepository,
    ),
  );
}
