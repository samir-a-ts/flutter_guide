import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/map/map_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/places_list/new_place/categories/categories_routes.dart';
import 'package:flutter_guide/features/place_list/screens/new_place/widget/new_place_page.dart';

/// New place route and all included.
const newPlaceRoutes = AutoRoute<dynamic>(
  path: AppRoutes.newPlace,
  page: NewPlacePage,
  children: [
    categoriesRoutes,
    mapRoutes,
  ],
);
