import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';

/// Small gray and upper-cased
/// title on top of any widget.
class Label extends StatelessWidget {
  /// What is going to be written
  /// on the title.
  final String labelText;

  /// Constructor for [Label].
  const Label({
    required this.labelText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      labelText.toUpperCase(),
      style: ThemeHelper.textTheme(context).labelSmall!.copyWith(
            color: Theme.of(context).disabledColor,
          ),
    );
  }
}
