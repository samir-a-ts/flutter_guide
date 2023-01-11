/// Types of places.
enum PlaceType {
  /// Hotel.
  hotel,

  /// Restaurant.
  restaurant,

  /// Unspecified.
  other,

  /// Park.
  park,

  /// Museum.
  museum,

  /// Cafe.
  cafe;

  @override
  String toString() {
    switch (this) {
      case PlaceType.cafe:
        return 'cafe';
      case PlaceType.restaurant:
        return 'restaurant';
      case PlaceType.museum:
        return 'museum';
      case PlaceType.park:
        return 'park';
      case PlaceType.hotel:
        return 'hotel';
      case PlaceType.other:
        return 'other';
    }
  }
}

/// Model holding data about
/// particular place.
class Place {
  /// ID of this place, with
  /// which the place can be accessed
  /// for interactivity (update, delete)
  final int id;

  /// Current latitude of
  /// location of this
  /// place on global map.
  final double latitude;

  /// Current longitude of
  /// location of this
  /// place on global map.
  final double longitude;

  // ignore: public_member_api_docs
  final String name;

  /// A list of pictures attached to
  /// the place.
  final List<String> images;

  /// Type of this place
  /// (see [PlaceType])
  final PlaceType placeType;

  /// Description of this place.
  final String description;

  /// Constructor for [Place].
  const Place({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.placeType,
    required this.name,
    required this.description,
    required this.images,
  });

  /// Reads all field of place JSON object
  /// and creates new one.
  Place.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        latitude = map['lat'] as double,
        longitude = map['lng'] as double,
        name = map['name'] as String,
        images = List<String>.from((map['urls'] as List?) ?? <String>[]),
        placeType = _fromString(map['placeType'] as String),
        description = map['description'] as String;

  static PlaceType _fromString(String type) {
    switch (type) {
      case 'cafe':
        return PlaceType.cafe;
      case 'restaurant':
        return PlaceType.restaurant;
      case 'museum':
        return PlaceType.museum;
      case 'park':
        return PlaceType.park;
      case 'hotel':
        return PlaceType.hotel;
    }

    return PlaceType.other;
  }
}
