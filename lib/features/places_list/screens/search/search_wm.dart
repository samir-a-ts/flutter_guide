import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/features/app/di/app_scope.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/domain/entity/search_history.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_model.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_widget.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';

/// Interface of [PlacesSearchWidgetModel]
abstract class IPlacesSearchWidgetModel extends IWidgetModel {
  /// The state of filtered places, which were
  /// filtered by their name.
  final foundPlacesState = EntityStateNotifier<Iterable<Place>>.value([]);

  /// List of previous queries (search history)
  ///  of user place's search.
  ListenableState<SearchHistory> get searchHistory;

  /// Translated app bar title.
  String get appBarTitle;

  /// Controller of user search input field.
  TextEditingController get textController;

  /// Delete search record from history
  /// add given [index].
  void deleteHistoryAt(int index);
}

/// Factory for [PlacesSearchWidgetModel].
PlacesSearchWidgetModel defaultSearchWidgetModelFactory(BuildContext context) {
  final appScope = Provider.of<IAppScope>(context, listen: false);

  final placesScope = Provider.of<IPlacesListScope>(context, listen: false);

  return PlacesSearchWidgetModel(
    PlacesSearchModel(
      appScope.errorHandler,
      placesScope.placesRepository,
      placesScope.placesSearchCacheRepository,
    ),
  );
}

/// Default widget model for PlacesSearchWidget
class PlacesSearchWidgetModel
    extends WidgetModel<PlacesSearchPage, PlacesSearchModel>
    implements IPlacesSearchWidgetModel {
  final _textController = TextEditingController();

  @override
  EntityStateNotifier<Iterable<Place>> get foundPlacesState =>
      model.foundPlacesState;

  @override
  ListenableState<SearchHistory> get searchHistory => model.searchHistory;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  TextEditingController get textController => _textController;

  /// Constructor for [PlacesSearchWidgetModel].
  PlacesSearchWidgetModel(PlacesSearchModel model) : super(model);

  @override
  void deleteHistoryAt(int index) => model.deleteHistoryAt(index);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    textController.addListener(_search);
  }

  @override
  void dispose() {
    textController
      ..removeListener(_search)
      ..dispose();

    super.dispose();
  }

  void _search() => model.onSearch(textController.text);
}
