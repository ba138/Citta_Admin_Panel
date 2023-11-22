// import 'dart:io';

// import 'package:flutter/foundation.dart';
// import 'package:image_picker/image_picker.dart';

// class ImagePick {
//   Future<void> pickImage(File productImage, Uint8List webImage) async {
//     if (!kIsWeb) {
//       final ImagePick picker = ImagePick();
//       XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         var selected = File(image.path);
//         productImage = selected;
//       } else {
//         debugPrint("No Image Picked");
//       }
//     } else if (kIsWeb) {
//       final ImagePick picker = ImagePick();

//       // Assume pickImage returns a Future<XFile?>
//       XFile? image = await picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         var fileBytes = await image.readAsBytes();
//         webImage = fileBytes;
//         productImage = File("a");
//       } else {
//         debugPrint("No Image Picked");
//       }
//     } else {
//       debugPrint("Something Went wrong");
//     }
//   }
// }
