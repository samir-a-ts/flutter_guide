import 'package:flutter/material.dart';
import 'package:flutter_guide/assets/themes/theme.dart';
import 'package:flutter_guide/common/widgets/app_bottom_button.dart';
import 'package:flutter_guide/common/widgets/app_divider.dart';
import 'package:flutter_guide/common/widgets/gap.dart';
import 'package:flutter_guide/features/translations/service/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';

/// Pop-up, which will determine
/// the source of image picking.
class ImageSourcePickDialog extends StatelessWidget {
  /// Constructor for [ImageSourcePickDialog]
  const ImageSourcePickDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < ImageSource.values.length; i++) ...[
                  _SourceOption(source: ImageSource.values[i]),
                  if (i != ImageSource.values.length - 1) const AppDivider(),
                ],
              ],
            ),
          ),
          const Gap(dimension: 8),
          AppBottomButton(
            onTap: () => Navigator.of(context).pop(),
            buttonType: AppBottomButtonType.secondary,
            text: AppTranslations.of(context).cancel,
          ),
        ],
      ),
    );
  }
}

class _SourceOption extends StatelessWidget {
  final ImageSource source;

  const _SourceOption({
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(source),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              source.icon,
              size: 20,
              color: AppTheme.of(context).thirdColor,
            ),
            const Gap(dimension: 13),
            Text(
              source.translate(context),
              style: ThemeHelper.textTheme(context).bodyMedium!.copyWith(
                    color: AppTheme.of(context).thirdColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

extension _SourceExt on ImageSource {
  IconData get icon {
    switch (this) {
      case ImageSource.camera:
        return Icons.camera;

      case ImageSource.gallery:
        return Icons.browse_gallery;
    }
  }

  String translate(BuildContext context) {
    switch (this) {
      case ImageSource.camera:
        return AppTranslations.of(context).camera;

      case ImageSource.gallery:
        return AppTranslations.of(context).gallery;
    }
  }
}
