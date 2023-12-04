// import 'dart:html' as html;
// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePick {
//   static Future<void> pickImage(
//       ImageSource source, html.File? imageFile, Image? previewImage) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);

//     if (pickedFile != null) {
//       final bytes = await pickedFile.readAsBytes();
//       final image = Image.memory(Uint8List.fromList(bytes));

//       imageFile = pickedFile as html.File?;
//       previewImage = image;
//     }
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery(
  BuildContext context,
) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(
        pickedImage.path,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(msg: e.toString());
  }
  return image;
}
