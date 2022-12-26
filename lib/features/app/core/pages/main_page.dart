import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/features/navigation/service/app_router.gr.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Main page after splash and tutorial.
class MainPage extends StatelessWidget {
  /// Initialization.
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        PlacesListRoute(),
        MapRoute(),
        FavoriteRoute(),
        SettingsRoute(),
      ],
      builder: (context, child, animation) => child,
      bottomNavigationBuilder: (context, tabsRouter) => _MainBottomNavigation(
        onTabSelect: (value) => tabsRouter.setActiveIndex(value),
        selected: tabsRouter.activeIndex,
      ),
    );
  }
}

class _MainBottomNavigation extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTabSelect;

  const _MainBottomNavigation({
    required this.selected,
    required this.onTabSelect,
  });

  @override
  Widget build(BuildContext context) {
    const tabs = ['places', 'map', 'favorite', 'settings'];

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 0.8,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(
          4,
          (index) => _MainNavigationBarTile(
            onTap: () => onTabSelect(index),
            width: size.width / tabs.length,
            height: 56,
            iconPath:
                "assets/images/${tabs[index]}${index == selected ? "_filled" : ""}.svg",
          ),
        ),
      ),
    );
  }
}

class _MainNavigationBarTile extends StatelessWidget {
  final String iconPath;
  final double width;
  final double height;
  final VoidCallback onTap;

  const _MainNavigationBarTile({
    required this.iconPath,
    required this.width,
    required this.height,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
