import 'package:dio/dio.dart';
import 'package:flutter_guide/api/service/places_list/places_list_api.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';

/// Dependencies required for
/// places_list feature.
abstract class IPlacesListScope {
  /// Repository with all features
  /// connected with list of places.
  IPlacesListRepository get repository;
}

/// Dependencies required for
/// places_list feature.
class PlacesListScope extends IPlacesListScope {
  final Dio _dio;

  @override
  IPlacesListRepository get repository => PlacesListRepository(
        PlacesListApi(_dio),
      );

  /// Constructor for [PlacesListScope].
  PlacesListScope(this._dio);
}
