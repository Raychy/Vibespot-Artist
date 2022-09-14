import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:vsartist/constants/app_colors.dart';

class Cropper {
  static Future<File?> cropImage(
    String path,
  ) async {
    var file = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        // : null,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppColors.PRIMARY,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          // lockAspectRatio: widget.lockAspectRatio
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image', aspectRatioLockEnabled: true,
          // aspectRatioLockEnabled: widget.lockAspectRatio,
          // minimumAspectRatio: 1.0,
        ));

    return file;
  }
}
