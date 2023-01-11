import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/map/widget/new_place_map_page.dart';

/// Map route in new place route.
const mapRoutes = AutoRoute<dynamic>(
  path: AppRoutes.newPlaceMap,
  page: NewPlaceMapPage,
);
