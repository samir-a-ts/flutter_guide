import 'package:dio/dio.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';

/// Endpoints for this particular API.
abstract class _PlacesApiEndpoints {
  /// Pagination.
  static const placesPagination = '/place';

  /// Filter.
  static const placesFilter = '/filtered_places';
}

/// Service for requesting
/// and filtering a list of [PlaceDto]s.
class PlacesListApi {
  final Dio _dio;

  /// Initialization.
  PlacesListApi(this._dio);

  /// Returns places with pagination.
  Future<List<PlaceDto>> getAllPlaces(
    int page, [
    int recordsPerPage = 10,
  ]) async {
    final request = await _dio.get<dynamic>(
      _PlacesApiEndpoints.placesPagination,
      queryParameters: <String, int>{
        'count': recordsPerPage,
        'offset': page,
      },
    );

    return _processRequest(request);
  }

  /// Filters all places and returns them.
  Future<List<PlaceDto>> getFilteredPlaces({
    double? latitude,
    double? longitude,
    double? radius,
    List<String>? types,
    String? name,
  }) async {
    final data = <String, dynamic>{};

    if (latitude != null && longitude != null && radius != null) {
      data.addAll(
        <String, dynamic>{
          'lat': latitude,
          'lng': longitude,
          'radius': radius,
        },
      );
    }

    final request = await _dio.post<dynamic>(
      _PlacesApiEndpoints.placesFilter,
      data: data
        ..addAll(
          <String, dynamic>{
            'typeFilter': types,
            'nameFilter': name,
          },
        ),
    );

    return _processRequest(request);
  }

  List<PlaceDto> _processRequest(Response<dynamic> response) {
    if (response.statusCode != 200) {
      throw Exception(
        (response.data as Map<String, dynamic>)['error'] ??
            'Unexpected result code: ${response.statusCode}',
      );
    }

    final places = (response.data as List)
        .map(
          /// ignore: implicit_dynamic_parameter
          (value) => PlaceDto.fromMap(
            value as Map<String, dynamic>,
          ),
        )
        .toList();

    return places;
  }
}
