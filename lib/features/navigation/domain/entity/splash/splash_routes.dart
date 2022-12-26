import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/introduction/screens/splash/widget/splash_page.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';

/// Splash route.
const splashRoutes = AutoRoute<dynamic>(
  path: '/${AppRoutes.splash}',
  page: SplashPage,
  initial: true,
);
