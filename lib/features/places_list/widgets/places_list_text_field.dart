import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Text field styled particularly
/// for this feature.
class PlacesListTextField extends StatelessWidget {
  /// Widget located at the end
  /// of the text field, right after
  /// the field.
  final Widget trailing;

  /// What happens on the trailing
  /// widget tap.
  final VoidCallback? onTapTrailing;

  /// Controller of [TextField] in this widget.
  final TextEditingController? controller;

  /// Whether this field enabled.
  final bool enabled;

  /// Constructor for [PlacesListTextField].
  const PlacesListTextField({
    required this.trailing,
    this.onTapTrailing,
    super.key,
    this.enabled = true,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        enabled: enabled,
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          prefixIcon: GestureDetector(
            onTap: onTapTrailing,
            child: Icon(
              Icons.search,
              color: Theme.of(context).disabledColor,
            ),
          ),
          suffix: trailing,
          filled: true,
          contentPadding: EdgeInsets.zero,
          fillColor: AppTheme.of(context).additionalColor,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelText: AppTranslations.of(context).search,
          labelStyle: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                color: Theme.of(context).disabledColor,
              ),
        ),
      ),
    );
  }
}
