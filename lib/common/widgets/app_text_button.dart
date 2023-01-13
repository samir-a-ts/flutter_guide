import 'package:flutter/material.dart';

/// Colored and bold text
/// with on tap handling.
class AppTextButton extends StatelessWidget {
  /// What happens when user
  /// clicks this text
  final VoidCallback onTap;

  /// What is going to be written
  /// on this button.
  final String text;

  /// Color, in which the [text]
  /// in [AppTextButton] will be painted in.
  ///
  /// If it is null, defaults to
  /// primaryColor from [Theme].
  final Color? color;

  /// Constructor for [AppTextButton].
  const AppTextButton({
    required this.onTap,
    required this.text,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
              color: color ?? Theme.of(context).primaryColor,
            ),
      ),
    );
  }
}
