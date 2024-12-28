import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CropImageService {
  static Future<CroppedFile> cropImages(
      XFile image, BuildContext context) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings: [
        WebUiSettings(
            context: context,
            enableResize: true,
            enableZoom: true,
            showZoomer: true,
            mouseWheelZoom: true,
            enforceBoundary: true,
            viewPort: const CroppieViewPort(height: 450, width: 800),
            boundary: const CroppieBoundary(height: 450, width: 800)),
      ],
    );

    return croppedFile!;
  }
}
