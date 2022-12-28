import 'package:flutter/material.dart';

/// Widget for current tab indication
/// like [TabBarView].
///
/// Sequence of circles, the circle
/// with [currentIndex] enlarges
/// and becomes primary-colored.
class AppTabView extends StatelessWidget {
  /// Amount of tabs, which
  /// have to be represented.
  final int length;

  /// Current tab.
  final int currentIndex;

  /// Constructor for [AppTabView]
  const AppTabView({
    required this.length,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        length,
        (index) {
          final isCurrent = currentIndex == index;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
              height: 8,
              width: isCurrent ? 24 : 8,
              decoration: BoxDecoration(
                color: isCurrent
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).disabledColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          );
        },
      ),
    );
  }
}
