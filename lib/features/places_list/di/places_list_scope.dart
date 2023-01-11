import 'package:dio/dio.dart';
import 'package:flutter_guide/api/service/places_list/places_list_api.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_search_cache_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Dependencies required for
/// places_list feature.
abstract class IPlacesListScope {
  /// Repository with all features
  /// connected with list of places.
  IPlacesListRepository get placesRepository;

  /// Repository with all features
  /// connected with list of places.
  IPlacesSearchCacheRepository get placesSearchCacheRepository;
}

/// Dependencies required for
/// places_list feature.
class PlacesListScope extends IPlacesListScope {
  final Dio _dio;

  final SharedPreferences _sharedPreferences;

  late final IPlacesListRepository _placesRepository;

  late final IPlacesSearchCacheRepository _placesSearchCacheRepository;

  @override
  IPlacesListRepository get placesRepository => _placesRepository;

  @override
  IPlacesSearchCacheRepository get placesSearchCacheRepository =>
      _placesSearchCacheRepository;

  /// Constructor for [PlacesListScope].
  PlacesListScope(this._dio, this._sharedPreferences) {
    _placesRepository = PlacesListRepository(
      PlacesListApi(_dio),
    );

    _placesSearchCacheRepository =
        PlacesSearchCacheRepository(_sharedPreferences);
  }
}
