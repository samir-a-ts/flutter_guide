import 'package:elementary/elementary.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/common/domain/entities/static_points.dart';
import 'package:flutter_guide/common/domain/repository/location_repository.dart';
import 'package:flutter_guide/features/places_list/domain/entity/places_filter_parameters.dart';
import 'package:flutter_guide/util/default_error_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart' show Point;

/// Model for `PlacesFilterPage`
class PlacesFilterModel extends ElementaryModel {
  /// State of user current location.
  final userLocationState = EntityStateNotifier<Point?>();

  /// State of selected on filter places types.
  final filterPlacesTypesState = StateNotifier<Set<PlaceType>>(initValue: {});

  /// State of selected on filter range of geo-search.
  final rangeState = StateNotifier<double>(initValue: 0.0);

  final ILocationRepository _locationRepository;

  /// Constructor for [PlacesFilterModel]
  PlacesFilterModel(this._locationRepository, {PlacesFilterParameters? initial})
      : super(
          errorHandler: DefaultErrorHandler(),
        ) {
    if (initial != null) {
      userLocationState.content(initial.location);

      filterPlacesTypesState.accept(initial.types.toSet());

      rangeState.accept(initial.range);
    }
  }

  @override
  void init() {
    _requestLocation();
  }

  /// Adds given [type] to the [filterPlacesTypesState].
  void chooseType(PlaceType type) {
    final previous = filterPlacesTypesState.value!;

    Set<PlaceType>? newTypes;

    if (previous.contains(type)) {
      newTypes = previous.difference({type});
    }

    newTypes ??= previous.union({type});

    filterPlacesTypesState.accept(newTypes);
  }

  /// Set ups the [range] to [rangeState].
  void setRange(double range) => rangeState.accept(range);

  /// Defaults all chosen filters.
  void clearFilter() {
    rangeState.accept(0.0);

    filterPlacesTypesState.accept({});
  }

  Future<void> _requestLocation() async {
    userLocationState.loading();

    try {
      final permissionGranted = await _locationRepository.requestPermission();

      if (!permissionGranted) {
        userLocationState.content(
          PointHelper.moscow(),
        );

        return;
      }

      final result = await _locationRepository.requestLocation();

      userLocationState.content(
        PointHelper.fromPosition(result),
      );
    } on Exception catch (_) {
      userLocationState.content(
        PointHelper.moscow(),
      );
    }
  }
}
