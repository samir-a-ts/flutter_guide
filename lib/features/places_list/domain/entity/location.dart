import 'package:geolocator/geolocator.dart';

/// Represents particular point
/// at the world map.
class Location {
  /// Latitude of point on
  /// world map.
  final double latitude;

  /// Longitude of point on
  /// world map.
  final double longitude;

  /// Constructor for [Location]
  const Location(
    this.latitude,
    this.longitude,
  );

  /// Creates instance with
  /// data from [position].
  Location.fromPosition(Position position)
      : latitude = position.latitude,
        longitude = position.longitude;

  /// Copy current instance
  /// with replacing some fields.
  Location copyWith({
    double? latitude,
    double? longitude,
  }) =>
      Location(
        latitude ?? this.latitude,
        longitude ?? this.longitude,
      );
}
