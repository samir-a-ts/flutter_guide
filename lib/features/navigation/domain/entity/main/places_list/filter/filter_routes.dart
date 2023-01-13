import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';
import 'package:flutter_guide/features/places_list/domain/entity/places_filter_parameters.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_widget.dart';

/// Filter route.
const filterRoutes = AutoRoute<PlacesFilterParameters>(
  path: AppRoutes.filter,
  page: PlacesFilterPage,
);
