import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/places_list/filter/filter_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/places_list/new_place/new_place_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/places_list/search/search_routes.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/widget/places_list_page.dart';

/// Places list route and all included.
const placesListRoutes = AutoRoute<dynamic>(
  path: AppRoutes.placesList,
  page: PlacesListPage,
  children: [
    searchRoutes,
    filterRoutes,
    newPlaceRoutes,
  ],
);
