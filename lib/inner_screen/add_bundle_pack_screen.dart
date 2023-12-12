// ignore_for_file: unused_local_variable, use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/dotted_border.dart';

import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../responsive.dart';

class AddBundlpackScreen extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const AddBundlpackScreen({Key? key}) : super(key: key);

  @override
  _AddBundlpackScreenFormState createState() => _AddBundlpackScreenFormState();
}

class _AddBundlpackScreenFormState extends State<AddBundlpackScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _titleController1 = TextEditingController();
  final TextEditingController _detailController1 = TextEditingController();
  final TextEditingController _titleController2 = TextEditingController();
  final TextEditingController _detailController2 = TextEditingController();
  final TextEditingController _titleController3 = TextEditingController();
  final TextEditingController _detailController3 = TextEditingController();
  final TextEditingController _titleController4 = TextEditingController();
  final TextEditingController _detailController4 = TextEditingController();
  final TextEditingController _titleController5 = TextEditingController();
  final TextEditingController _detailController5 = TextEditingController();
  final TextEditingController _titleController6 = TextEditingController();

  final TextEditingController _detailController6 = TextEditingController();

  final TextEditingController _weightController = TextEditingController();

  final TextEditingController _sizeController = TextEditingController();

  File? _coverImage;
  Uint8List webImage = Uint8List(8);

  File? previewImage1;
  Uint8List webImage1 = Uint8List(8);
  File? previewImage2;
  Uint8List webImage2 = Uint8List(8);

  File? previewImage3;
  Uint8List webImage3 = Uint8List(8);
  File? previewImage4;
  Uint8List webImage4 = Uint8List(8);
  File? previewImage5;
  Uint8List webImage5 = Uint8List(8);
  File? previewImage6;
  Uint8List webImage6 = Uint8List(8);
  @override
  void dispose() {
    _priceController.dispose();
    _detailController6.dispose();
    _titleController.dispose();
    _detailController.dispose();
    _weightController.dispose();
    _sizeController.dispose();
    _titleController2.dispose();
    _detailController2.dispose();
    _titleController3.dispose();
    _detailController3.dispose();
    _titleController4.dispose();
    _detailController4.dispose();
    _titleController5.dispose();
    _detailController5.dispose();
    _titleController1.dispose();
    _detailController1.dispose();

    super.dispose();
  }

  void clearForm() {
    _detailController.clear();
    _detailController1.clear();
    _detailController2.clear();
    _detailController3.clear();
    _detailController4.clear();
    _detailController5.clear();
    _titleController.clear();
    _titleController1.clear();
    _titleController2.clear();
    _titleController3.clear();
    _titleController4.clear();
    _titleController5.clear();
    _priceController.clear();
    _sizeController.clear();
    _weightController.clear();
    _titleController6.clear();
    _detailController6.clear();

    setState(() {
      _coverImage = null;
      previewImage1 = null;
      previewImage2 = null;

      previewImage3 = null;

      previewImage4 = null;

      previewImage5 = null;
      previewImage6 = null;
    });
  }

  Future<String> _uploadImageToStorage(
      String uuid, File? imageFile, Uint8List webImageCover) async {
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child('bundle_pack')
          .child("${uuid}jpg");
      if (kIsWeb) {
        await storage.putData(webImageCover);
      } else {
        await storage.putFile(imageFile!);
      }

      // Get download URL
      String imageUrl = await storage.getDownloadURL();
      return imageUrl;
    } catch (error) {
      // Handle the error
      return "";
    }
  }

  bool isLoading = false;
  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      final uuid = const Uuid().v1();
      if (_coverImage == null &&
          previewImage1 == null &&
          previewImage2 == null &&
          previewImage3 == null &&
          previewImage4 == null &&
          previewImage5 == null &&
          previewImage6 == null) {
        errorDialog(subtitle: 'Please pick up all image', context: context);
        return;
      }
      try {
        setState(() {
          isLoading = true;
        });
        final coverImageUrl =
            await _uploadImageToStorage("${uuid}cover", _coverImage!, webImage);
        final previewImageUrl1 =
            await _uploadImageToStorage("${uuid}1", previewImage1!, webImage1);
        final previewImageUrl2 =
            await _uploadImageToStorage("${uuid}2", previewImage2!, webImage2);
        final previewImageUrl3 =
            await _uploadImageToStorage("${uuid}3", previewImage3!, webImage3);
        final previewImageUrl4 =
            await _uploadImageToStorage("${uuid}4", previewImage4!, webImage4);
        final previewImageUrl5 =
            await _uploadImageToStorage("${uuid}5", previewImage5!, webImage5);
        final previewImageUrl6 =
            await _uploadImageToStorage("${uuid}6", previewImage6!, webImage6);
        Map<String, dynamic> myPacks = {
          'id': uuid,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          'imageUrl': coverImageUrl,
          "size": _sizeController.text,
          'weight': _weightController.text,
          'salePrice': "3200",
          'createdAt': Timestamp.now(),
          'product1': {
            "title": _titleController1.text,
            'image': previewImageUrl1,
            'amount': _detailController1.text,
          },
          'product2': {
            "title": _titleController2.text,
            'image': previewImageUrl2,
            'amount': _detailController2.text,
          },
          'product3': {
            "title": _titleController3.text,
            'image': previewImageUrl3,
            'amount': _detailController3.text,
          },
          'product4': {
            "title": _titleController4.text,
            'image': previewImageUrl4,
            'amount': _detailController4.text,
          },
          'product5': {
            "title": _titleController5.text,
            'image': previewImageUrl5,
            'amount': _detailController5.text,
          },
          'product6': {
            "title": _titleController6.text,
            'image': previewImageUrl6,
            'amount': _detailController6.text,
          },
        };
        await FirebaseFirestore.instance
            .collection('bundle pack')
            .doc(uuid)
            .set(myPacks);
        await FirebaseFirestore.instance
            .collection('Saller')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("myPacks")
            .doc(uuid)
            .set(myPacks);
        clearForm();
        Fluttertoast.showToast(
          msg: "Bundle Pack uploaded succefully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      } on FirebaseException catch (error) {
        errorDialog(subtitle: '${error.message}', context: context);
        setState(() {
          isLoading = false;
        });
      } catch (error) {
        errorDialog(subtitle: '$error', context: context);
        setState(() {
          isLoading = false;
        });
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _coverImage = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage = f;
          _coverImage = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _pickImage1() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          previewImage1 = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage1 = f;
          previewImage1 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _pickImage2() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          previewImage2 = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage2 = f;
          previewImage2 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _pickImage3() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          previewImage3 = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage3 = f;
          previewImage3 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _pickImage4() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          previewImage4 = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage4 = f;
          previewImage4 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _pickImage5() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          previewImage5 = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage5 = f;
          previewImage5 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _pickImage6() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          previewImage6 = selected;
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();

        setState(() {
          webImage6 = f;
          previewImage6 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

    var inputDecoration = InputDecoration(
      filled: true,
      fillColor: scaffoldColor,
      border: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.0,
        ),
      ),
    );
    return Scaffold(
      key: getAddProductscaffoldKey,
      drawer: const SideMenu(),
      body: LoadingManager(
        isLoading: isLoading,
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              const Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextWidget(
                        text: 'Add Bundle Pack Details',
                        color: color,
                        isTitle: true,
                      ),
                    ),
                    Container(
                      width: size.width > 650 ? 650 : size.width,
                      color: Theme.of(context).cardColor,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController,
                              key: const ValueKey('Title'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: _coverImage == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              _coverImage!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Product Detail*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              maxLines: 4,
                              controller: _detailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: scaffoldColor,
                                alignLabelWithHint: true,
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: color,
                                ),
                                hintText: 'Write details about Product....',
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Price*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _priceController,
                              key: const ValueKey('Price'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Price';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Price Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Size*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _sizeController,
                              key: const ValueKey('Size'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Size';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Small,Medim,Large",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Weight*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _weightController,
                              key: const ValueKey('weight'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Weight';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The weight Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextWidget(
                                text: 'First Product*',
                                color: color,
                                isTitle: true,
                              ),
                            ),
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController1,
                              key: const ValueKey('Title1'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: previewImage1 == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage1,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage1,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              previewImage1!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Amount*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _detailController1,
                              key: const ValueKey('Amount'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Amount';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Amount Of Product",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextWidget(
                                text: 'Second Product*',
                                color: color,
                                isTitle: true,
                              ),
                            ),
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController2,
                              key: const ValueKey('Title2'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: previewImage2 == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage2,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage2,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              previewImage2!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Amount*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _detailController2,
                              key: const ValueKey('Amount2'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Amount';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Amount Of Product",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextWidget(
                                text: 'Third Product*',
                                color: color,
                                isTitle: true,
                              ),
                            ),
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController3,
                              key: const ValueKey('Title3'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: previewImage3 == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage3,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage3,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              previewImage3!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Amount*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _detailController3,
                              key: const ValueKey('Amount3'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Amount';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Amount Of Product",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextWidget(
                                text: 'Fourth Product*',
                                color: color,
                                isTitle: true,
                              ),
                            ),
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController4,
                              key: const ValueKey('Title4'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: previewImage4 == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage4,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage4,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              previewImage4!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Amount*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _detailController4,
                              key: const ValueKey('Amount4'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Amount';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Amount Of Product",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextWidget(
                                text: 'Fifth Product*',
                                color: color,
                                isTitle: true,
                              ),
                            ),
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController5,
                              key: const ValueKey('Title5'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Product ",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: previewImage5 == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage5,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage5,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              previewImage5!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Amount*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _detailController5,
                              key: const ValueKey('Amount5'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Amount';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Amount Of Product",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextWidget(
                                text: 'Sixth Product*',
                                color: color,
                                isTitle: true,
                              ),
                            ),
                            TextWidget(
                              text: 'Product title*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _titleController6,
                              key: const ValueKey('Title6'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Title';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Name Of Bundle Pack",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14),
                              child: Container(
                                height:
                                    size.width > 650 ? 350 : size.width * 0.45,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: previewImage6 == null
                                    ? DottedBor(
                                        color: color,
                                        tap: _pickImage6,
                                      )
                                    : kIsWeb
                                        ? Center(
                                            child: Image.memory(
                                              webImage6,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : Center(
                                            child: Image.file(
                                              previewImage6!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              text: 'Amount*',
                              color: color,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: _detailController6,
                              key: const ValueKey('Amount6'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Amount';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                hintText: "Enter The Amount Of Product",
                                fillColor: scaffoldColor,
                                border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: color,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ButtonsWidget(
                                    onPressed: () {
                                      clearForm();
                                    },
                                    text: 'Clear form',
                                  ),
                                  ButtonsWidget(
                                    onPressed: () {
                                      _uploadForm();
                                    },
                                    text: 'Upload',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/warning-sign.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("An Error occured"),
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  text: "ok",
                  color: Colors.cyan,
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
}
