import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/api/data/places_list/place.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_back_button.dart';
import 'package:flutter_guide/common/widgets/app_bar.dart';
import 'package:flutter_guide/common/widgets/app_bottom_button.dart';
import 'package:flutter_guide/common/widgets/app_divider.dart';
import 'package:flutter_guide/features/places_list/screens/places_list/places_list_page.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// New place -> categories page.
class NewPlaceCategoriesPage extends StatefulWidget {
  /// Initial selected place type.
  final PlaceType? initialType;

  /// Constructor for [NewPlaceCategoriesPage].
  const NewPlaceCategoriesPage({
    super.key,
    this.initialType,
  });

  @override
  State<NewPlaceCategoriesPage> createState() => _NewPlaceCategoriesPageState();
}

class _NewPlaceCategoriesPageState extends State<NewPlaceCategoriesPage> {
  PlaceType? _selected;

  @override
  void initState() {
    _selected = widget.initialType;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: AppTranslations.of(context).category,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: AppBackButton(
              onTap: AutoRouter.of(context).popForced,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: AppBottomButton(
          text: AppTranslations.of(context).save,
          buttonType: _selected != null
              ? AppBottomButtonType.primary
              : AppBottomButtonType.disabled,
          onTap: () => AutoRouter.of(context).popForced(_selected),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: PlaceType.values.length,
        separatorBuilder: (context, index) => const AppDivider(),
        itemBuilder: (context, index) {
          final type = PlaceType.values[index];

          return _Option(
            onTap: () => setState(() {
              _selected = type;
            }),
            type: type,
            selected: type == _selected,
          );
        },
      ),
    );
  }
}

class _Option extends StatelessWidget {
  final PlaceType type;

  final bool selected;

  final VoidCallback onTap;

  const _Option({
    required this.onTap,
    required this.type,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 48,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: selected
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: [
            Text(
              type.translate(context),
              style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                    color: ThemeHelper.mainColor(context),
                  ),
            ),
            if (selected)
              Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
