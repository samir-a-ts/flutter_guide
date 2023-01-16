import 'package:flutter/material.dart';

/// Tappable colored text
/// specially for the `MainAppBar`
class AppBarTrailingButton extends StatelessWidget {
  /// What happens when user
  /// clicks this text
  final VoidCallback onTap;

  /// What is going to be written
  /// on this button.
  final String title;

  /// Constructor for [AppBarTrailingButton].
  const AppBarTrailingButton({
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
        ),
      ),
    );
  }
}
