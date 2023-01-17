import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/categories/new_place_categories_page.dart';

/// Categories route.
const categoriesRoutes = AutoRoute<PlaceType>(
  path: AppRoutes.categories,
  page: NewPlaceCategoriesPage,
);
