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
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;

import '../../presentation/core/pages/main_page.dart' as _i3;
import '../../presentation/favourite/presentation/pages/favourite_page.dart'
    as _i6;
import '../../presentation/introduction/pages/splash_page.dart' as _i1;
import '../../presentation/introduction/pages/tutorial_page.dart' as _i2;
import '../../presentation/map/presentation/pages/map_page.dart' as _i5;
import '../../presentation/place_list/pages/filter_page.dart' as _i9;
import '../../presentation/place_list/pages/new_place_categories_page.dart'
    as _i11;
import '../../presentation/place_list/pages/new_place_map_page.dart' as _i12;
import '../../presentation/place_list/pages/new_place_page.dart' as _i10;
import '../../presentation/place_list/pages/places_list_page.dart' as _i4;
import '../../presentation/place_list/pages/search_page.dart' as _i8;
import '../../presentation/settings/presentation/pages/settings_page.dart'
    as _i7;

class AppRouter extends _i13.RootStackRouter {
  AppRouter([_i14.GlobalKey<_i14.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashPage(),
      );
    },
    TutorialRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.TutorialPage(),
      );
    },
    MainRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.MainPage(),
      );
    },
    PlacesListRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.PlacesListPage(),
      );
    },
    MapRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.MapPage(),
      );
    },
    FavouriteRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.FavouritePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsPage(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SearchPage(),
      );
    },
    FilterRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.FilterPage(),
      );
    },
    NewPlaceRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i10.NewPlacePage(),
      );
    },
    NewPlaceCategoriesRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i11.NewPlaceCategoriesPage(),
      );
    },
    NewPlaceMapRoute.name: (routeData) {
      return _i13.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i12.NewPlaceMapPage(),
      );
    },
  };

  @override
  List<_i13.RouteConfig> get routes => [
        _i13.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i13.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i13.RouteConfig(
          TutorialRoute.name,
          path: '/tutorial',
        ),
        _i13.RouteConfig(
          MainRoute.name,
          path: '/main',
          children: [
            _i13.RouteConfig(
              '#redirect',
              path: '',
              parent: MainRoute.name,
              redirectTo: 'places_list',
              fullMatch: true,
            ),
            _i13.RouteConfig(
              PlacesListRoute.name,
              path: 'places_list',
              parent: MainRoute.name,
              children: [
                _i13.RouteConfig(
                  SearchRoute.name,
                  path: 'search',
                  parent: PlacesListRoute.name,
                ),
                _i13.RouteConfig(
                  FilterRoute.name,
                  path: 'filter',
                  parent: PlacesListRoute.name,
                ),
                _i13.RouteConfig(
                  NewPlaceRoute.name,
                  path: 'new_place',
                  parent: PlacesListRoute.name,
                  children: [
                    _i13.RouteConfig(
                      NewPlaceCategoriesRoute.name,
                      path: 'categories',
                      parent: NewPlaceRoute.name,
                    ),
                    _i13.RouteConfig(
                      NewPlaceMapRoute.name,
                      path: 'new_place_map',
                      parent: NewPlaceRoute.name,
                    ),
                  ],
                ),
              ],
            ),
            _i13.RouteConfig(
              MapRoute.name,
              path: 'map',
              parent: MainRoute.name,
            ),
            _i13.RouteConfig(
              FavouriteRoute.name,
              path: 'favourite',
              parent: MainRoute.name,
            ),
            _i13.RouteConfig(
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
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.TutorialPage]
class TutorialRoute extends _i13.PageRouteInfo<void> {
  const TutorialRoute()
      : super(
          TutorialRoute.name,
          path: '/tutorial',
        );

  static const String name = 'TutorialRoute';
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i13.PageRouteInfo<void> {
  const MainRoute({List<_i13.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          path: '/main',
          initialChildren: children,
        );

  static const String name = 'MainRoute';
}

/// generated route for
/// [_i4.PlacesListPage]
class PlacesListRoute extends _i13.PageRouteInfo<void> {
  const PlacesListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          PlacesListRoute.name,
          path: 'places_list',
          initialChildren: children,
        );

  static const String name = 'PlacesListRoute';
}

/// generated route for
/// [_i5.MapPage]
class MapRoute extends _i13.PageRouteInfo<void> {
  const MapRoute()
      : super(
          MapRoute.name,
          path: 'map',
        );

  static const String name = 'MapRoute';
}

/// generated route for
/// [_i6.FavouritePage]
class FavouriteRoute extends _i13.PageRouteInfo<void> {
  const FavouriteRoute()
      : super(
          FavouriteRoute.name,
          path: 'favourite',
        );

  static const String name = 'FavouriteRoute';
}

/// generated route for
/// [_i7.SettingsPage]
class SettingsRoute extends _i13.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i8.SearchPage]
class SearchRoute extends _i13.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: 'search',
        );

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i9.FilterPage]
class FilterRoute extends _i13.PageRouteInfo<void> {
  const FilterRoute()
      : super(
          FilterRoute.name,
          path: 'filter',
        );

  static const String name = 'FilterRoute';
}

/// generated route for
/// [_i10.NewPlacePage]
class NewPlaceRoute extends _i13.PageRouteInfo<void> {
  const NewPlaceRoute({List<_i13.PageRouteInfo>? children})
      : super(
          NewPlaceRoute.name,
          path: 'new_place',
          initialChildren: children,
        );

  static const String name = 'NewPlaceRoute';
}

/// generated route for
/// [_i11.NewPlaceCategoriesPage]
class NewPlaceCategoriesRoute extends _i13.PageRouteInfo<void> {
  const NewPlaceCategoriesRoute()
      : super(
          NewPlaceCategoriesRoute.name,
          path: 'categories',
        );

  static const String name = 'NewPlaceCategoriesRoute';
}

/// generated route for
/// [_i12.NewPlaceMapPage]
class NewPlaceMapRoute extends _i13.PageRouteInfo<void> {
  const NewPlaceMapRoute()
      : super(
          NewPlaceMapRoute.name,
          path: 'new_place_map',
        );

  static const String name = 'NewPlaceMapRoute';
}
