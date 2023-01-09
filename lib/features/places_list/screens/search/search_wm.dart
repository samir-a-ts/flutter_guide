import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
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
  ListenableState<List<String>> get searchHistory;

  /// Translated app bar title.
  String get appBarTitle;

  /// Translated error widget title.
  String get errorText;

  /// Translated error widget message.
  String get errorMessage;

  /// Translated empty widget title.
  String get emptyTitle;

  /// Translated empty widget message.
  String get emptyMessage;

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

  /// Returns to the list of places.
  void popSearch();

  /// Deletes all recordings in current history list.
  void clearHistory();
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
  ListenableState<List<String>> get searchHistory => model.searchHistory;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  TextEditingController get textController => _textController;

  @override
  FocusNode get focus => _focus;

  @override
  Color get searchIconColor => AppTheme.of(context).thirdColor;

  @override
  String get errorMessage => AppTranslations.of(context).somethingWrong;

  @override
  String get errorText => AppTranslations.of(context).error;

  @override
  String get emptyMessage => AppTranslations.of(context).emptyMessage;

  @override
  String get emptyTitle => AppTranslations.of(context).emptyTitle;

  /// Constructor for [PlacesSearchWidgetModel].
  PlacesSearchWidgetModel(PlacesSearchModel model) : super(model);

  @override
  void saveSearch(String query) => model.saveSearch(query);

  @override
  void deleteHistoryAt(int index) => model.deleteHistoryAt(index);

  @override
  void popSearch() => AutoRouter.of(context).removeLast();

  @override
  void clearHistory() => model.clearHistory();

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

    _focus
      ..unfocus()
      ..dispose();

    super.dispose();
  }

  void _search() => model.onSearch(textController.text);
}
