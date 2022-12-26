import 'package:flutter/animation.dart';

/// Types of places.
enum PlaceType {
  /// Cafe.
  cafe,

  /// Restaurant.
  restaurant,

  /// Museum.
  museum,

  /// Monument.
  monument,

  /// Temple.
  temple,

  /// Park.
  park,

  /// Theatre.
  theatre,

  /// Hotel.
  hotel,

  /// Unspecified.
  other,
}

/// Model holding data about
/// particular place.
class Place {
  /// ID of this place, with
  /// which the place can be accessed
  /// for interactivity (update, delete)
  final int id;

  /// Current location of this
  /// place on global map.
  ///
  /// Note: now it is [Offset],
  /// but will be changed to entity
  /// from one of the map packages
  final Offset location;

  /// Name of this place.
  final String name;

  /// A list of pictures attached to
  /// the place.
  final List<String> urls;

  /// Type of this place
  /// (see [PlaceType])
  final PlaceType placeType;

  /// Description of this place.
  final String description;

  /// Initialization.
  const Place({
    required this.id,
    required this.location,
    required this.placeType,
    required this.name,
    required this.description,
    required this.urls,
  });
}
