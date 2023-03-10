import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_error.dart';
import 'package:flutter_guide/common/widgets/app_progress_indicator.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/common/widgets/place_card.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope_widget.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_widget_model.dart';
import 'package:flutter_guide/features/places_list/widgets/places_search_text_field_placeholder.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

/// Places list page.
/// Wraps [PlacesListContentWidget] with
/// needed dependencies.
class PlacesListPage extends StatelessWidget {
  /// Constructor for [PlacesListPage]
  const PlacesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlacesListScopeWidget(
      child: PlacesListContentWidget(),
    );
  }
}

/// Places list page content.
class PlacesListContentWidget
    extends ElementaryWidget<IPlacesListPageWidgetModel> {
  /// Constructor for [PlacesListContentWidget].
  const PlacesListContentWidget({super.key})
      : super(
          placesListPageWmFactory,
        );

  @override
  Widget build(IPlacesListPageWidgetModel wm) {
    return AutoRouter(
      builder: (_, content) => content,
      placeholder: (_) => Scaffold(
        appBar: MainAppBar(
          title: wm.appBarTitle,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PlacesListTextFieldPlaceholder(
                onTap: wm.onSearchInputTap,
                onTrailingIconTap: wm.onFilterIconTap,
              ),
            ),
          ),
        ),
        floatingActionButton: StateNotifierBuilder(
          listenableState: wm.arePlacesLoaded,
          builder: (context, value) => value!
              ? _FloatingActionButton(
                  onTap: wm.onNewPlaceButtonTap,
                )
              : const SizedBox(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
          child: StateNotifierBuilder(
            listenableState: wm.placesFilterState,
            builder: (context, filter) {
              if (filter != null) {
                return EntityStateNotifierBuilder(
                  listenableEntityState: wm.filteredPlacesListState,
                  errorBuilder: (context, e, data) => AppError(
                    title: wm.errorText,
                    icon: Icons.cancel,
                    message: wm.errorMessage,
                  ),
                  loadingBuilder: (context, data) => const _LoadingWidget(),
                  builder: (context, filtered) {
                    if (filtered!.isEmpty) {
                      return AppError(
                        title: wm.emptyText,
                        icon: Icons.search,
                        message: wm.emptyMessage,
                      );
                    }

                    return _PlacesList(
                      places: filtered,
                      controller: wm.scrollController,
                      onRefresh: wm.refresh,
                      refreshStream: wm.refreshStream,
                      arePlacesReloading: wm.arePlacesReloading,
                    );
                  },
                );
              }

              return EntityStateNotifierBuilder(
                listenableEntityState: wm.placesListState,
                loadingBuilder: (context, data) {
                  if (data?.isNotEmpty ?? false) {
                    return _PlacesList(
                      places: data!,
                      controller: wm.scrollController,
                      onRefresh: wm.refresh,
                      refreshStream: wm.refreshStream,
                      arePlacesReloading: wm.arePlacesReloading,
                    );
                  }

                  return const _LoadingWidget();
                },
                errorBuilder: (context, e, data) {
                  if (data!.isNotEmpty) {
                    return _PlacesList(
                      places: data,
                      controller: wm.scrollController,
                      onRefresh: wm.refresh,
                      refreshStream: wm.refreshStream,
                      arePlacesReloading: wm.arePlacesReloading,
                    );
                  }

                  return AppError(
                    title: wm.errorText,
                    icon: Icons.cancel,
                    message: wm.errorMessage,
                  );
                },
                builder: (context, data) => _PlacesList(
                  places: data!,
                  controller: wm.scrollController,
                  onRefresh: wm.refresh,
                  refreshStream: wm.refreshStream,
                  arePlacesReloading: wm.arePlacesReloading,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) => const Center(
        child: AppProgressIndicator(),
      );
}

class _FloatingActionButton extends StatelessWidget {
  final VoidCallback onTap;

  const _FloatingActionButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _PlacesList extends StatelessWidget {
  final Iterable<Place> places;

  final ScrollController controller;

  final Future<void> Function() onRefresh;

  final Stream<SwipeRefreshState> refreshStream;

  final ListenableState<bool> arePlacesReloading;

  const _PlacesList({
    required this.places,
    required this.controller,
    required this.onRefresh,
    required this.refreshStream,
    required this.arePlacesReloading,
  });

  @override
  Widget build(BuildContext context) {
    return SwipeRefresh(
      SwipeRefreshStyle.adaptive,
      scrollController: controller,
      onRefresh: onRefresh,
      stateStream: refreshStream,
      initState: SwipeRefreshState.hidden,
      indicatorColor: Theme.of(context).primaryColor,
      childrenDelegate: SliverChildListDelegate(
        [
          for (final place in places)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: PlaceCard(
                place: place,
              ),
            ),
          StateNotifierBuilder(
            listenableState: arePlacesReloading,
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
      case PlaceType.park:
        return AppTranslations.of(context).park;
      case PlaceType.hotel:
        return AppTranslations.of(context).hotel;
      case PlaceType.other:
        return AppTranslations.of(context).other;
    }
  }
}
