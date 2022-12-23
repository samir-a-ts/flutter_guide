import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/app/core/pages/main_page.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/favourite/favourite_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/map/map_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/places_list/places_list_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/settings/settings_routes.dart';

/// Main route and all included.
const mainRoutes = AutoRoute<dynamic>(
  path: '/${AppRoutes.mainScreen}',
  page: MainPage,
  children: [
    placesListRoutes,
    mapRoutes,
    favouriteRoutes,
    settingsRoutes,
  ],
);
