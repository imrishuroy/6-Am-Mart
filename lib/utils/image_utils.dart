import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<File?> pickImageFromGallery({
    required CropStyle cropStyle,
    required BuildContext context,
    required String? title,
    int? imageQuality,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: imageQuality ?? 70);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        cropStyle: cropStyle,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: title,
            toolbarColor: Colors.grey.shade800,
            //toolbarColor: Theme.of(context).primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(),
        ],
        compressQuality: 70,
      );

      return croppedFile?.path != null ? File(croppedFile!.path) : null;
    }
    return null;
  }
}
