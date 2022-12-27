import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';

/// Commonly styled app bar
/// related to the whole app.
///
/// Can add some [leading] and
/// [trailing] widgets.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Text located in the centre
  /// of the app bar representing
  /// the app bar title.
  final String title;

  /// One widget placed on the
  /// left from the app bar title.
  final Widget? leading;

  /// List of widgets placed on
  /// the right from the app bar title
  /// one after another.
  final List<Widget> trailing;

  @override
  Size get preferredSize => const Size(double.infinity, 56);

  /// Initialization
  const MainAppBar({
    required this.title,
    super.key,
    this.leading,
    this.trailing = const <Widget>[],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: ThemeHelper.textTheme(context).titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0.0,
      actions: trailing,
      leading: leading,
    );
  }
}
