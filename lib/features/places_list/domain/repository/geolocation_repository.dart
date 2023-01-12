import 'package:geolocator/geolocator.dart';

/// Repository for requesting
/// current user position in the world's map.
// ignore: one_member_abstracts
abstract class ILocationRepository {
  /// Gets current user location from phone.
  ///
  /// If permission is not granted
  /// by the user, throws [LocationPermissionNotGrantedException].
  Future<Position> requestLocation();
}

/// Implementation for [ILocationRepository]
class LocationRepository implements ILocationRepository {
  /// Constructor for [LocationRepository].
  LocationRepository();

  @override
  Future<Position> requestLocation() async {
    final permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return Geolocator.getCurrentPosition();
    }

    final permissionRequestResult = await Geolocator.requestPermission();

    if (permissionRequestResult == LocationPermission.always ||
        permissionRequestResult == LocationPermission.whileInUse) {
      return Geolocator.getCurrentPosition();
    }

    throw LocationPermissionNotGrantedException();
  }
}

/// In case of user not granting
/// the permission to it's location.
class LocationPermissionNotGrantedException implements Exception {}
