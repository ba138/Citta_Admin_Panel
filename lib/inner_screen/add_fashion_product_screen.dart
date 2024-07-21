// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:citta_admin_panel/consts/bundel_pack_field.dart';
import 'package:citta_admin_panel/consts/colors.dart';
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
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../responsive.dart';

class UploadFashionProduct extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadFashionProduct({super.key});

  @override
  _UploadFashionProductFormState createState() =>
      _UploadFashionProductFormState();
}

class _UploadFashionProductFormState extends State<UploadFashionProduct> {
  static const menuItems2 = <String>[
    '0',
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems2 = menuItems2
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  String? _btn2SelectedVal;
  String? releatedButton;
  String? _btn2SelectedVal2;

  static const releatedmenuItems = <String>[
    "T-Shirts",
    'Shirts',
    'Sweaters',
    'Hoodies',
    "Jeans",
    'Trousers',
    'Shorts',
    'Jackets',
    'Coats',
    'Blazers',
    "Underwear & Socks",
    'Belts',
    'Hats',
    'Gloves',
    'Blouses',
    'Skirts',
    'Leggings',
    'Casual Dresses',
    'Evening Dresses',
    'Work Dresses',
    'Handbags',
    'Others'
  ];
  final List<DropdownMenuItem<String>> _dropDownReleatedMenuItems =
      releatedmenuItems
          .map(
            (String value) => DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            ),
          )
          .toList();

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
  static const menuItems = <String>[
    'New Items',
    'Hot Selling',
    'Lightening Deals',
  ];

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  Uint8List webListedImage1 = Uint8List(8);
  File? _listedImage1;
  Uint8List webListedImage2 = Uint8List(8);
  File? _listedImage2;
  Uint8List webListedImage3 = Uint8List(8);
  File? _listedImage3;

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  File? _colorImage1;
  Uint8List webImage1 = Uint8List(8);
  File? _colorImage2;
  Uint8List webImage2 = Uint8List(8);
  File? _colorImage3;
  Uint8List webImage3 = Uint8List(8);
  File? _colorImage4;
  Uint8List webImage4 = Uint8List(8);
  File? _colorImage5;
  Uint8List webImage5 = Uint8List(8);
  File? _colorImage6;
  Uint8List webImage6 = Uint8List(8);
  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  void clearForm() {
    _detailController.clear();

    _titleController.clear();
    _priceController.clear();

    setState(() {
      _pickedImage = null;
      _colorImage1 = null;
      _colorImage2 = null;
      _listedImage1 = null;
      _listedImage2 = null;
      _listedImage3 = null;
      _colorImage3 = null;

      _colorImage4 = null;

      _colorImage5 = null;

      _colorImage6 = null;
      size1 = Colors.transparent;
      size2 = Colors.transparent;

      size3 = Colors.transparent;

      size4 = Colors.transparent;
      size5 = Colors.transparent;
      sizeList.clear();
      _btn2SelectedVal2 = null;
      releatedButton = null;
    });
  }

  Future<String> _uploadImageToStorage(
      String uuid, File? imageFile, Uint8List? webImage) async {
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child('Fashion_product')
          .child("${uuid}jpg");
      if (kIsWeb) {
        await storage.putData(webImage!);
      } else {
        await storage.putFile(_pickedImage!);
      }

      // Get download URL
      String imageUrl = await storage.getDownloadURL();
      return imageUrl;
    } catch (error) {
      // Handle the error
      return "";
    }
  }

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _pickedImage = selected;
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
          _pickedImage = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _color6Image() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _colorImage6 = selected;
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
          _colorImage6 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _listImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _listedImage1 = selected;
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
          webListedImage1 = f;
          _listedImage1 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _listImage2() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _listedImage2 = selected;
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
          webListedImage2 = f;
          _listedImage2 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _listImage3() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _listedImage3 = selected;
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
          webListedImage3 = f;
          _listedImage3 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _color5Image() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _colorImage5 = selected;
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
          _colorImage5 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _color4Image() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _colorImage4 = selected;
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
          _colorImage4 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _color3Image() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _colorImage3 = selected;
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
          _colorImage3 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _color2Image() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _colorImage2 = selected;
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
          _colorImage2 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  Future<void> _color1Image() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          _colorImage1 = selected;
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
          _colorImage1 = File("a");
        });
      } else {
        Fluttertoast.showToast(msg: "No Image has been Picked");
      }
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  bool isLoading = false;
  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    if (isValid) {
      _formKey.currentState!.save();
      final uuid = const Uuid().v1();
      List<String> listedImages = [];
      Future<void> ListedImage(
          File? imageFile, Uint8List weblistedImage) async {
        if (imageFile != null) {
          var uuid = const Uuid().v1();
          final imageUrl =
              await _uploadImageToStorage(uuid, imageFile, weblistedImage);
          listedImages.add(imageUrl);
        }
      }

      await ListedImage(_listedImage1, webListedImage1);
      await ListedImage(_listedImage2, webListedImage2);
      await ListedImage(_listedImage3, webListedImage3);
      if (listedImages.isEmpty) {
        errorDialog(
            subtitle: 'Please pick up at last one Image', context: context);
        setState(() {
          isLoading = false;
        });
        return;
      }
      if (sizeList.isEmpty) {
        errorDialog(subtitle: 'Select at least one size', context: context);
        setState(() {
          isLoading = false;
        });
        return;
      }

      try {
        List<String> colorList = [];

        // Helper function to upload color images and add to colorList
        Future<void> uploadColorImage(File? imageFile) async {
          if (imageFile != null) {
            var uuid = const Uuid().v1();
            final imageUrl =
                await _uploadImageToStorage(uuid, imageFile, webImage1);
            colorList.add(imageUrl);
          }
        }

        // Upload selected color images
        await uploadColorImage(_colorImage1);
        await uploadColorImage(_colorImage2);
        await uploadColorImage(_colorImage3);
        await uploadColorImage(_colorImage4);
        await uploadColorImage(_colorImage5);
        await uploadColorImage(_colorImage6);
        await uploadColorImage(_listedImage1);
        await uploadColorImage(_listedImage2);
        await uploadColorImage(_listedImage3);

        if (_btn2SelectedVal == null) {
          errorDialog(subtitle: 'Select the related Product', context: context);
          return;
        }
        if (releatedButton == null) {
          errorDialog(
              subtitle: 'Select the Product Category', context: context);
          return;
        }

        Map<String, dynamic> myFashionProducts = {
          'id': uuid,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          'imageUrl': listedImages,
          'createdAt': Timestamp.now(),
          'sellerId': FirebaseAuth.instance.currentUser!.uid,
          'color': colorList,
          'size': sizeList,
          "category": _btn2SelectedVal,
          'releated': releatedButton,
        };

        if (_btn2SelectedVal == 'Lightening Deals') {
          myFashionProducts['discount'] = _btn2SelectedVal2;
        }

        await FirebaseFirestore.instance
            .collection('fashion')
            .doc(uuid)
            .set(myFashionProducts);
        await FirebaseFirestore.instance
            .collection('saller')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("myFashionProducts")
            .doc(uuid)
            .set(myFashionProducts);

        colorList.clear();
        clearForm();
        Fluttertoast.showToast(
          msg: "Fashion Product uploaded successfully",
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

  Color size1 = Colors.transparent;
  Color size2 = Colors.transparent;

  Color size3 = Colors.transparent;

  Color size4 = Colors.transparent;
  Color size5 = Colors.transparent;

  List sizeList = [];
  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;

    return Scaffold(
      backgroundColor: const Color(0xffF8F8F8),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header(fct: () {
                    //   controlAddProductsMenu();
                    // }),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "Add Fashion Product",
                                  style: GoogleFonts.getFont(
                                    "Poppins",
                                    textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.titleColor,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: BundleField(
                                          controller: _titleController,
                                          tite: "Product Name"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: BundleField(
                                          controller: _priceController,
                                          tite: "Product Price"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: BundleField(
                                          controller: _detailController,
                                          tite: "Product Description"),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Color",
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.titleColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 36,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                ),
                                                child: _colorImage1 == null
                                                    ? InkWell(
                                                        onTap: () {
                                                          _color1Image();
                                                        },
                                                        child: const Icon(
                                                            Icons.add),
                                                      )
                                                    : kIsWeb
                                                        ? Image.memory(
                                                            webImage1,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            _colorImage1!,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                              Container(
                                                height: 36,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                ),
                                                child: _colorImage2 == null
                                                    ? InkWell(
                                                        onTap: () {
                                                          _color2Image();
                                                        },
                                                        child: const Icon(
                                                            Icons.add),
                                                      )
                                                    : kIsWeb
                                                        ? Image.memory(
                                                            webImage2,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            _colorImage2!,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                              Container(
                                                height: 36,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                ),
                                                child: _colorImage3 == null
                                                    ? InkWell(
                                                        onTap: () {
                                                          _color3Image();
                                                        },
                                                        child: const Icon(
                                                            Icons.add),
                                                      )
                                                    : kIsWeb
                                                        ? Image.memory(
                                                            webImage3,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            _colorImage3!,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                              Container(
                                                height: 36,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                ),
                                                child: _colorImage4 == null
                                                    ? InkWell(
                                                        onTap: () {
                                                          _color4Image();
                                                        },
                                                        child: const Icon(
                                                            Icons.add),
                                                      )
                                                    : kIsWeb
                                                        ? Image.memory(
                                                            webImage4,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            _colorImage4!,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                              Container(
                                                height: 36,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                ),
                                                child: _colorImage5 == null
                                                    ? InkWell(
                                                        onTap: () {
                                                          _color5Image();
                                                        },
                                                        child: const Icon(
                                                            Icons.add),
                                                      )
                                                    : kIsWeb
                                                        ? Image.memory(
                                                            webImage5,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            _colorImage5!,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                              Container(
                                                height: 36,
                                                width: 32,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          AppColor.borderColor),
                                                ),
                                                child: _colorImage6 == null
                                                    ? InkWell(
                                                        onTap: () {
                                                          _color6Image();
                                                        },
                                                        child: const Icon(
                                                            Icons.add),
                                                      )
                                                    : kIsWeb
                                                        ? Image.memory(
                                                            webImage6,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.file(
                                                            _colorImage6!,
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Size",
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.titleColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      size1 = size1 ==
                                                              AppColor
                                                                  .primaryColor
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .primaryColor;
                                                      if (size1 ==
                                                          AppColor
                                                              .primaryColor) {
                                                        sizeList.add('S');
                                                      } else {
                                                        sizeList.remove('S');
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: size1,
                                                      border: Border.all(
                                                        color: size1 ==
                                                                AppColor
                                                                    .primaryColor
                                                            ? Colors.transparent
                                                            : AppColor
                                                                .borderColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "Small",
                                                          style: GoogleFonts
                                                              .getFont(
                                                            "Poppins",
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: size1 ==
                                                                      AppColor
                                                                          .primaryColor
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .titleColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      size2 = size2 ==
                                                              AppColor
                                                                  .primaryColor
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .primaryColor;
                                                      if (size2 ==
                                                          AppColor
                                                              .primaryColor) {
                                                        sizeList.add('L');
                                                      } else {
                                                        sizeList.remove('L');
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: size2,
                                                      border: Border.all(
                                                        color: size2 ==
                                                                AppColor
                                                                    .primaryColor
                                                            ? Colors.transparent
                                                            : AppColor
                                                                .borderColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "Large",
                                                          style: GoogleFonts
                                                              .getFont(
                                                            "Poppins",
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: size2 ==
                                                                      AppColor
                                                                          .primaryColor
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .titleColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      size3 = size3 ==
                                                              AppColor
                                                                  .primaryColor
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .primaryColor;
                                                      if (size3 ==
                                                          AppColor
                                                              .primaryColor) {
                                                        sizeList.add('XL');
                                                      } else {
                                                        sizeList.remove('XL');
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: size3,
                                                      border: Border.all(
                                                        color: size3 ==
                                                                AppColor
                                                                    .primaryColor
                                                            ? Colors.transparent
                                                            : AppColor
                                                                .borderColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "XL",
                                                          style: GoogleFonts
                                                              .getFont(
                                                            "Poppins",
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: size3 ==
                                                                      AppColor
                                                                          .primaryColor
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .titleColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      size4 = size4 ==
                                                              AppColor
                                                                  .primaryColor
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .primaryColor;
                                                      if (size4 ==
                                                          AppColor
                                                              .primaryColor) {
                                                        sizeList.add('XXL');
                                                      } else {
                                                        sizeList.remove('XXL');
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: size4,
                                                      border: Border.all(
                                                        color: size4 ==
                                                                AppColor
                                                                    .primaryColor
                                                            ? Colors.transparent
                                                            : AppColor
                                                                .borderColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "XXL",
                                                          style: GoogleFonts
                                                              .getFont(
                                                            "Poppins",
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: size4 ==
                                                                      AppColor
                                                                          .primaryColor
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .titleColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      size5 = size5 ==
                                                              AppColor
                                                                  .primaryColor
                                                          ? Colors.transparent
                                                          : AppColor
                                                              .primaryColor;
                                                      if (size5 ==
                                                          AppColor
                                                              .primaryColor) {
                                                        sizeList.add('XXXL');
                                                      } else {
                                                        sizeList.remove('XXXL');
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    height: 38,
                                                    decoration: BoxDecoration(
                                                      color: size5,
                                                      border: Border.all(
                                                        color: size5 ==
                                                                AppColor
                                                                    .primaryColor
                                                            ? Colors.transparent
                                                            : AppColor
                                                                .borderColor,
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Center(
                                                        child: Text(
                                                          "XXXL",
                                                          style: GoogleFonts
                                                              .getFont(
                                                            "Poppins",
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: size5 ==
                                                                      AppColor
                                                                          .primaryColor
                                                                  ? Colors.white
                                                                  : AppColor
                                                                      .titleColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Related Products",
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.titleColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 38,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  4.0), // Adjust border radius as needed
                                              border: Border.all(
                                                color: AppColor
                                                    .borderColor, // Specify border color
                                                width:
                                                    1.0, // Specify border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                              ),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: _btn2SelectedVal,
                                                hint: const Text(
                                                    'Choose the releated Products'),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() =>
                                                        _btn2SelectedVal =
                                                            newValue);
                                                  }
                                                },
                                                items: _dropDownMenuItems,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " Product category",
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.titleColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 38,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  4.0), // Adjust border radius as needed
                                              border: Border.all(
                                                color: AppColor
                                                    .borderColor, // Specify border color
                                                width:
                                                    1.0, // Specify border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                              ),
                                              child: DropdownButton(
                                                isExpanded: true,
                                                underline: const SizedBox(),
                                                value: releatedButton,
                                                hint: const Text(
                                                    'Choose the Product Category'),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() =>
                                                        releatedButton =
                                                            newValue);
                                                  }
                                                },
                                                items:
                                                    _dropDownReleatedMenuItems,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Discount",
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: AppColor.titleColor,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 38,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  4.0), // Adjust border radius as needed
                                              border: Border.all(
                                                color: AppColor
                                                    .borderColor, // Specify border color
                                                width:
                                                    1.0, // Specify border width
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8,
                                              ),
                                              child: DropdownButton(
                                                underline: const SizedBox(),
                                                isExpanded: true,
                                                value: _btn2SelectedVal2,
                                                hint: const Text(
                                                    'Choose the product discount'),
                                                onChanged: (String? newValue) {
                                                  if (newValue != null) {
                                                    setState(() =>
                                                        _btn2SelectedVal2 =
                                                            newValue);
                                                  }
                                                },
                                                items: _dropDownMenuItems2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Size",
                                            style: GoogleFonts.getFont(
                                              "Poppins",
                                              textStyle: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.transparent,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            height: 38,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  4.0), // Adjust border radius as needed
                                              border: Border.all(
                                                color: Colors.transparent,
                                                // Specify border color
                                                width:
                                                    1.0, // Specify border width
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: AppColor.borderColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: _listedImage3 == null
                                          ? DottedBor(
                                              color: color,
                                              tap: _listImage3,
                                            )
                                          : kIsWeb
                                              ? Image.memory(
                                                  webListedImage3,
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  _listedImage3!,
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                    Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: AppColor.borderColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: _listedImage1 == null
                                          ? DottedBor(
                                              color: color,
                                              tap: _listImage,
                                            )
                                          : kIsWeb
                                              ? Image.memory(
                                                  webListedImage1,
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  _listedImage1!,
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                    Container(
                                      height: 300,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        border: Border.all(
                                          color: AppColor.borderColor,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: _listedImage2 == null
                                          ? DottedBor(
                                              color: color,
                                              tap: _listImage2,
                                            )
                                          : kIsWeb
                                              ? Image.memory(
                                                  webListedImage2,
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.file(
                                                  _listedImage2!,
                                                  width: 300,
                                                  height: 300,
                                                  fit: BoxFit.cover,
                                                ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ButtonsWidget(
                                        onPressed: () {
                                          clearForm();
                                        },
                                        text: 'Clear form',
                                        bgColor: Colors.transparent,
                                        textColor: AppColor.titleColor,
                                      ),
                                      const SizedBox(
                                        width: 20,
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
