import 'dart:io';

import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/api/service/places_list/places_list_api.dart';

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
    List<PlaceType> types,
    String? name,
  });

  /// Uploads given [files]
  /// and creates new place on the backend
  /// with given params.
  Future<void> createNewPlace({
    required double latitude,
    required double longitude,
    required String name,
    required String description,
    required PlaceType placeType,
    required List<File> files,
  });
}

/// Links API with feature.
class PlacesListRepository implements IPlacesListRepository {
  final PlacesListApi _api;

  /// Constructor for [PlacesListRepository].
  PlacesListRepository(this._api);

  /// Returns places with pagination.
  @override
  Future<List<Place>> getAllPlaces(
    int page, [
    int recordsPerPage = 10,
  ]) =>
      _api.getAllPlaces(page, recordsPerPage);

  /// Filters all places and returns them.
  @override
  Future<List<Place>> getFilteredPlaces({
    double? latitude,
    double? longitude,
    double? radius,
    List<PlaceType> types = const [],
    String? name,
  }) =>
      _api.getFilteredPlaces(
        latitude: latitude,
        longitude: longitude,
        name: name,
        radius: radius,
        types: types.map((e) => e.toString()).toList(),
      );

  @override
  Future<void> createNewPlace({
    required double latitude,
    required double longitude,
    required String name,
    required String description,
    required PlaceType placeType,
    required List<File> files,
  }) async {
    final urls = _api.uploadFiles(files);

    return _api.createNewPlace(
      latitude: latitude,
      longitude: longitude,
      name: name,
      description: description,
      placeType: placeType.toString(),
      urls: urls,
    );
  }
}
