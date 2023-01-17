import 'dart:io';

import 'package:image_picker/image_picker.dart';

/// Image picking and loading manager.
// ignore: one_member_abstracts
abstract class ImageRepositoryInterface {
  /// Lets user pick image from [source].
  Future<File?> loadImage(ImageSource source);
}

/// Implementation of [ImageRepositoryInterface]
class ImageRepositoryImpl extends ImageRepositoryInterface {
  final ImagePicker _imagePicker;

  /// Constructor for [ImageRepositoryImpl].
  ImageRepositoryImpl(this._imagePicker);

  @override
  Future<File?> loadImage(ImageSource source) async {
    final result = await _imagePicker.pickImage(source: source);

    if (result != null) {
      return File(result.path);
    }

    return null;
  }
}
