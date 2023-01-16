import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/places_list/domain/repository/image_repository.dart';
import 'package:flutter_guide/features/places_list/domain/repository/places_list_repository.dart';
import 'package:flutter_guide/util/default_error_handler.dart';
import 'package:image_picker/image_picker.dart';

/// Elementary model for `NewPlacePage`
class NewPlaceModel extends ElementaryModel {
  /// Whether creating new place is enabled,
  /// AKA, whether all necessary data is inputted.
  final creationEnabledState = StateNotifier<bool>(initValue: false);

  /// Current list of attached to
  /// this place images.
  final selectedImagesState = EntityStateNotifier<List<File>>.value([]);

  /// Current place type selected from
  /// category input.
  final selectedPlaceTypeState = StateNotifier<PlaceType?>();

  final _title = StateNotifier(initValue: '');

  final _description = StateNotifier(initValue: '');

  final _latitude = StateNotifier<double>();

  final _longitude = StateNotifier<double>();

  late final Listenable _validationStream;

  final ImageRepositoryInterface _imageRepository;

  final IPlacesListRepository _placesListRepository;

  /// Constructor for [NewPlaceModel].
  NewPlaceModel(
    this._imageRepository,
    this._placesListRepository,
  ) : super(
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

  /// Loads new image to [selectedImagesState]
  /// from [source].
  Future<void> selectNewImage(ImageSource source) async {
    try {
      final result = await _imageRepository.loadImage(source);

      if (result != null) {
        selectedImagesState.content(
          [
            ...selectedImagesState.value!.data!,
            result,
          ],
        );
      }
    } on Exception catch (e) {
      selectedImagesState.error(e);
    }
  }

  /// Deletes selected image at
  /// given [index] from [selectedImagesState]
  void deleteImage(int index) {
    final newList = List.of(selectedImagesState.value!.data!)..removeAt(index);

    selectedImagesState.content(newList);
  }

  /// Accepts new [type] into [selectedPlaceTypeState].
  void selectNewType(PlaceType type) {
    selectedPlaceTypeState.accept(type);
  }

  /// Collects all data and sends
  /// it to backend in order
  /// to create new place.
  Future<void> createPlace() async => _placesListRepository.createNewPlace(
        name: _title.value!,
        description: _description.value!,
        files: selectedImagesState.value!.data!,
        latitude: _latitude.value!,
        longitude: _longitude.value!,
        placeType: selectedPlaceTypeState.value!,
      );

  void _validate() => creationEnabledState.accept(
        _title.value!.isNotEmpty &&
            _description.value!.isNotEmpty &&
            _latitude.value != null &&
            _longitude.value != null &&
            selectedImagesState.value!.data!.isNotEmpty &&
            selectedPlaceTypeState.value != null,
      );
}
