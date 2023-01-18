import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/map/di/map_scope.dart';
import 'package:flutter_guide/features/map/screens/map_model.dart';
import 'package:flutter_guide/features/map/screens/map_widget.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Widget model interface of [MapWidgetModel].
abstract class IMapWidgetModel extends IWidgetModel {
  /// Translated map page
  /// app bar title.
  String get mapText;

  /// State of objects located
  /// on the map.
  ListenableState<List<MapObject>> get mapObjectsState;

  /// Current selected by
  /// user place.
  ListenableState<Place?> get selectedPlaceState;

  /// Handles map creation
  /// and saves given [controller].
  void onMapCreated(YandexMapController controller);

  /// What happens on refresh
  /// places button tap.
  void onRefreshButtonTap();

  /// What happens on refresh
  /// user location button tap.
  void onRefreshPositionTap();
}

/// Widget model for [MapWidget].
class MapWidgetModel extends WidgetModel<MapWidget, MapModel>
    implements IMapWidgetModel {
  final _mapObjectsState = StateNotifier<List<MapObject>>(initValue: []);

  final _selectedPlaceState = StateNotifier<Place?>();

  late final Listenable _mapObjectsMapper;

  @override
  ListenableState<Place?> get selectedPlaceState => _selectedPlaceState;

  @override
  ListenableState<List<MapObject>> get mapObjectsState => _mapObjectsState;

  @override
  String get mapText => AppTranslations.of(context).map;

  YandexMapController? _yandexMapController;

  /// Constructor for [MapWidgetModel].
  MapWidgetModel(MapModel model) : super(model);

  @override
  void initWidgetModel() {
    _mapObjectsMapper = Listenable.merge([
      model.foundPlacesListState,
      model.locationState,
      _selectedPlaceState,
    ]);

    _mapObjectsMapper.addListener(_refreshMapObjects);

    model.locationState.addListener(_moveMapCameraToCurrentLocation);

    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();

    model.locationState.removeListener(_moveMapCameraToCurrentLocation);

    _mapObjectsMapper.removeListener(_refreshMapObjects);
  }

  @override
  void onMapCreated(YandexMapController controller) {
    _yandexMapController = controller;
  }

  @override
  void onRefreshButtonTap() {
    _mapObjectsState.accept([]);

    _selectedPlaceState.accept(null);

    model.requestPlaces();
  }

  @override
  Future<void> onRefreshPositionTap() async {
    await model.requestLocation();

    _moveMapCameraToCurrentLocation();
  }

  void _refreshMapObjects() {
    final loadedPlaces = model.foundPlacesListState.value!.data!;

    final selectedPlace = _selectedPlaceState.value;

    final currentLocation = model.locationState.value;

    _mapObjectsState.accept(
      <MapObject>[
        if (currentLocation != null)
          PlacemarkMapObject(
            mapId: const MapObjectId('MAIN_ROUTE_MAP'),
            point: currentLocation,
            icon: _getIconFromAssets('assets/images/user_point.png'),
            opacity: 1,
          ),
        for (final place in loadedPlaces)
          PlacemarkMapObject(
            mapId: MapObjectId('place_mark_${place.hashCode}'),
            point: place.point,
            icon: _getIconFromAssets('assets/images/place_point.png'),
            onTap: (mapObject, point) => _selectedPlaceState.accept(place),
            opacity: 1,
            zIndex: 2,
          ),
        if (selectedPlace != null)
          PlacemarkMapObject(
            mapId: const MapObjectId('selected_place'),
            point: selectedPlace.point,
            icon: _getIconFromAssets('assets/images/selected_place_point.png'),
            opacity: 1,
            zIndex: 3,
          ),
      ],
    );
  }

  void _moveMapCameraToCurrentLocation() {
    final currentLocation = model.locationState.value;

    if (currentLocation != null) {
      _yandexMapController?.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: currentLocation,
          ),
        ),
      );
    }
  }

  PlacemarkIcon _getIconFromAssets(String assetPath) => PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            assetPath,
          ),
          scale: 3,
        ),
      );
}

/// Default factory for [MapWidgetModel]
MapWidgetModel defaultMapWidgetModelFactory(BuildContext context) {
  final mapScope = Provider.of<IMapScope>(context);

  return MapWidgetModel(
    MapModel(
      mapScope.placesListRepository,
      mapScope.locationRepository,
    ),
  );
}
