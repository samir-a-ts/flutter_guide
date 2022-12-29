import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_error.dart';
import 'package:flutter_guide/features/places_list/screens/search/search_wm.dart';
import 'package:flutter_guide/features/places_list/widgets/places_list_text_field.dart';

/// Main widget for places search module
class PlacesSearchPage extends ElementaryWidget<IPlacesSearchWidgetModel> {
  /// Constructor for [PlacesSearchPage]
  const PlacesSearchPage({
    Key? key,
    WidgetModelFactory wmFactory = defaultSearchWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IPlacesSearchWidgetModel wm) {
    return Scaffold(
      appBar: MainAppBar(
        title: wm.appBarTitle,
        bottom: PreferredSize(
          preferredSize: const Size(double.infinity, 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PlacesListTextField(
              trailing: const Icon(Icons.filter),
              controller: wm.textController,
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
          vertical: 4,
        ),
        child: EntityStateNotifierBuilder(
          listenableEntityState: wm.foundPlacesState,
          errorBuilder: (context, e, data) {
            return const SizedBox(
              height: 150,
              child: Center(
                child: AppError(
                  message: 'Something wrong...',
                ),
              ),
            );
          },
          builder: (context, data) => Container(),
        ),
      ),
    );
  }
}
