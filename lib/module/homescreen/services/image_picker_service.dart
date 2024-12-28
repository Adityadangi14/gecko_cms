import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<XFile?> pickImage() async {
    XFile? image;
    final picker = ImagePicker();

    image = await picker.pickImage(source: ImageSource.camera);

    return image;
  }
}
