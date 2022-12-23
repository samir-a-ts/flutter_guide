import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/favourite/screens/favourite/widget/favourite_page.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';

/// Favourite route.
const favouriteRoutes = AutoRoute<dynamic>(
  path: AppRoutes.favourite,
  page: FavouritePage,
);
