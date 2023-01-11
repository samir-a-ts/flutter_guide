import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_bar_trailing_button.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/common/widgets/label.dart';
import 'package:flutter_guide/features/app/core/widgets/app_bottom_button.dart';
import 'package:flutter_guide/features/places_list/domain/entity/location.dart';
import 'package:flutter_guide/features/places_list/domain/repository/geolocation_repository.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_model.dart';
import 'package:flutter_guide/features/places_list/screens/filter/places_filter_wm.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Default factory for [PlacesFilterWidgetModel]
PlacesFilterWidgetModel defaultPlacesFilterWidgetModelFactory(
  BuildContext context,
) {
  return PlacesFilterWidgetModel(
    PlacesFilterModel(
      LocationRepository(),
    ),
  );
}

/// Widget for PlacesFilter module.
class PlacesFilterPage extends ElementaryWidget<IPlacesFilterWidgetModel> {
  /// Constructor for [PlacesFilterPage]
  const PlacesFilterPage({
    Key? key,
    WidgetModelFactory wmFactory = defaultPlacesFilterWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesFilterWidgetModel wm) {
    return WillPopScope(
      onWillPop: wm.returnToListWithoutFilter,
      child: Scaffold(
        appBar: MainAppBar(
          title: '',
          leading: IconButton(
            onPressed: wm.returnToListWithoutFilter,
            icon: const Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
          ),
          trailing: [
            AppBarTrailingButton(
              onTap: wm.clearFilter,
              title: wm.clearButtonText,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Label(
                labelText: wm.categoriesText,
              ),
              const Gap(dimension: 24),
              StateNotifierBuilder(
                listenableState: wm.filterPlacesTypesState,
                builder: (context, snapshot) {
                  return GridView.count(
                    crossAxisCount: 3,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      for (final type in PlaceType.values)
                        _PlaceTypeOption(
                          onTypeChosen: wm.chooseType,
                          icon: type.icon,
                          placeType: type,
                          isChosen: snapshot!.contains(type),
                        ),
                    ],
                  );
                },
              ),
              const Gap(dimension: 60),
              _FilterSliderLabel(wm.rangeState),
              StateNotifierBuilder(
                listenableState: wm.rangeState,
                builder: (context, snapshot) {
                  return Slider(
                    value: snapshot!,
                    activeColor: wm.sliderColor,
                    inactiveColor: wm.inactiveSliderPartColor,
                    onChanged: wm.setRange,
                    divisions: 3,
                    max: 30,
                  );
                },
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: EntityStateNotifierBuilder(
                    listenableEntityState: wm.userLocationState,
                    loadingBuilder: (context, data) {
                      return AppBottomButton(
                        onTap: () {},
                        text: wm.loadingText,
                        color: wm.disabledBottomButtonColor,
                      );
                    },
                    builder: (context, snapshot) {
                      return AppBottomButton(
                        onTap: wm.returnToListWithFilter,
                        text: wm.showButtonText,
                      );
                    },
                  ),
                ),
              ),
              const Gap(dimension: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class _FilterSliderLabel extends StatelessWidget {
  final ListenableState<double> rangeState;

  const _FilterSliderLabel(this.rangeState);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppTranslations.of(context).distance,
          style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
        ),
        StateNotifierBuilder(
          listenableState: rangeState,
          builder: (context, snapshot) {
            return Text(
              AppTranslations.of(context).fromToDistance(snapshot!.toInt()),
              style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                    color: AppTheme.of(context).thirdColor,
                  ),
            );
          },
        ),
      ],
    );
  }
}

extension _PlaceTypeIcons on PlaceType {
  IconData get icon {
    switch (this) {
      case PlaceType.cafe:
        return Icons.local_cafe;
      case PlaceType.restaurant:
        return Icons.restaurant;

      case PlaceType.museum:
        return Icons.museum;

      case PlaceType.park:
        return Icons.park;

      case PlaceType.hotel:
        return Icons.hotel;

      case PlaceType.other:
        return Icons.star;
    }
  }
}

class _PlaceTypeOption extends StatelessWidget {
  final ValueChanged<PlaceType> onTypeChosen;

  final IconData icon;

  final PlaceType placeType;

  final bool isChosen;

  const _PlaceTypeOption({
    required this.onTypeChosen,
    required this.icon,
    required this.placeType,
    required this.isChosen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTypeChosen(placeType),
      child: SizedBox(
        height: 92,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(.16),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Icon(
                        icon,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  if (isChosen)
                    Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: 9,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Gap(dimension: 12),
            Text(
              placeType.translate(context),
              style: ThemeHelper.textTheme(context).labelSmall!.copyWith(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Filter options, that will be
/// returned from filter page and
/// applied to places list page.
class PlacesFilterParameters {
  /// Chosen places types.
  final List<PlaceType> types;

  /// To which radius from
  /// [location] places to show.
  final double range;

  /// Current user location.
  final Location location;

  /// Whether the filter is not
  /// filled up with any data.
  bool get isEmpty => types.isEmpty || range == 0.0;

  /// Constructor for [PlacesFilterParameters]
  PlacesFilterParameters({
    required this.location,
    this.types = const [],
    this.range = 0,
  });

  /// Creates instance with guaranteed
  /// [isEmpty] true.
  PlacesFilterParameters.empty()
      : location = const Location(0, 0),
        range = 0,
        types = const [];
}
