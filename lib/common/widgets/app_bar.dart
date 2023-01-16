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

  /// What widget is placed
  /// at the bottom of app bar
  /// (right down from title)
  final PreferredSizeWidget? bottom;

  @override
  Size get preferredSize => Size(
        double.infinity,
        56 + (bottom != null ? bottom!.preferredSize.height : 0),
      );

  /// Constructor for [MainAppBar]
  const MainAppBar({
    required this.title,
    super.key,
    this.leading,
    this.trailing = const <Widget>[],
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: ThemeHelper.textTheme(context).titleSmall!.copyWith(
              fontWeight: FontWeight.w500,
              color: ThemeHelper.mainTextColor(context),
            ),
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0.0,
      actions: trailing,
      leadingWidth: 80,
      leading: leading,
      bottom: bottom,
    );
  }
}
