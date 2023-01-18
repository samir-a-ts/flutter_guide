import 'package:dio/dio.dart';
import 'package:flutter_guide/api/service/places_list/places_list_api.dart';
import 'package:flutter_guide/common/domain/repository/location_repository.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';

/// Interface holding
/// all map module required
/// dependencies.
abstract class IMapScope {
  /// Repository for requesting
  /// list of places.
  IPlacesListRepository get placesListRepository;

  /// Repository for managing
  /// access to current user's location.
  ILocationRepository get locationRepository;
}

/// Implementation of [IMapScope].
class MapScope extends IMapScope {
  final Dio _dio;

  late final IPlacesListRepository _placesListRepository;

  final _locationRepository = LocationRepository();

  @override
  IPlacesListRepository get placesListRepository => _placesListRepository;

  @override
  ILocationRepository get locationRepository => _locationRepository;

  /// Constructor for [MapScope]
  MapScope(this._dio) {
    _placesListRepository = PlacesListRepository(
      PlacesListApi(_dio),
    );
  }
}
