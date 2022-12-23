import 'package:flutter/material.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Tappable colored text
/// on the right of [AppBar]
class AppBarTralingButton extends StatelessWidget {
  /// What happens when user
  /// clicks this text
  final VoidCallback onTap;

  /// Initialization.
  const AppBarTralingButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          AppTranslations.of(context).skip,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }
}
