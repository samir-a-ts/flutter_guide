import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/api/service/places_list/places_list_api.dart';
import 'package:flutter_guide/features/places_list/domain/entity/place.dart';
import 'package:flutter_guide/features/places_list/domain/mappers/from_dto_to_model.dart';

/// Links API with feature.

abstract class IPlacesListRepository {
  /// Returns places with pagination.

  Future<List<Place>> getAllPlaces(
    int page, [
    int recordsPerPage = 10,
  ]);

  /// Filters all places and returns them.

  Future<List<Place>> getFilteredPlaces({
    double? latitude,
    double? longitude,
    double? radius,
    List<String>? types,
    String? name,
  });
}

/// Links API with feature.
class PlacesListRepository implements IPlacesListRepository {
  final PlacesListApi _api;

  /// Initialization.
  PlacesListRepository(this._api);

  /// Returns places with pagination.
  @override
  Future<List<Place>> getAllPlaces(
    int page, [
    int recordsPerPage = 10,
  ]) async {
    final request = await _api.getAllPlaces(page, recordsPerPage);

    return _processRequest(request);
  }

  /// Filters all places and returns them.
  @override
  Future<List<Place>> getFilteredPlaces({
    double? latitude,
    double? longitude,
    double? radius,
    List<String>? types,
    String? name,
  }) async {
    final request = await _api.getFilteredPlaces(
      latitude: latitude,
      longitude: longitude,
      name: name,
      radius: radius,
      types: types,
    );

    return _processRequest(request);
  }

  List<Place> _processRequest(List<PlaceDto> placesObjects) {
    final places = placesObjects
        .map(
          PlaceMapper.fromDto,
        )
        .toList();

    return places;
  }
}
