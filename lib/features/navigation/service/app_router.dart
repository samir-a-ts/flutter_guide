import 'package:auto_route/auto_route.dart';
import 'package:flutter_guide/features/navigation/domain/entity/main/main_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/splash/splash_routes.dart';
import 'package:flutter_guide/features/navigation/domain/entity/tutorial/tutorial_routes.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    splashRoutes,
    tutorialRoutes,
    mainRoutes,
  ],
)

/// Auto-generated router delegate,
/// parser and provider.
class $AppRouter {}
