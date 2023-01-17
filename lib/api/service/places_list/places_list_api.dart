import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/config/app_config.dart';
import 'package:flutter_guide/config/environment/environment.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

/// Endpoints for this particular API.
abstract class _PlacesApiEndpoints {
  /// Pagination.
  static const placesPagination = '/place';

  /// Filter.
  static const placesFilter = '/filtered_places';

  /// File uploading endpoint.
  static const uploadFile = '/upload_file';
}

/// Service for requesting
/// and filtering a list of [Place]s.
class PlacesListApi {
  final Dio _dio;

  /// Constructor for [PlacesListApi].
  PlacesListApi(this._dio);

  /// Returns places with pagination.
  Future<List<Place>> getAllPlaces(
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
  ///
  /// Radius is in kilometers.
  Future<List<Place>> getFilteredPlaces({
    double? latitude,
    double? longitude,
    double? radius,
    List<String> types = const [],
    String? name,
  }) async {
    final data = <String, dynamic>{};

    if (latitude != null &&
        longitude != null &&
        radius != null &&
        types.isNotEmpty) {
      data.addAll(
        <String, dynamic>{
          'lat': latitude,
          'lng': longitude,
          'radius': radius * 1000,
          'typeFilter': types,
        },
      );
    }

    final request = await _dio.post<dynamic>(
      _PlacesApiEndpoints.placesFilter,
      data: data
        ..addAll(
          <String, dynamic>{
            'nameFilter': name,
          },
        ),
    );

    return _processRequest(request);
  }

  /// Takes all [files], uploads it to the server
  /// and returns a list of concrete file urls.
  Future<List<String>> uploadFiles(List<File> files) async {
    final multipartFiles = await Future.wait([
      for (final file in files)
        MultipartFile.fromFile(
          file.path,
          contentType: MediaType.parse(
            lookupMimeType(file.path)!,
          ),
        ),
    ]);

    final formData = FormData.fromMap(<String, dynamic>{
      for (final file in multipartFiles) file.filename!: file,
    });

    final request = await _dio.post<dynamic>(
      _PlacesApiEndpoints.uploadFile,
      data: formData,
      options: Options(
        contentType: 'multipart/form-data',
      ),
    );

    final dynamic result = request.data;

    if (result is String) {
      return [
        '${Environment<AppConfig>.instance().config.url}/$result',
      ];
    }

    return ((result as Map<String, dynamic>)['urls'] as List).map(
      // ignore: avoid_annotating_with_dynamic
      (dynamic e) {
        final apiPath = e as String;

        return '${Environment<AppConfig>.instance().config.url}/$apiPath';
      },
    ).toList();
  }

  /// Creates new place on the backend
  /// with given params.
  Future<void> createNewPlace({
    required double latitude,
    required double longitude,
    required String name,
    required String description,
    required String placeType,
    required List<String> urls,
  }) =>
      _dio.post<dynamic>(
        _PlacesApiEndpoints.placesPagination,
        data: <String, dynamic>{
          'lat': latitude,
          'lng': longitude,
          'name': name,
          'description': description,
          'placeType': placeType.toString(),
          'urls': urls,
        },
      );

  List<Place> _processRequest(Response<dynamic> response) {
    final places = (response.data as List)
        .map(
          /// ignore: implicit_dynamic_parameter
          (value) => Place.fromMap(
            value as Map<String, dynamic>,
          ),
        )
        .toList();

    return places;
  }
}
