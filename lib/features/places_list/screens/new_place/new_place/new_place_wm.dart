import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/domain/entities/location.dart';
import 'package:flutter_guide/features/navigation/service/app_router.gr.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/new_place/new_place_model.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/new_place/new_place_widget.dart';
import 'package:flutter_guide/features/places_list/widgets/image_source_pick_dialog.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

/// Elementary widget model for [NewPlacePage]
abstract class INewPlaceWidgetModel extends IWidgetModel {
  /// Current list of attached to
  /// this place images.
  ListenableState<EntityState<List<File>>> get selectedImagesState;

  /// Current place type selected from
  /// category input.
  ListenableState<PlaceType?> get selectedPlaceTypeState;

  /// Whether creating new place is enabled,
  /// AKA, whether all necessary data is inputted.
  ListenableState<bool> get creationEnabledState;

  /// Translated page app bar title text.
  String get newPlaceText;

  /// Translated text on [cancel]
  /// text button.
  String get cancelButtonText;

  /// Translated category label
  /// text for category input.
  String get categoryLabelText;

  /// Translated title input label text.
  String get titleLabelText;

  /// Translated title of text button
  /// of to-map navigating.
  String get searchOnMapText;

  /// Translated title of text button
  /// of new place creating.
  String get createButtonText;

  /// Translated title of a
  /// new place's description text field.
  String get descriptionLabelText;

  /// Color, in which [cancel]
  /// text button's text will
  /// be painted in.
  Color get cancelButtonColor;

  /// Controller of new place title
  /// text field.
  TextEditingController get placeTitleFieldController;

  /// Controller of new place description
  /// text field.
  TextEditingController get placeDescriptionFieldController;

  /// Controller of new place
  /// position latitude text field.
  TextEditingController get latitudeFieldController;

  /// Controller of new place
  /// position longitude text field.
  TextEditingController get longitudeFieldController;

  /// Returns to places list page
  /// without creating a new one.
  void cancel();

  /// Through pop-up, selects
  /// and adds new page to the
  /// [selectedImagesState].
  void selectNewImage();

  /// Deletes image at given [index]
  /// from [selectedImagesState].
  void deleteImage(int index);

  /// Navigates to other page
  /// for new type selection.
  void selectNewType();

  /// Pops to map page, on which
  /// place on the map will be selected.
  void findPlaceOnMap();

  /// Clears text from title text field.
  void clearTitleField();

  /// Clears text from latitude text field.
  void clearLatitudeField();

  /// Clears text from longitude text field.
  void clearLongitudeField();

  /// Clears text from description text field.
  void clearDescriptionField();

  /// Sends request for place creation
  /// with all data inputted.
  void createPlace();
}

/// Elementary widget model implementation for [NewPlacePage]
class NewPlaceWidgetModel extends WidgetModel<NewPlacePage, NewPlaceModel>
    implements INewPlaceWidgetModel {
  final _titleController = TextEditingController();

  final _latitudeController = TextEditingController();

  final _longitudeController = TextEditingController();

  final _descriptionController = TextEditingController();

  late final Listenable _controllerChanges;

  @override
  ListenableState<bool> get creationEnabledState => model.creationEnabledState;

  @override
  ListenableState<EntityState<List<File>>> get selectedImagesState =>
      model.selectedImagesState;

  @override
  ListenableState<PlaceType?> get selectedPlaceTypeState =>
      model.selectedPlaceTypeState;

  @override
  String get cancelButtonText => AppTranslations.of(context).cancel;

  @override
  String get categoryLabelText => AppTranslations.of(context).category;

  @override
  String get createButtonText => AppTranslations.of(context).create;

  @override
  String get descriptionLabelText => AppTranslations.of(context).description;

  @override
  String get newPlaceText => AppTranslations.of(context).newPlace;

  @override
  String get searchOnMapText => AppTranslations.of(context).searchOnMap;

  @override
  String get titleLabelText => AppTranslations.of(context).title;

  @override
  Color get cancelButtonColor => AppTheme.of(context).thirdColor;

  @override
  TextEditingController get latitudeFieldController => _latitudeController;

  @override
  TextEditingController get longitudeFieldController => _longitudeController;

  @override
  TextEditingController get placeDescriptionFieldController =>
      _descriptionController;

  @override
  TextEditingController get placeTitleFieldController => _titleController;

  /// Constructor for [NewPlaceWidgetModel].
  NewPlaceWidgetModel(NewPlaceModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    selectedImagesState.addListener(_errorHandler);

    _controllerChanges = Listenable.merge(
      [
        _titleController,
        _descriptionController,
        _longitudeController,
        _latitudeController,
      ],
    );

    _controllerChanges.addListener(_updateFields);
  }

  @override
  void dispose() {
    selectedImagesState.removeListener(_errorHandler);

    _controllerChanges.removeListener(_updateFields);

    _titleController.dispose();

    _descriptionController.dispose();

    _longitudeController.dispose();

    _latitudeController.dispose();

    super.dispose();
  }

  @override
  void clearDescriptionField() => _descriptionController.text = '';

  @override
  void clearLatitudeField() => _latitudeController.text = '';

  @override
  void clearLongitudeField() => _longitudeController.text = '';

  @override
  void clearTitleField() => _titleController.text = '';

  @override
  Future<void> findPlaceOnMap() async {
    final location = await AutoRouter.of(context).push<Location>(
      const NewPlaceMapRoute(),
    );

    if (location != null) {
      model
        ..setLatitude(location.latitude.toString())
        ..setLongitude(location.longitude.toString());

      _latitudeController.text = location.latitude.toString();
      _longitudeController.text = location.longitude.toString();
    }
  }

  @override
  Future<void> selectNewImage() async {
    final result = await showModalBottomSheet<ImageSource?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ImageSourcePickDialog(),
    );

    if (result != null) {
      await model.selectNewImage(result);
    }
  }

  @override
  void deleteImage(int index) => model.deleteImage(index);

  @override
  Future<void> selectNewType() async {
    final result = await AutoRouter.of(context).push<PlaceType>(
      NewPlaceCategoriesRoute(
        initialType: selectedPlaceTypeState.value,
      ),
    );

    if (result != null) {
      model.selectNewType(result);
    }
  }

  @override
  void cancel() => _navigateBack();

  @override
  Future<void> createPlace() async {
    _showLoadingSnackbar();

    final result = await model.createPlace();

    _hideSnackBar();

    if (!result) {
      _showErrorSnackbar();

      return;
    }

    _showSuccessSnackbar();

    _navigateBack();
  }

  void _updateFields() => model
    ..setTitle(_titleController.text)
    ..setDescription(_descriptionController.text)
    ..setLatitude(_latitudeController.text)
    ..setLongitude(_longitudeController.text);

  void _errorHandler() {
    if (selectedImagesState.value!.hasError) {
      _showErrorSnackbar();
    }
  }

  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).errorColor,
        content: Text(
          AppTranslations.of(context).error,
          style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
                color: Theme.of(context).backgroundColor,
              ),
        ),
      ),
    );
  }

  void _showLoadingSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).disabledColor,
        content: Text(
          AppTranslations.of(context).loading,
          style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
                color: Theme.of(context).backgroundColor,
              ),
        ),
      ),
    );
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          AppTranslations.of(context).success,
          style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
                color: Theme.of(context).backgroundColor,
              ),
        ),
      ),
    );
  }

  void _navigateBack() => AutoRouter.of(context).popForced();

  void _hideSnackBar() => ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
