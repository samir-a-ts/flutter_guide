import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/places_list/screens/search/widget/search_page.dart';

/// Search route.
const searchRoutes = AutoRoute<dynamic>(
  path: AppRoutes.search,
  page: SearchPage,
);
