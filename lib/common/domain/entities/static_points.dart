import 'package:geolocator/geolocator.dart' show Position;
import 'package:yandex_mapkit/yandex_mapkit.dart' show Point;

/// Pre-defined locations
/// within the [Point].
abstract class PointHelper {
  /// Maps [Position] to
  /// the [Point] object.
  static Point fromPosition(Position position) => Point(
        latitude: position.latitude,
        longitude: position.longitude,
      );

  /// Location of the Moscow.
  static Point moscow() => const Point(
        latitude: 55.75222,
        longitude: 37.61556,
      );
}
