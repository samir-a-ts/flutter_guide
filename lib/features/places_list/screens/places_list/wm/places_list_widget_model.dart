import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/domain/entity/place.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/model/places_list_page_model.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/widget/places_list_page.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';

/// Interface of [PlacesListPageWidgetModel]
abstract class IPlacesListPageWidgetModel extends IWidgetModel {
  /// List of places viewed on a screen.
  ListenableState<EntityState<Iterable<Place>>> get placesListState;

  /// If the list of places is loaded (used for floating action button).
  ListenableState<bool> get arePlacesLoaded;

  /// Translated app bar title.
  String get appBarTitle;

  /// Controller of places list.
  ScrollController get scrollController;

  /// If the list of new places is currently being added to
  /// loaded places (used for progress indicator).
  ListenableState<bool> get arePlacesReloading;
}

/// Widget Model for [PlacesListPage]
class PlacesListPageWidgetModel
    extends WidgetModel<PlacesListPage, PlacesListPageModel>
    implements IPlacesListPageWidgetModel {
  final _placesListState = EntityStateNotifier<Iterable<Place>>.value([]);

  final _placesLoaded = StateNotifier<bool>(initValue: false);

  final _placesReloaded = StateNotifier<bool>(initValue: false);

  final _scroll = ScrollController();

  @override
  ListenableState<EntityState<Iterable<Place>>> get placesListState =>
      _placesListState;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  ListenableState<bool> get arePlacesLoaded => _placesLoaded;

  @override
  ScrollController get scrollController => _scroll;

  @override
  ListenableState<bool> get arePlacesReloading => _placesReloaded;

  var _page = 0;

  /// Initialization.
  PlacesListPageWidgetModel(super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _scroll.addListener(_loadMore);

    _loadPlacesList();
  }

  @override
  void dispose() {
    super.dispose();

    _scroll
      ..removeListener(_loadMore)
      ..dispose();
  }

  void _loadMore() {
    if (_scroll.position.extentAfter == 0) _loadPlacesList();
  }

  Future<void> _loadPlacesList() async {
    if (_placesListState.value!.isLoading) return;

    final previousData = _placesListState.value?.data;

    _placesListState.loading(previousData);

    if (previousData!.isNotEmpty) {
      _placesReloaded.accept(true);
    }

    try {
      final result = await model.loadPlaces(_page);

      _placesListState.content(
        previousData.followedBy(result),
      );

      _page++;
    } on Exception catch (e) {
      _placesListState.error(e, previousData);
    }

    _placesLoaded.accept(_placesListState.value!.data!.isNotEmpty);

    _placesReloaded.accept(false);
  }
}

/// Factory for [PlacesListPageWidgetModel].
PlacesListPageWidgetModel placesListPageWmFactory(
  BuildContext context,
) {
  final placesList = Provider.of<IPlacesListScope>(context, listen: false);

  final model = PlacesListPageModel(placesList.repository);

  return PlacesListPageWidgetModel(model);
}
