import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/util/default_error_handler.dart';
import 'package:rxdart/rxdart.dart';

/// Elementary model for `NewPlacePage`
class NewPlaceModel extends ElementaryModel {
  /// Whether creating new place is enabled,
  /// AKA, whether all necessary data is inputted.
  final creationEnabledState = StateNotifier<bool>(initValue: false);

  /// Current list of attached to
  /// this place images.
  final selectedImagesState =
      StateNotifier<List<ImageProvider<Object>>>(initValue: []);

  /// Current place type selected from
  /// category input.
  final selectedPlaceTypeState = StateNotifier<PlaceType?>();

  final _title = StateNotifier(initValue: '');

  final _description = StateNotifier(initValue: '');

  final _latitude = StateNotifier<double>();

  final _longitude = StateNotifier<double>();

  late final Listenable _validationStream;

  /// Constructor for [NewPlaceModel].
  NewPlaceModel()
      : super(
          errorHandler: DefaultErrorHandler(),
        );

  @override
  void init() {
    _validationStream = Listenable.merge(
      [
        selectedImagesState,
        selectedPlaceTypeState,
        _title,
        _description,
        _latitude,
        _longitude,
      ],
    );

    _validationStream.addListener(_validate);
  }

  @override
  void dispose() {
    _validationStream.removeListener(_validate);

    super.dispose();
  }

  /// Writes given [title]
  /// into [_title].
  // ignore: use_setters_to_change_properties
  void setTitle(String title) => _title.accept(title);

  /// Writes given [description]
  /// into [_description].
  // ignore: use_setters_to_change_properties
  void setDescription(String description) => _description.accept(description);

  /// Parses given [latitude] string
  /// into [double] and writes
  /// it to the [_latitude] latitude
  /// field.
  void setLatitude(String latitude) {
    final latNumber = double.tryParse(latitude);

    _latitude.accept(latNumber);
  }

  /// Parses given [longitude] string
  /// into [double] and writes
  /// it to the [_longitude] longitude
  /// field.
  void setLongitude(String longitude) {
    final longNumber = double.tryParse(longitude);

    _longitude.accept(longNumber);
  }

  void _validate() => creationEnabledState.accept(
        _title.value!.isNotEmpty &&
            _description.value!.isNotEmpty &&
            _latitude.value != null &&
            _longitude.value != null &&
            selectedImagesState.value!.isNotEmpty &&
            selectedPlaceTypeState.value != null,
      );
}
