import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_error.dart';
import 'package:flutter_guide/common/widgets/app_progress_indicator.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/wm/places_list_widget_model.dart';
import 'package:flutter_guide/features/places_list/widgets/places_list_text_field.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Places list page.
class PlacesListPage extends ElementaryWidget<IPlacesListPageWidgetModel> {
  /// Constructor for [PlacesListPage].
  const PlacesListPage({super.key})
      : super(
          placesListPageWmFactory,
        );

  @override
  Widget build(IPlacesListPageWidgetModel wm) {
    return Scaffold(
      appBar: MainAppBar(
        title: wm.appBarTitle,
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 40),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: PlacesListTextField(
              enabled: false,
              trailing: Icon(Icons.filter),
            ),
          ),
        ),
      ),
      floatingActionButton: StateNotifierBuilder(
        listenableState: wm.arePlacesLoading,
        builder: (context, value) =>
            value! ? const _FloatingActionButton() : const SizedBox(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: SwipeRefresh(
          SwipeRefreshStyle.adaptive,
          scrollController: wm.scrollController,
          onRefresh: wm.refresh,
          stateStream: wm.refreshStream,
          childrenDelegate: SliverChildListDelegate(
            [
              const Gap(dimension: 12),
              EntityStateNotifierBuilder(
                listenableEntityState: wm.placesListState,
                loadingBuilder: (context, data) {
                  if (data?.isNotEmpty ?? false) {
                    return _PlacesList(places: data!);
                  }

                  return const SizedBox(
                    height: 88,
                    child: Center(
                      child: AppProgressIndicator(),
                    ),
                  );
                },
                errorBuilder: (context, e, data) {
                  if (data!.isNotEmpty) {
                    return _PlacesList(places: data);
                  }

                  return const SizedBox(
                    height: 150,
                    child: Center(
                      child: AppError(
                        message: 'Something wrong...',
                      ),
                    ),
                  );
                },
                builder: (context, data) => _PlacesList(places: data!),
              ),
              StateNotifierBuilder(
                listenableState: wm.arePlacesReloading,
                builder: (context, value) => value!
                    ? const SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: AppProgressIndicator(),
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 177,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            AppTheme.of(context).yellowColor,
            Theme.of(context).primaryColor,
          ],
          begin: const Alignment(-1, .1),
          end: const Alignment(1, -.1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
          ),
          const Gap(dimension: 16),
          Text(
            AppTranslations.of(context).newPlace.toUpperCase(),
            style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).backgroundColor,
                ),
          ),
        ],
      ),
    );
  }
}

class _PlacesList extends StatelessWidget {
  final Iterable<Place> places;

  const _PlacesList({required this.places});

  @override
  Widget build(BuildContext context) {
    return ListView.custom(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childrenDelegate: SliverChildListDelegate(
        places
            .map<Widget>(
              (e) => _PlaceCard(
                place: e,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  final Place place;

  const _PlaceCard({
    required this.place,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 188,
          width: double.infinity,
          color: AppTheme.of(context).additionalColor,
          child: Column(
            children: [
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        place.images.first,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        place.placeType.translate(context),
                        style: ThemeHelper.textTheme(context)
                            .labelMedium!
                            .copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).backgroundColor,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: RichText(
                      maxLines: 3,
                      overflow: TextOverflow.fade,
                      text: TextSpan(
                        text: '${place.name}\n',
                        style:
                            ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: ThemeHelper.secondaryColor(context),
                                ),
                        children: [
                          TextSpan(
                            text: place.description,
                            style: ThemeHelper.textTheme(context)
                                .labelMedium!
                                .copyWith(
                                  color: AppTheme.of(context).thirdColor,
                                ),
                          ),
                        ],
                      ),
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

/// Make it easier to
/// translate all types.
extension PlaceTypeExt on PlaceType {
  /// Translated this type of a place.
  String translate(BuildContext context) {
    switch (this) {
      case PlaceType.cafe:
        return AppTranslations.of(context).cafe;
      case PlaceType.restaurant:
        return AppTranslations.of(context).restaurant;
      case PlaceType.museum:
        return AppTranslations.of(context).museum;
      case PlaceType.monument:
        return AppTranslations.of(context).monument;
      case PlaceType.temple:
        return AppTranslations.of(context).temple;
      case PlaceType.park:
        return AppTranslations.of(context).park;
      case PlaceType.theatre:
        return AppTranslations.of(context).theatre;
      case PlaceType.hotel:
        return AppTranslations.of(context).hotel;
      case PlaceType.other:
        return AppTranslations.of(context).other;
    }
  }
}
