import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_bar_trailing_button.dart';
import 'package:flutter_guide/common/widgets/app_bottom_button.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/common/widgets/label.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/new_place/new_place_model.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/new_place/new_place_wm.dart';

/// Default factory for [NewPlaceWidgetModel].
NewPlaceWidgetModel defaultNewPlaceWidgetModelFactory(BuildContext context) {
  return NewPlaceWidgetModel(
    NewPlaceModel(),
  );
}

/// Widget for new place creation feature.
class NewPlacePage extends ElementaryWidget<INewPlaceWidgetModel> {
  /// Constructor for [NewPlacePage]
  const NewPlacePage({
    Key? key,
    WidgetModelFactory wmFactory = defaultNewPlaceWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(INewPlaceWidgetModel wm) {
    return AutoRouter(
      placeholder: (context) => Scaffold(
        appBar: MainAppBar(
          title: wm.newPlaceText,
          leading: AppTextButton(
            onTap: wm.cancel,
            text: wm.cancelButtonText,
            color: wm.cancelButtonColor,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StateNotifierBuilder(
                listenableState: wm.selectedImagesState,
                builder: (context, images) {
                  return _ImagePicker(
                    images: images!,
                    onAdd: wm.selectNewImage,
                    onDelete: wm.deleteImage,
                  );
                },
              ),
              const Gap(dimension: 24),
              Label(labelText: wm.categoryLabelText),
              StateNotifierBuilder(
                listenableState: wm.selectedPlaceTypeState,
                builder: (context, placeType) {
                  return _PlaceTypePicker(
                    placeType: placeType,
                    onSelect: wm.selectNewType,
                  );
                },
              ),
              const Gap(dimension: 24),
              Label(labelText: wm.titleLabelText),
              const Gap(dimension: 12),
              NewPlaceTextField(
                controller: wm.placeTitleFieldController,
                onClear: wm.clearTitleField,
              ),
              const Gap(dimension: 24),
              _LocationInputsWidget(
                latitudeController: wm.latitudeFieldController,
                longitudeController: wm.longitudeFieldController,
                onLatitudeClear: wm.clearLatitudeField,
                onLongitudeClear: wm.clearLongitudeField,
              ),
              const Gap(dimension: 15),
              AppTextButton(
                onTap: wm.findPlaceOnMap,
                text: wm.searchOnMapText,
              ),
              const Gap(dimension: 37),
              Label(labelText: wm.descriptionLabelText),
              const Gap(dimension: 12),
              NewPlaceTextField(
                controller: wm.placeDescriptionFieldController,
                onClear: wm.clearDescriptionField,
                lines: 4,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: StateNotifierBuilder(
                    listenableState: wm.creationEnabledState,
                    builder: (context, enabled) => AppBottomButton(
                      buttonType: enabled!
                          ? AppBottomButtonType.primary
                          : AppBottomButtonType.disabled,
                      onTap: wm.createPlace,
                      text: wm.createButtonText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ImagePicker extends StatelessWidget {
  final List<ImageProvider> images;

  final VoidCallback onAdd;

  final ValueChanged<int> onDelete;

  const _ImagePicker({
    required this.images,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _AddImageButton(onAdd: onAdd),
        for (var i = 0; i < images.length; i++)
          _ImagePickerTile(
            image: images[i],
            onDeleteButtonTap: () => onDelete(i),
          ),
      ],
    );
  }
}

class _AddImageButton extends StatelessWidget {
  final VoidCallback onAdd;

  const _AddImageButton({required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAdd,
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(.48),
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 17,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class _ImagePickerTile extends StatelessWidget {
  final ImageProvider image;

  final VoidCallback onDeleteButtonTap;

  const _ImagePickerTile({
    required this.image,
    required this.onDeleteButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: GestureDetector(
            onTap: onDeleteButtonTap,
            child: Icon(
              Icons.cancel,
              size: 8,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}
