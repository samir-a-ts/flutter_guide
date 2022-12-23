import 'package:auto_route/auto_route.dart';
import 'package:flutter_guide/src/presentation/core/pages/main_page.dart';
import 'package:flutter_guide/src/presentation/favourite/presentation/pages/favourite_page.dart';
import 'package:flutter_guide/src/presentation/introduction/pages/splash_page.dart';
import 'package:flutter_guide/src/presentation/introduction/pages/tutorial_page.dart';
import 'package:flutter_guide/src/presentation/map/presentation/pages/map_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/filter_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/new_place_categories_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/new_place_map_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/new_place_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/places_list_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/search_page.dart';
import 'package:flutter_guide/src/presentation/settings/presentation/pages/settings_page.dart';

abstract class _AppRoutes {
  static const splash = "splash";

  static const tutorial = "tutorial";

  static const mainScreen = "main";

  static const placesList = "places_list";

  static const map = "map";

  static const favourite = "favourite";

  static const settings = "settings";

  static const search = "search";

  static const filter = "filter";

  static const newPlace = "new_place";

  static const categories = "categories";

  static const newPlaceMap = "new_place_map";
}

@MaterialAutoRouter(
  replaceInRouteName: "Page,Route",
  routes: <AutoRoute>[
    AutoRoute(
      path: "/${_AppRoutes.splash}",
      page: SplashPage,
      initial: true,
    ),
    AutoRoute(
      path: "/${_AppRoutes.tutorial}",
      page: TutorialPage,
    ),
    AutoRoute(
      path: "/${_AppRoutes.mainScreen}",
      page: MainPage,
      children: [
        AutoRoute(
          path: _AppRoutes.placesList,
          page: PlacesListPage,
          children: [
            AutoRoute(
              path: _AppRoutes.search,
              page: SearchPage,
            ),
            AutoRoute(
              path: _AppRoutes.filter,
              page: FilterPage,
            ),
            AutoRoute(
              path: _AppRoutes.newPlace,
              page: NewPlacePage,
              children: [
                AutoRoute(
                  path: _AppRoutes.categories,
                  page: NewPlaceCategoriesPage,
                ),
                AutoRoute(
                  path: _AppRoutes.newPlaceMap,
                  page: NewPlaceMapPage,
                ),
              ],
            ),
          ],
        ),
        AutoRoute(
          path: _AppRoutes.map,
          page: MapPage,
        ),
        AutoRoute(
          path: _AppRoutes.favourite,
          page: FavouritePage,
        ),
        AutoRoute(
          path: _AppRoutes.settings,
          page: SettingsPage,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
