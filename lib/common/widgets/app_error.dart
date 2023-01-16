import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/gap.dart';

/// Diverse error indication to user.
class AppError extends StatelessWidget {
  /// Icon, which will be
  /// shown on the top of the widget.
  final IconData icon;

  /// The text under the [icon].
  final String title;

  /// What user have been informed about.
  ///
  /// Text under `error` string.
  final String message;

  /// Constructor for [AppError].
  const AppError({
    required this.icon,
    required this.title,
    super.key,
    this.message = '',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 64,
            color: Theme.of(context).disabledColor,
          ),
          const Gap(dimension: 24),
          Text(
            title,
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
      ),
    );
  }
}
