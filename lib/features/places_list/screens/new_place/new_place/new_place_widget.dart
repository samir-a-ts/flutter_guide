import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_bottom_button.dart';
import 'package:flutter_guide/common/widgets/app_divider.dart';
import 'package:flutter_guide/common/widgets/app_text_button.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/common/widgets/label.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/new_place/new_place_model.dart';
import 'package:flutter_guide/features/places_list/screens/new_place/new_place/new_place_wm.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';

/// Default factory for [NewPlaceWidgetModel].
NewPlaceWidgetModel defaultNewPlaceWidgetModelFactory(BuildContext context) {
  final placesListScope = Provider.of<IPlacesListScope>(context);

  return NewPlaceWidgetModel(
    NewPlaceModel(
      placesListScope.imageRepository,
      placesListScope.placesRepository,
    ),
  );
}

/// Widget for new place creation feature.
class NewPlacePage extends ElementaryWidget<INewPlaceWidgetModel> {
  /// Constructor for [NewPlacePage]
  const NewPlacePage({
    Key? key,
  }) : super(defaultNewPlaceWidgetModelFactory, key: key);

  @override
  Widget build(INewPlaceWidgetModel wm) {
    return AutoRouter(
      builder: (context, content) => content,
      placeholder: (context) => Scaffold(
        appBar: MainAppBar(
          title: wm.newPlaceText,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: AppTextButton(
                onTap: wm.cancel,
                text: wm.cancelButtonText,
                color: wm.cancelButtonColor,
              ),
            ),
          ),
        ),
        bottomNavigationBar: StateNotifierBuilder(
          listenableState: wm.creationEnabledState,
          builder: (context, enabled) => Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: AppBottomButton(
              buttonType: enabled!
                  ? AppBottomButtonType.primary
                  : AppBottomButtonType.disabled,
              onTap: wm.createPlace,
              text: wm.createButtonText,
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          children: [
            EntityStateNotifierBuilder(
              listenableEntityState: wm.selectedImagesState,
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
            const Gap(dimension: 14),
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
            _NewPlaceTextField(
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
            _NewPlaceTextField(
              controller: wm.placeDescriptionFieldController,
              onClear: wm.clearDescriptionField,
              lines: 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImagePicker extends StatelessWidget {
  final List<File> images;

  final VoidCallback onAdd;

  final ValueChanged<int> onDelete;

  const _ImagePicker({
    required this.images,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _AddImageButton(onAdd: onAdd),
          for (var i = 0; i < images.length; i++) ...[
            const Gap(dimension: 16),
            _ImagePickerTile(
              image: images[i],
              onDeleteButtonTap: () => onDelete(i),
            ),
          ],
        ],
      ),
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
            size: 50,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}

class _ImagePickerTile extends StatelessWidget {
  final File image;

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
          image: FileImage(image),
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
              size: 20,
              color: Theme.of(context).backgroundColor,
            ),
          ),
        ),
      ),
    );
  }
}

class _LocationInputsWidget extends StatelessWidget {
  final TextEditingController? latitudeController;

  final TextEditingController? longitudeController;

  final VoidCallback? onLatitudeClear;

  final VoidCallback? onLongitudeClear;

  const _LocationInputsWidget({
    this.latitudeController,
    this.longitudeController,
    this.onLatitudeClear,
    this.onLongitudeClear,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(
                  labelText: AppTranslations.of(context).latitude,
                ),
                const Gap(dimension: 12),
                _NewPlaceTextField(
                  controller: latitudeController,
                  onClear: onLatitudeClear,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          const Gap(dimension: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Label(
                  labelText: AppTranslations.of(context).longitude,
                ),
                const Gap(dimension: 12),
                _NewPlaceTextField(
                  controller: longitudeController,
                  onClear: onLongitudeClear,
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NewPlaceTextField extends StatelessWidget {
  final TextEditingController? controller;

  final VoidCallback? onClear;

  final int? lines;

  final TextInputType keyboardType;

  final _focus = FocusNode();

  _NewPlaceTextField({
    this.controller,
    this.onClear,
    this.lines,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: lines == null ? 40 : lines! * 40,
      child: TextField(
        controller: controller,
        focusNode: _focus,
        keyboardType: keyboardType,
        style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
              color: ThemeHelper.mainTextColor(context),
            ),
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
              width: 2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor.withOpacity(0.4),
            ),
          ),
          suffixIcon: lines != null
              ? const SizedBox()
              : AnimatedBuilder(
                  animation: _focus,
                  builder: (context, child) {
                    return _focus.hasFocus ? child! : const SizedBox();
                  },
                  child: IconButton(
                    onPressed: onClear,
                    icon: Icon(
                      Icons.cancel,
                      size: 20,
                      color: AppTheme.of(context).thirdColor,
                    ),
                  ),
                ),
        ),
        minLines: lines,
        maxLines: lines == null ? 1 : 4,
      ),
    );
  }
}

class _PlaceTypePicker extends StatelessWidget {
  final PlaceType? placeType;

  final VoidCallback? onSelect;

  const _PlaceTypePicker({
    this.placeType,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                placeType == null
                    ? AppTranslations.of(context).notChosen
                    : placeType!.translate(context),
                style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                      color: placeType == null
                          ? AppTheme.of(context).thirdColor
                          : ThemeHelper.mainTextColor(context),
                    ),
              ),
              Icon(
                Icons.chevron_right,
                size: 18,
                color: ThemeHelper.mainColor(context),
              ),
            ],
          ),
          const Gap(dimension: 14),
          const AppDivider(),
        ],
      ),
    );
  }
}
