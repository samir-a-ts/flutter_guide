/// Raw representation of
/// Place model from API.
class PlaceDto {
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

  /// Name of this place.
  final String name;

  /// A list of pictures attached to
  /// the place.
  final List<String> urls;

  /// Type of this place.
  /// Might be cafe, restaurant,
  /// museum, monument, temple,
  /// park, theatre, hotel, other.
  final String placeType;

  /// Description of this place.
  final String description;

  /// Initialization.
  const PlaceDto({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  /// Reads all field of place JSON object
  /// and creates new one.
  PlaceDto.fromMap(Map<String, dynamic> map)
      : id = map['id'] as int,
        latitude = map['latitude'] as double,
        longitude = map['longitude'] as double,
        name = map['name'] as String,
        urls = List<String>.from(map['urls'] as List),
        placeType = map['placeType'] as String,
        description = map['description'] as String;
}
