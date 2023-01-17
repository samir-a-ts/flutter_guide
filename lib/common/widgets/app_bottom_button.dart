import 'package:flutter/material.dart';
import 'package:flutter_guide/common/widgets/gap.dart';

/// Mode of [AppBottomButton],
/// which resolves, which color
/// will be used to paint
/// this widget.
enum AppBottomButtonType {
  /// Color: primary color from theme.
  /// Text color: background color.
  primary,

  /// Disabled set of colors.
  disabled,

  /// Color: background color
  /// Text color: primary
  secondary,
}

/// Large primary-colored bottom button.
class AppBottomButton extends StatelessWidget {
  /// Current mode of this button, sets of
  /// colors used will depend on this.
  final AppBottomButtonType? buttonType;

  /// What happens on tap.
  final VoidCallback? onTap;

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

  /// Color, in which bold [text]
  /// on button will be painted in.
  final Color? textColor;

  /// Constructor for [AppBottomButton]
  const AppBottomButton({
    required this.text,
    this.onTap,
    super.key,
    this.icon,
    this.color,
    this.textColor,
    this.buttonType,
  });

  @override
  Widget build(BuildContext context) {
    var buttonColor = color;
    var buttonTextColor = textColor;

    if (buttonType != null) {
      switch (buttonType!) {
        case AppBottomButtonType.primary:
          buttonColor ??= Theme.of(context).primaryColor;
          buttonTextColor ??= Theme.of(context).backgroundColor;
          break;
        case AppBottomButtonType.disabled:
          buttonColor ??= Theme.of(context).backgroundColor;
          buttonTextColor ??= Theme.of(context).disabledColor.withOpacity(.56);
          break;
        case AppBottomButtonType.secondary:
          buttonColor ??= Theme.of(context).backgroundColor;
          buttonTextColor ??= Theme.of(context).primaryColor;
          break;
      }
    }

    return GestureDetector(
      onTap: buttonType == AppBottomButtonType.disabled ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: buttonColor ?? Theme.of(context).primaryColor,
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
                    color: buttonTextColor ?? Theme.of(context).backgroundColor,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
