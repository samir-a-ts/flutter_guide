import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/map/screens/map_widget.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';

/// Map route.
const mapRoutes = AutoRoute<dynamic>(
  path: AppRoutes.map,
  page: MapPage,
);
