import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/introduction/screens/tutorial/widget/tutorial_page.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';

/// Tutorial route.
const tutorialRoutes = AutoRoute<dynamic>(
  path: '/${AppRoutes.tutorial}',
  page: TutorialPage,
);
