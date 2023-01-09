import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_error.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/features/app/di/app_scope.dart';
import 'package:flutter_guide/features/places_list/di/places_list_scope.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/widget/places_list_page.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_model.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_wm.dart';
import 'package:flutter_guide/features/places_list/widgets/places_list_text_field.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:provider/provider.dart';

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
      onWillPop: () async {
        wm.popSearch();

        return false;
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: wm.appBarTitle,
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PlacesListTextField(
                trailingIcon: Icons.cancel,
                trailingIconColor: wm.searchIconColor,
                controller: wm.textController,
                focusNode: wm.focus,
                onTapTrailing: () {
                  wm.textController.text = '';
                },
              ),
            ),
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
            builder: (context, data) => _SearchBodyWidget(
              foundPlacesState: data!,
              searchState: wm.searchHistory,
              controller: wm.textController,
              emptyTitle: wm.emptyTitle,
              emptyMessage: wm.emptyMessage,
              clearHistory: wm.clearHistory,
              onSelect: (value) {
                /// Navigate to:
                wm.saveSearch(wm.textController.text);
              },
              onTap: (value) => wm.textController.text = value,
              onDelete: (index) => wm.deleteHistoryAt(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchBodyWidget extends StatelessWidget {
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
          list[index],
          controller.text,
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
          child: Text(
            AppTranslations.of(context).youSearched.toUpperCase(),
            style: ThemeHelper.textTheme(context).labelSmall!.copyWith(
                  color: Theme.of(context).disabledColor,
                ),
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

        var i = -1;

        return SliverList(
          delegate: SliverChildListDelegate(
            List.generate(
              (value.length * 2) - 1,
              (index) {
                if ((index + 1).isEven) {
                  return Divider(
                    color: Theme.of(context).disabledColor.withOpacity(.56),
                    indent: 0,
                    endIndent: 0,
                    thickness: 0.8,
                    height: 0,
                  );
                }

                i++;

                return _HistoryTile(
                  query: value[i],
                  onDelete: onDelete,
                  onTap: onTap,
                  index: i,
                );
              },
            ),
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

  const _SearchResultWidget(
    this.place,
    this.searchString,
  );

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
                image: NetworkImage(place.images.first),
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
                  _SearchTextHighlight(
                    searchString: searchString,
                    text: place.name,
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

class _SearchTextHighlight extends StatelessWidget {
  final String searchString;

  final String text;

  const _SearchTextHighlight({
    required this.text,
    required this.searchString,
  });

  @override
  Widget build(BuildContext context) {
    final style = ThemeHelper.textTheme(context).bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.primaryContainer,
          fontWeight: FontWeight.w500,
        );

    if (searchString.isEmpty) {
      return Text(
        text,
        style: style,
      );
    }

    final matches = text.allMatches(searchString);

    final spans = <InlineSpan>[];

    var index = 0;

    var lastMatch = 0;

    for (final match in matches) {
      spans.add(
        TextSpan(
          text: text.substring(index, match.start),
          style: style,
        ),
      );

      index = match.start;

      spans.add(
        TextSpan(
          text: text.substring(index, match.end),
          style: style.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      );

      lastMatch = match.end;
    }

    spans.add(
      TextSpan(
        text: text.substring(lastMatch, text.length),
        style: style,
      ),
    );

    return RichText(
      text: TextSpan(
        children: spans,
      ),
    );
  }
}
