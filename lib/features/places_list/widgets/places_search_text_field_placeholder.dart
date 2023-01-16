import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Placeholder of what is used to be
/// an text field, but disabled and tappable.
class PlacesListTextFieldPlaceholder extends StatelessWidget {
  /// What happens on trailing icon tap in
  /// input placeholder.
  final VoidCallback? onTrailingIconTap;

  /// What happens on input
  /// placeholder tap.
  final VoidCallback? onTap;

  /// Constructor for [PlacesListTextFieldPlaceholder].
  const PlacesListTextFieldPlaceholder({
    super.key,
    this.onTrailingIconTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: AppTheme.of(context).additionalColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 52,
              height: double.infinity,
              child: Icon(
                Icons.search,
                color: Theme.of(context).disabledColor,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppTranslations.of(context).search,
                  style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                        color: Theme.of(context).disabledColor,
                      ),
                ),
              ),
            ),
            GestureDetector(
              onTap: onTrailingIconTap,
              child: SizedBox(
                width: 52,
                height: double.infinity,
                child: Icon(
                  Icons.tune,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
