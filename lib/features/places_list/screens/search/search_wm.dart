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
  EntityStateNotifier<Iterable<Place>> get foundPlacesState;

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
  FocusNode get searchInputFocus;

  /// Color, which trailing icon
  /// of search input will be painted
  /// with.
  Color get searchIconColor;

  /// Controller of user search input field.
  TextEditingController get searchTextController;

  /// Delete search record from history
  /// add given [index].
  void deleteHistoryAt(int index);

  /// Deletes all recordings in current history list.
  void clearHistory();

  /// Returns to the list of places.
  Future<bool> searchPopCallback();

  /// Clears the search input widget
  /// from all text written.
  void clearInput();

  /// Handle history search tile click.
  /// Adds this search option to search page
  /// text field.
  void onSearchHistoryTap(String selected);

  /// Handle search result tile click.
  /// Navigates to [selected] view page
  /// and adds search string to history.
  void onSearchResultTap(Place selected);

  /// Returns [text] sequence, where
  /// the [searchText] parts within [text]
  /// will be in bold.
  List<InlineSpan> highlightSearchText(String searchText, String text);
}

/// Default widget model for PlacesSearchWidget
class PlacesSearchWidgetModel
    extends WidgetModel<PlacesSearchPage, PlacesSearchModel>
    implements IPlacesSearchWidgetModel {
  final _searchTextController = TextEditingController();

  final _searchInputFocus = FocusNode();

  @override
  EntityStateNotifier<Iterable<Place>> get foundPlacesState =>
      model.foundPlacesState;

  @override
  ListenableState<List<String>> get searchHistory => model.searchHistory;

  @override
  String get appBarTitle => AppTranslations.of(context).placesListTitle;

  @override
  TextEditingController get searchTextController => _searchTextController;

  @override
  FocusNode get searchInputFocus => _searchInputFocus;

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
  void deleteHistoryAt(int index) => model.deleteHistoryAt(index);

  @override
  Future<bool> searchPopCallback() {
    AutoRouter.of(context).removeLast();

    return Future.value(false);
  }

  @override
  void clearInput() => searchTextController.text = '';

  @override
  void onSearchHistoryTap(String selected) =>
      searchTextController.text = selected;

  @override
  void onSearchResultTap(Place selected) {
    model.saveSearch(searchTextController.text);

    /// Navigate to details page:
  }

  @override
  void clearHistory() => model.clearHistory();

  @override
  List<InlineSpan> highlightSearchText(String searchText, String text) {
    final matches = text.allMatches(searchText);

    final spans = <InlineSpan>[];

    var saveIndex = 0;

    final style = ThemeHelper.textTheme(context).bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.primaryContainer,
          fontWeight: FontWeight.w500,
        );

    for (final match in matches) {
      spans
        ..add(
          TextSpan(
            text: text.substring(saveIndex, match.start),
            style: style,
          ),
        )
        ..add(
          TextSpan(
            text: text.substring(match.start, match.end),
            style: style.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        );

      saveIndex = match.end;
    }

    spans.add(
      TextSpan(
        text: text.substring(saveIndex, text.length),
        style: style,
      ),
    );

    return spans;
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _searchInputFocus.requestFocus();

    searchTextController.addListener(_search);
  }

  @override
  void dispose() {
    searchTextController
      ..removeListener(_search)
      ..dispose();

    _searchInputFocus
      ..unfocus()
      ..dispose();

    super.dispose();
  }

  void _search() {
    model.onSearch(searchTextController.text);
  }
}
