import 'package:elementary/elementary.dart';
import 'package:flutter_guide/features/places_list/domain/entity/location.dart';
import 'package:flutter_guide/features/places_list/domain/repository/geolocation_repository.dart';
import 'package:flutter_guide/util/default_error_handler.dart';
import 'package:geolocator/geolocator.dart';

/// Model for `PlacesFilterPage`
class PlacesFilterModel extends ElementaryModel {
  /// State of user current location.
  final userLocationState = EntityStateNotifier<Location?>();

  final ILocationRepository _locationRepository;

  /// Constructor for [PlacesFilterModel]
  PlacesFilterModel(this._locationRepository)
      : super(
          errorHandler: DefaultErrorHandler(),
        );

  /// Requests current user's location.
  /// If location permission is not granted,
  /// Location(30, 30) is returned. Otherwise,
  /// it is an error state.
  Future<void> requestLocation() async {
    userLocationState.loading();

    try {
      final result = await _locationRepository.requestLocation();

      userLocationState.content(
        Location.fromPosition(result),
      );
    } on LocationPermissionNotGrantedException {
      /// Placeholder
      userLocationState.content(
        const Location(30, 30),
      );
    } on Exception catch (_) {
      userLocationState.error();
    }
  }
}
