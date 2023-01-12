import 'package:flutter/material.dart';
import 'package:flutter_guide/common/widgets/gap.dart';

/// Large primary-colored bottom button.
class AppBottomButton extends StatelessWidget {
  /// What happens on tap.
  final VoidCallback onTap;

  /// What is written in the center of
  /// the button.
  final String text;

  /// Optional icon, that will
  /// be located before the text.
  final Icon? icon;

  /// If you want other color,
  /// not the primary from theme,
  /// specify it here.
  final Color? color;

  /// Constructor for [AppBottomButton]
  const AppBottomButton({
    required this.onTap,
    required this.text,
    super.key,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color ?? Theme.of(context).primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              const Gap(dimension: 10),
            ],
            Text(
              text.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
