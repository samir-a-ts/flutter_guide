import 'package:flutter/material.dart';

class AppTabView extends StatelessWidget {
  final int length;

  final int currentIndex;

  const AppTabView({
    super.key,
    required this.length,
    required this.currentIndex,
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
