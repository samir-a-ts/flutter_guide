import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/map/new_place_map_page.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' show Point;

/// Map route in new place route.
const mapRoutes = AutoRoute<Point>(
  path: AppRoutes.newPlaceMap,
  page: NewPlaceMapPage,
);
