import 'package:auto_route/auto_route.dart';
import 'package:flutter_guide/src/presentation/introduction/pages/splash_page.dart';
import 'package:flutter_guide/src/presentation/introduction/pages/tutorial_page.dart';
import 'package:flutter_guide/src/presentation/place_list/pages/places_list_page.dart';

abstract class _AppRoutes {
  static const splash = "splash";

  static const tutorial = "tutorial";

  static const placeList = "place_list";
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
      path: "/${_AppRoutes.placeList}",
      page: PlacesListPage,
    ),
  ],
)
class $AppRouter {}
