import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/entity/location.dart';

/// Filter options, that will be
/// returned from filter page and
/// applied to places list page.
class PlacesFilterParameters {
  /// Chosen places types.
  final List<PlaceType> types;

  /// To which radius (in km) from
  /// [location] places to show.
  final double range;

  /// Current user position
  /// on the world's map.
  final Location location;

  /// Whether the filter is not
  /// filled up with any data.
  bool get isEmpty => types.isEmpty || range == 0.0;

  /// Constructor for [PlacesFilterParameters]
  PlacesFilterParameters({
    required this.location,
    this.types = const [],
    this.range = 0,
  });

  /// Creates instance with guaranteed
  /// [isEmpty] true.
  PlacesFilterParameters.empty()
      : location = const Location(0, 0),
        range = 0,
        types = const [];
}
