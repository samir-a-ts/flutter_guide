import 'package:auto_route/annotations.dart';
import 'package:flutter_guide/features/favorite/screens/favorite/widget/favorite_page.dart';
import 'package:flutter_guide/features/navigation/domain/entity/app_routes.dart';

/// Favorite route.
const favoriteRoutes = AutoRoute<dynamic>(
  path: AppRoutes.favorite,
  page: FavoritePage,
);
