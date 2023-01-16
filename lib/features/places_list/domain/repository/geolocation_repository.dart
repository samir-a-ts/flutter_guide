import 'package:geolocator/geolocator.dart';

/// Repository for requesting
/// current user position in the world's map.
// ignore: one_member_abstracts
abstract class ILocationRepository {
  /// Gets current user location from phone.

  Future<Position> requestLocation();

  /// Checks whether it is allowed
  /// to access user's current location
  /// or not.
  Future<bool> requestPermission();
}

/// Implementation for [ILocationRepository]
class LocationRepository implements ILocationRepository {
  /// Constructor for [LocationRepository].
  LocationRepository();

  @override
  Future<Position> requestLocation() => Geolocator.getCurrentPosition();

  @override
  Future<bool> requestPermission() async {
    final result = await Geolocator.requestPermission();

    return result == LocationPermission.always ||
        result == LocationPermission.whileInUse;
  }
}
