import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';

/// Little button with left chevrone
/// icon, usually used to navigate back.
class AppBackButton extends StatelessWidget {
  /// What happens on button tap.
  final VoidCallback onTap;

  /// Constructor for [AppBackButton]
  const AppBackButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.chevron_left,
        color: ThemeHelper.mainTextColor(context),
      ),
    );
  }
}
