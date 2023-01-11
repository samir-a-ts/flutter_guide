import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';

/// Text field styled particularly
/// for this feature.
class PlacesSearchTextField extends StatelessWidget {
  /// What happens on the trailing
  /// widget tap.
  final VoidCallback? onTapTrailing;

  /// Controller of [TextField] in this widget.
  final TextEditingController? controller;

  /// Focus controller of this text field.
  final FocusNode? focusNode;

  /// Constructor for [PlacesSearchTextField].
  const PlacesSearchTextField({
    this.onTapTrailing,
    super.key,
    this.controller,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: Theme.of(context).primaryColor,
        style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).disabledColor,
          ),
          suffixIcon: IconButton(
            onPressed: onTapTrailing,
            icon: Icon(
              Icons.cancel,
              color: AppTheme.of(context).thirdColor,
            ),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(14),
          fillColor: AppTheme.of(context).additionalColor,
          focusedBorder: InputBorder.none,
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
