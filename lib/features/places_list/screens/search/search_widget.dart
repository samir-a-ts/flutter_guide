import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_error.dart';
import 'package:flutter_guide/common/widgets/app_progress_indicator.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/common/widgets/label.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_model.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_wm.dart';
import 'package:flutter_guide/features/places_list/widgets/places_search_text_field.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';

/// Factory for [PlacesSearchWidgetModel].
PlacesSearchWidgetModel defaultSearchWidgetModelFactory(BuildContext context) {
  final placesScope = Provider.of<IPlacesListScope>(context, listen: false);

  return PlacesSearchWidgetModel(
    PlacesSearchModel(
      placesScope.placesRepository,
      placesScope.placesSearchCacheRepository,
    ),
  );
}

/// Main widget for places search module
class PlacesSearchPage extends ElementaryWidget<IPlacesSearchWidgetModel> {
  /// Constructor for [PlacesSearchPage]
  const PlacesSearchPage({
    Key? key,
    WidgetModelFactory wmFactory = defaultSearchWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesSearchWidgetModel wm) {
    return WillPopScope(
      onWillPop: wm.searchPopCallback,
      child: Scaffold(
        appBar: MainAppBar(
          title: wm.appBarTitle,
          bottom: _SearchPageInput(
            controller: wm.searchTextController,
            focus: wm.searchInputFocus,
            clearInput: wm.clearInput,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ).copyWith(top: 32),
          child: EntityStateNotifierBuilder(
            listenableEntityState: wm.foundPlacesState,
            errorBuilder: (context, e, data) => Center(
              child: AppError(
                icon: Icons.error,
                title: wm.errorText,
                message: wm.errorMessage,
              ),
            ),
            loadingBuilder: (context, data) => const Center(
              child: AppProgressIndicator(),
            ),
            builder: (context, data) => _SearchBodyWidget(
              foundPlacesState: data!,
              searchState: wm.searchHistory,
              controller: wm.searchTextController,
              emptyTitle: wm.emptyTitle,
              emptyMessage: wm.emptyMessage,
              clearHistory: wm.clearHistory,
              onSelect: wm.onSearchResultTap,
              onTap: wm.onSearchHistoryTap,
              onDelete: wm.deleteHistoryAt,
              highlightSearchText: wm.highlightSearchText,
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBodyWidget extends StatelessWidget {
  final List<InlineSpan> Function(String searchText, String text)
      highlightSearchText;

  final ListenableState<List<String>> searchState;
  final Iterable<Place> foundPlacesState;
  final TextEditingController controller;

  final ValueChanged<int> onDelete;
  final ValueChanged<String> onTap;
  final ValueChanged<Place> onSelect;
  final VoidCallback clearHistory;

  final String emptyTitle;
  final String emptyMessage;

  const _SearchBodyWidget({
    required this.searchState,
    required this.foundPlacesState,
    required this.onDelete,
    required this.onTap,
    required this.onSelect,
    required this.controller,
    required this.emptyTitle,
    required this.emptyMessage,
    required this.clearHistory,
    required this.highlightSearchText,
  });

  @override
  Widget build(BuildContext context) {
    if (foundPlacesState.isEmpty) {
      if (controller.text.isNotEmpty) {
        return Center(
          child: AppError(
            icon: Icons.search,
            title: emptyTitle,
            message: emptyMessage,
          ),
        );
      }

      return _SearchHistoryWidget(
        searchState: searchState,
        onDelete: onDelete,
        onTap: onTap,
        clearHistory: clearHistory,
      );
    }

    final list = foundPlacesState.toList();

    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () => onSelect(list[index]),
        child: _SearchResultWidget(
          place: list[index],
          searchString: controller.text,
          highlightSearchText: highlightSearchText,
        ),
      ),
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}

class _SearchHistoryWidget extends StatelessWidget {
  final ListenableState<List<String>> searchState;

  final ValueChanged<int> onDelete;
  final ValueChanged<String> onTap;
  final VoidCallback clearHistory;

  const _SearchHistoryWidget({
    required this.searchState,
    required this.onDelete,
    required this.onTap,
    required this.clearHistory,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Label(
            labelText: AppTranslations.of(context).youSearched.toUpperCase(),
          ),
        ),
        _HistoryList(
          searchState: searchState,
          onDelete: onDelete,
          onTap: onTap,
        ),
        StateNotifierBuilder(
          listenableState: searchState,
          builder: (context, value) {
            return SliverToBoxAdapter(
              child: value!.isEmpty
                  ? const SizedBox()
                  : GestureDetector(
                      onTap: clearHistory,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          AppTranslations.of(context).clearHistory,
                          style: ThemeHelper.textTheme(context)
                              .bodyMedium!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}

class _HistoryList extends StatelessWidget {
  final ListenableState<List<String>> searchState;
  final ValueChanged<int> onDelete;
  final ValueChanged<String> onTap;

  const _HistoryList({
    required this.searchState,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder(
      listenableState: searchState,
      builder: (context, value) {
        if (value!.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox(),
          );
        }

        return SliverList(
          delegate: SliverChildListDelegate(
            [
              for (var i = 0; i < (value.length * 2) - 1; i++)
                i.isOdd
                    ? Divider(
                        color: Theme.of(context).disabledColor.withOpacity(.56),
                        indent: 0,
                        endIndent: 0,
                        height: 0,
                      )
                    : _HistoryTile(
                        query: value[i ~/ 2],
                        onDelete: onDelete,
                        onTap: onTap,
                        index: i ~/ 2,
                      ),
            ],
          ),
        );
      },
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final String query;
  final int index;
  final ValueChanged<int> onDelete;
  final ValueChanged<String> onTap;

  const _HistoryTile({
    required this.query,
    required this.onDelete,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListTile(
        onTap: () => onTap(query),
        title: Text(
          query,
          style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                color: AppTheme.of(context).thirdColor,
              ),
        ),
        trailing: IconButton(
          onPressed: () => onDelete(index),
          icon: Icon(
            Icons.close,
            color: AppTheme.of(context).thirdColor,
          ),
        ),
      ),
    );
  }
}

class _SearchResultWidget extends StatelessWidget {
  final Place place;

  final String searchString;

  final List<InlineSpan> Function(String searchText, String text)
      highlightSearchText;

  const _SearchResultWidget({
    required this.place,
    required this.searchString,
    required this.highlightSearchText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 78,
      child: Row(
        children: [
          Container(
            height: 78,
            width: 78,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(
                  place.images.isEmpty
                      ? 'https://external-content.duckduckgo.com/iu/?u=http%3A%2F%2Fwww.dumpaday.com%2Fwp-content%2Fuploads%2F2019%2F12%2Fpictures-10-2.jpg&f=1&nofb=1&ipt=c3bca4b17b06e50c1a43fadddc8ef4ceb45646c0d92f3da90dc63b9d383f91ca&ipo=images'
                      : place.images.first,

                  /// Some places, for some unknown reason,
                  /// do not have just any image links
                  /// whatsoever. I am to lazy to bring this
                  /// thing anywhere, so let it stay here...
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(dimension: 16),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      children: highlightSearchText(searchString, place.name),
                    ),
                  ),
                  Text(
                    place.placeType.translate(context),
                    style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
                          color: AppTheme.of(context).thirdColor,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: prefer_mixin
class _SearchPageInput extends StatelessWidget with PreferredSizeWidget {
  final TextEditingController controller;

  final FocusNode focus;

  final void Function() clearInput;

  @override
  Size get preferredSize => const Size(double.infinity, 40);

  const _SearchPageInput({
    required this.controller,
    required this.focus,
    required this.clearInput,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: PlacesSearchTextField(
        controller: controller,
        focusNode: focus,
        onTapTrailing: clearInput,
      ),
    );
  }
}
