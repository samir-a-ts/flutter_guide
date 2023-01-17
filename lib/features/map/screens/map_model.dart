import 'package:elementary/elementary.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/common/domain/entities/location.dart';
import 'package:flutter_guide/common/domain/repository/location_repository.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:flutter_guide/util/default_error_handler.dart';

/// Elementary model for Map module
class MapModel extends ElementaryModel {
  /// State of loaded places.
  final foundPlacesListState = EntityStateNotifier<List<Place>>.value(const []);

  /// State of current user's location.
  final locationState = StateNotifier<Location?>();

  final IPlacesListRepository _placesListRepository;

  final ILocationRepository _locationRepository;

  /// Constructor for [MapModel]
  MapModel(
    this._placesListRepository,
    this._locationRepository,
  ) : super(
          errorHandler: DefaultErrorHandler(),
        );

  @override
  Future<void> init() async {
    await _requestLocation();

    await requestPlaces();
  }

  /// Requests a list of places
  /// within 30 kilometers from
  /// current [locationState].
  Future<void> requestPlaces() async {
    final previousData = foundPlacesListState.value!.data!;

    foundPlacesListState.loading(previousData);

    try {
      final places = await _placesListRepository.getFilteredPlaces(
        latitude: locationState.value!.latitude,
        longitude: locationState.value!.longitude,
        radius: 30,
      );

      foundPlacesListState.content(places);
    } on Exception catch (e) {
      foundPlacesListState.error(e, previousData);
    }
  }

  Future<void> _requestLocation() async {
    try {
      final permissionGranted = await _locationRepository.requestPermission();

      if (!permissionGranted) {
        return locationState.accept(
          StaticLocations.moscow(),
        );
      }

      final position = await _locationRepository.requestLocation();

      locationState.accept(
        Location.fromPosition(position),
      );
    } on Exception {
      locationState.accept(
        StaticLocations.moscow(),
      );
    }
  }
}
