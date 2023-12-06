// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

Future pickImageFromGellary(File? _pickedImage, Uint8List webImage) async {
  if (!kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var selected = File(image.path);
      _pickedImage = selected;
    } else {
      Fluttertoast.showToast(msg: "No Image has been Picked");
    }
  } else if (kIsWeb) {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();

      webImage = f;
      _pickedImage = File("a");
    } else {
      Fluttertoast.showToast(msg: "No Image has been Picked");
    }
  } else {
    Fluttertoast.showToast(msg: "Something went wrong");
  }
}
