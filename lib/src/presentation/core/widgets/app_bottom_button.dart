import 'package:flutter/material.dart';
import 'package:flutter_guide/src/presentation/core/gap.dart';

class AppBottomButton extends StatelessWidget {
  final void Function() onTap;

  final String text;

  final Icon? icon;

  final Color? color;

  const AppBottomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color ?? Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const Gap(dimension: 10),
            ],
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
