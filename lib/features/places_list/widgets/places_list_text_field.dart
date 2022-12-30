import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Text field styled particularly
/// for this feature.
class PlacesListTextField extends StatelessWidget {
  /// Icon located at the end
  /// of the text field, right after
  /// the field.
  final IconData? trailingIcon;

  /// Color, which [trailingIcon]
  /// will be painted with.
  final Color? trailingIconColor;

  /// What happens on the trailing
  /// widget tap.
  final VoidCallback? onTapTrailing;

  /// Controller of [TextField] in this widget.
  final TextEditingController? controller;

  /// Whether this field enabled.
  final bool enabled;

  /// Focus controller of this text field.
  final FocusNode? focusNode;

  /// Constructor for [PlacesListTextField].
  const PlacesListTextField({
    this.trailingIcon,
    this.onTapTrailing,
    super.key,
    this.enabled = true,
    this.controller,
    this.focusNode,
    this.trailingIconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        enabled: enabled,
        controller: controller,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Theme.of(context).primaryColor,
        style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
        decoration: InputDecoration(
          prefixIcon: GestureDetector(
            onTap: onTapTrailing,
            child: Icon(
              Icons.search,
              color: Theme.of(context).disabledColor,
            ),
          ),
          suffix: IconButton(
            onPressed: onTapTrailing,
            icon: Icon(
              trailingIcon,
              color: trailingIconColor,
            ),
          ),
          filled: true,
          contentPadding: EdgeInsets.zero,
          fillColor: AppTheme.of(context).additionalColor,
          focusedBorder: InputBorder.none,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: AppTranslations.of(context).search,
          hintStyle: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
      ),
    );
  }
}
