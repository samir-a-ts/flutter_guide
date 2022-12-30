import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/places_list/domain/entity/search_history.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_model.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_widget.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

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

  /// Focus manager of search input field.
  FocusNode get focus;

  /// Color, which trailing icon
  /// of search input will be painted
  /// with.
  Color get searchIconColor;

  /// Controller of user search input field.
  TextEditingController get textController;

  /// Delete search record from history
  /// add given [index].
  void deleteHistoryAt(int index);

  /// Saves given query in device cache.
  void saveSearch(String query);
}

/// Default widget model for PlacesSearchWidget
class PlacesSearchWidgetModel
    extends WidgetModel<PlacesSearchPage, PlacesSearchModel>
    implements IPlacesSearchWidgetModel {
  final _textController = TextEditingController();

  final _focus = FocusNode();

  @override
  EntityStateNotifier<Iterable<Place>> get foundPlacesState =>
      model.foundPlacesState;

  @override
  ListenableState<SearchHistory> get searchHistory => model.searchHistory;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  TextEditingController get textController => _textController;

  @override
  FocusNode get focus => _focus;

  @override
  Color get searchIconColor => AppTheme.of(context).thirdColor;

  /// Constructor for [PlacesSearchWidgetModel].
  PlacesSearchWidgetModel(PlacesSearchModel model) : super(model);

  @override
  void saveSearch(String query) => model.saveSearch(query);

  @override
  void deleteHistoryAt(int index) => model.deleteHistoryAt(index);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _focus.requestFocus();

    textController.addListener(_search);
  }

  @override
  void dispose() {
    textController
      ..removeListener(_search)
      ..dispose();

    super.dispose();
  }

  void _search() {
    model.onSearch(textController.text);
  }
}
