import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/place_list/screens/filter/widget/filter_page.dart';

/// Filter route.
const filterRoutes = AutoRoute<dynamic>(
  path: AppRoutes.filter,
  page: FilterPage,
);
