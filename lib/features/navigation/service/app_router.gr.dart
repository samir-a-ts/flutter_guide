// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;

import '../../app/core/pages/main_page.dart' as _i3;
import '../../favorite/screens/favorite/widget/favorite_page.dart' as _i6;
import '../../introduction/screens/splash/widget/splash_page.dart' as _i1;
import '../../introduction/screens/tutorial/widget/tutorial_page.dart' as _i2;
import '../../map/screens/map/widget/map_page.dart' as _i5;
import '../../places_list/domain/entity/places_filter_parameters.dart' as _i14;
import '../../places_list/screens/filter/places_filter_widget.dart' as _i9;
import '../../places_list/screens/new_place/new_place/new_place_widget.dart'
    as _i10;
import '../../places_list/screens/new_place/widget/new_place_categories_page.dart'
    as _i11;
import '../../places_list/screens/places_list/places_list_page.dart' as _i4;
import '../../places_list/screens/search/search_widget.dart' as _i8;
import '../../settings/screens/settings/widget/settings_page.dart' as _i7;

class AppRouter extends _i12.RootStackRouter {
  AppRouter([_i13.GlobalKey<_i13.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    TutorialRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.TutorialPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.MainPage(),
      );
    },
    PlacesListRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.PlacesListPage(),
      );
    },
    MapRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.MapPage(),
      );
    },
    FavoriteRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.FavoritePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsPage(),
      );
    },
    PlacesSearchRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.PlacesSearchPage(),
      );
    },
    PlacesFilterRoute.name: (routeData) {
      final args = routeData.argsAs<PlacesFilterRouteArgs>(
          orElse: () => const PlacesFilterRouteArgs());
      return _i12.MaterialPageX<_i14.PlacesFilterParameters>(
        routeData: routeData,
        child: _i9.PlacesFilterPage(
          key: args.key,
          initialParams: args.initialParams,
        ),
      );
    },
    NewPlaceRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.NewPlacePage(),
      );
    },
    NewPlaceCategoriesRoute.name: (routeData) {
      return _i12.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.NewPlaceCategoriesPage(),
      );
    },
  };

  @override
  List<_i12.RouteConfig> get routes => [
        _i12.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i12.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i12.RouteConfig(
          TutorialRoute.name,
          path: '/tutorial',
        ),
        _i12.RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            _i12.RouteConfig(
              PlacesListRoute.name,
              path: 'places_list',
              parent: MainRoute.name,
              children: [
                _i12.RouteConfig(
                  PlacesSearchRoute.name,
                  path: 'search',
                  parent: PlacesListRoute.name,
                ),
                _i12.RouteConfig(
                  PlacesFilterRoute.name,
                  path: 'filter',
                  parent: PlacesListRoute.name,
                ),
                _i12.RouteConfig(
                  NewPlaceRoute.name,
                  path: 'new_place',
                  parent: PlacesListRoute.name,
                  children: [
                    _i12.RouteConfig(
                      NewPlaceCategoriesRoute.name,
                      path: 'categories',
                      parent: NewPlaceRoute.name,
                    ),
                    _i12.RouteConfig(
                      MapRoute.name,
                      path: 'map',
                      parent: NewPlaceRoute.name,
                    ),
                  ],
                ),
              ],
            ),
            _i12.RouteConfig(
              MapRoute.name,
              path: 'map',
              parent: MainRoute.name,
            ),
            _i12.RouteConfig(
              FavoriteRoute.name,
              path: 'favorite',
              parent: MainRoute.name,
            ),
            _i12.RouteConfig(
              SettingsRoute.name,
              path: 'settings',
              parent: MainRoute.name,
            ),
          ],
        ),
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.TutorialPage]
class TutorialRoute extends _i12.PageRouteInfo<void> {
  const TutorialRoute()
      : super(
          TutorialRoute.name,
          path: '/tutorial',
        );

  static const String name = 'TutorialRoute';
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i12.PageRouteInfo<void> {
  const MainRoute({List<_i12.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i4.PlacesListPage]
class PlacesListRoute extends _i12.PageRouteInfo<void> {
  const PlacesListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          PlacesListRoute.name,
          path: 'places_list',
          initialChildren: children,
        );

  static const String name = 'PlacesListRoute';
}

/// generated route for
/// [_i5.MapPage]
class MapRoute extends _i12.PageRouteInfo<void> {
  const MapRoute()
      : super(
          MapRoute.name,
          path: 'map',
        );

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i6.FavoritePage]
class FavoriteRoute extends _i12.PageRouteInfo<void> {
  const FavoriteRoute()
      : super(
          FavoriteRoute.name,
          path: 'favorite',
        );

  static const String name = 'FavoriteRoute';
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i8.PlacesSearchPage]
class PlacesSearchRoute extends _i12.PageRouteInfo<void> {
  const PlacesSearchRoute()
      : super(
          PlacesSearchRoute.name,
          path: 'search',
        );

  static const String name = 'PlacesSearchRoute';
}

/// generated route for
/// [_i9.PlacesFilterPage]
class PlacesFilterRoute extends _i12.PageRouteInfo<PlacesFilterRouteArgs> {
  PlacesFilterRoute({
    _i15.Key? key,
    _i14.PlacesFilterParameters? initialParams,
  }) : super(
          PlacesFilterRoute.name,
          path: 'filter',
          args: PlacesFilterRouteArgs(
            key: key,
            initialParams: initialParams,
          ),
        );

  static const String name = 'PlacesFilterRoute';
}

class PlacesFilterRouteArgs {
  const PlacesFilterRouteArgs({
    this.key,
    this.initialParams,
  });

  final _i15.Key? key;

  final _i14.PlacesFilterParameters? initialParams;

  @override
  String toString() {
    return 'PlacesFilterRouteArgs{key: $key, initialParams: $initialParams}';
  }
}

/// generated route for
/// [_i10.NewPlacePage]
class NewPlaceRoute extends _i12.PageRouteInfo<void> {
  const NewPlaceRoute({List<_i12.PageRouteInfo>? children})
      : super(
          NewPlaceRoute.name,
          path: 'new_place',
          initialChildren: children,
        );

  static const String name = 'NewPlaceRoute';
}

/// generated route for
/// [_i11.NewPlaceCategoriesPage]
class NewPlaceCategoriesRoute extends _i12.PageRouteInfo<void> {
  const NewPlaceCategoriesRoute()
      : super(
          NewPlaceCategoriesRoute.name,
          path: 'categories',
        );

  static const String name = 'NewPlaceCategoriesRoute';
}
