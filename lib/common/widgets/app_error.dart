import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Diverse error indication to user.
class AppError extends StatelessWidget {
  /// What user have been informed about.
  ///
  /// Text under `error` string.
  final String message;

  /// Constructor for [AppError].
  const AppError({
    super.key,
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.cancel,
          size: 64,
          color: Theme.of(context).disabledColor,
        ),
        const Gap(dimension: 24),
        Text(
          AppTranslations.of(context).error,
          style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).disabledColor,
              ),
        ),
        const Gap(dimension: 8),
        Text(
          message,
          style: ThemeHelper.textTheme(context).labelMedium!.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
      ],
    );
  }
}
