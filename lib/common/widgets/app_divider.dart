import 'package:flutter/material.dart';

/// Almost transparent line between
/// different parts of list.
class AppDivider extends StatelessWidget {
  /// Constructor for [AppDivider]
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).disabledColor.withOpacity(.56),
      indent: 0,
      endIndent: 0,
      height: 0,
    );
  }
}
