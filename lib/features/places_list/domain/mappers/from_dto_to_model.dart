import 'package:flutter/animation.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/entity/place.dart';

/// Mapper from [PlaceDto] to [Place].
abstract class PlaceMapper {
  /// Main method.
  static Place fromDto(PlaceDto dto) => Place(
        id: dto.id,
        location: Offset(dto.latitude, dto.longitude),
        placeType: _fromString(dto.placeType),
        name: dto.name,
        description: dto.description,
        urls: dto.urls,
      );

  static PlaceType _fromString(String type) {
    switch (type) {
      case 'cafe':
        return PlaceType.cafe;
      case 'restaurant':
        return PlaceType.restaurant;
      case 'museum':
        return PlaceType.museum;
      case 'monument':
        return PlaceType.monument;
      case 'temple':
        return PlaceType.temple;
      case 'park':
        return PlaceType.park;
      case 'theatre':
        return PlaceType.theatre;
      case 'hotel':
        return PlaceType.hotel;
    }

    return PlaceType.other;
  }
}
