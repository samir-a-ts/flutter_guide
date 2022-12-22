import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guide/src/core/router/app_router.gr.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        PlacesListRoute(),
        MapRoute(),
        FavouriteRoute(),
        SettingsRoute(),
      ],
      builder: (context, child, animation) => Container(),
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

  static const _tabs = ["places", "map", "favourite", "settings"];

  @override
  Widget build(BuildContext context) {
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
          (index) => InkWell(
            onTap: () => onTabSelect(index),
            child: SizedBox(
              width: size.width / _tabs.length,
              height: 56,
              child: Center(
                child: SvgPicture.asset(
                  "assets/images/${_tabs[index]}${index == selected ? "_filled" : ""}.svg",
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
