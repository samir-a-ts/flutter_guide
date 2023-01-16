import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Default app's snack bar,
/// which used in case of the error.
class AppErrorSnackBar extends StatelessWidget {
  /// Constructor for [AppErrorSnackBar]
  const AppErrorSnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Theme.of(context).errorColor,
      content: Text(
        AppTranslations.of(context).error,
        style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
              color: Theme.of(context).backgroundColor,
            ),
      ),
    );
  }
}
