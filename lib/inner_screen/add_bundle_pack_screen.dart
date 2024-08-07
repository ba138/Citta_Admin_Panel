// ignore_for_file: unused_local_variable, use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:citta_admin_panel/consts/bundel_pack_field.dart';
import 'package:citta_admin_panel/consts/colors.dart';
import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/dotted_border.dart';
import 'package:google_fonts/google_fonts.dart';

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

  const AddBundlpackScreen({super.key});

  @override
  _AddBundlpackScreenFormState createState() => _AddBundlpackScreenFormState();
}

class _AddBundlpackScreenFormState extends State<AddBundlpackScreen> {
  Uint8List webListedImage1 = Uint8List(8);
  File? _listedImage1;
  Uint8List webListedImage2 = Uint8List(8);
  File? _listedImage2;
  Uint8List webListedImage3 = Uint8List(8);
  File? _listedImage3;
  final _formKey = GlobalKey<FormState>();
  static const menuItems = <String>[
    'Small',
    'Medium',
    'Large',
  ];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems
      .map(
        (String value) => DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        ),
      )
      .toList();
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
  final TextEditingController _saleController = TextEditingController();
  final TextEditingController _price1 = TextEditingController();
  final TextEditingController _price2 = TextEditingController();

  final TextEditingController _price3 = TextEditingController();

  final TextEditingController _price4 = TextEditingController();

  final TextEditingController _price5 = TextEditingController();

  final TextEditingController _price6 = TextEditingController();

  String _btn2SelectedVal = "Small";
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
    _saleController.dispose();
    _price1.dispose();
    _price2.dispose();
    _price3.dispose();
    _price4.dispose();
    _price5.dispose();
    _price6.dispose();

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
    _saleController.clear();
    _price1.clear();
    _price2.clear();
    _price3.clear();
    _price4.clear();
    _price5.clear();
    _price6.clear();

    setState(() {
      _listedImage1 = null;
      _listedImage2 = null;
      _listedImage3 = null;
      previewImage1 = null;
      previewImage2 = null;

      previewImage3 = null;

      previewImage4 = null;

      previewImage5 = null;
      previewImage6 = null;
    });
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
          final imageUrl = await _uploadImageToStorage(
            uuid,
            imageFile,
            weblistedImage,
          );
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
      if (previewImage1 == null &&
          previewImage2 == null &&
          previewImage3 == null &&
          previewImage4 == null &&
          previewImage5 == null &&
          previewImage6 == null) {
        errorDialog(subtitle: 'Please pick up all image', context: context);
        setState(() {
          isLoading = false;
        });
        return;
      }
      try {
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
          'imageUrl': listedImages,
          "size": _btn2SelectedVal,
          'weight': _weightController.text,
          'sellerId': FirebaseAuth.instance.currentUser!.uid,
          'salePrice': _saleController.text,
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
            .collection('saller')
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
      backgroundColor: const Color(0xffF8F8F8),
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
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "Add Bundle Pack Details",
                        style: GoogleFonts.getFont(
                          "Poppins",
                          textStyle: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: AppColor.titleColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColor.borderColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 1.2,
                                width: 1050,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(
                                      6,
                                    ),
                                    border: Border.all(
                                        color: AppColor.borderColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BundleField(
                                              controller: _titleController,
                                              tite: "Bundle Pack Name",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: BundleField(
                                              controller: _weightController,
                                              tite: "Bundle Pack Weight",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: BundleField(
                                              controller: _priceController,
                                              tite: "Bundle Pack Price",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: BundleField(
                                              controller: _detailController,
                                              tite: "Bundle Pack Description",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color:
                                                          AppColor.titleColor,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Container(
                                                  height: 38,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0), // Adjust border radius as needed
                                                    border: Border.all(
                                                      color: AppColor
                                                          .borderColor, // Specify border color
                                                      width:
                                                          1.0, // Specify border width
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 8.0,
                                                      right: 8,
                                                    ),
                                                    child: DropdownButton(
                                                      isExpanded: true,
                                                      underline:
                                                          const SizedBox(),
                                                      value: _btn2SelectedVal,
                                                      hint: const Text(
                                                          'Choose the releated Products'),
                                                      onChanged:
                                                          (String? newValue) {
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "widget.tite",
                                                  style: GoogleFonts.getFont(
                                                    "Poppins",
                                                    textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                    color: Colors.transparent,
                                                    border: Border.all(
                                                        color:
                                                            Colors.transparent),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 250,
                                            width: 250,
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
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        _listedImage3!,
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      ),
                                          ),
                                          Container(
                                            height: 250,
                                            width: 250,
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
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        _listedImage1!,
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      ),
                                          ),
                                          Container(
                                            height: 250,
                                            width: 250,
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
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.file(
                                                        _listedImage2!,
                                                        width: 250,
                                                        height: 250,
                                                        fit: BoxFit.cover,
                                                      ),
                                          ),
                                        ],
                                      ),
                                      // Expanded(
                                      //   child: Container(
                                      //     decoration: BoxDecoration(
                                      //       border: Border.all(
                                      //           color: AppColor.borderColor),
                                      //       borderRadius:
                                      //           BorderRadius.circular(4),
                                      //     ),
                                      //     child: _coverImage == null
                                      //         ? DottedBor(
                                      //             color: color,
                                      //             tap: _pickImage,
                                      //           )
                                      //         : kIsWeb
                                      //             ? Center(
                                      //                 child: Image.memory(
                                      //                   webImage,
                                      //                   fit: BoxFit.fill,
                                      //                 ),
                                      //               )
                                      //             : Center(
                                      //                 child: Image.file(
                                      //                   _coverImage!,
                                      //                   fit: BoxFit.fill,
                                      //                 ),
                                      //               ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColor.borderColor)),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                                color: AppColor.borderColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _titleController1,
                                                      tite: "Product Name",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _detailController1,
                                                      tite: "Product Weight",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller: _price1,
                                                      tite: "Product Price",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Upload Product Image",
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
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: previewImage1 == null
                                                      ? DottedBor(
                                                          color: color,
                                                          tap: _pickImage1,
                                                        )
                                                      : kIsWeb
                                                          ? Center(
                                                              child:
                                                                  Image.memory(
                                                                webImage1,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.file(
                                                                previewImage1!,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                                color: AppColor.borderColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _titleController2,
                                                      tite: "Product Name",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _detailController2,
                                                      tite: "Product Weight",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller: _price2,
                                                      tite: "Product Price",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Upload Product Image",
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
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: previewImage2 == null
                                                      ? DottedBor(
                                                          color: color,
                                                          tap: _pickImage2,
                                                        )
                                                      : kIsWeb
                                                          ? Center(
                                                              child:
                                                                  Image.memory(
                                                                webImage2,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.file(
                                                                _coverImage!,
                                                                fit:
                                                                    BoxFit.fill,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                                color: AppColor.borderColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _titleController3,
                                                      tite: "Product Name",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _detailController3,
                                                      tite: "Product Weight",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller: _price3,
                                                      tite: "Product Price",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Upload Product Image",
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
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: previewImage3 == null
                                                      ? DottedBor(
                                                          color: color,
                                                          tap: _pickImage3,
                                                        )
                                                      : kIsWeb
                                                          ? Center(
                                                              child:
                                                                  Image.memory(
                                                                webImage3,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.file(
                                                                _coverImage!,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                                color: AppColor.borderColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _titleController4,
                                                      tite: "Product Name",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _detailController4,
                                                      tite: "Product Weight",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller: _price4,
                                                      tite: "Product Price",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Upload Product Image",
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
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: previewImage4 == null
                                                      ? DottedBor(
                                                          color: color,
                                                          tap: _pickImage4,
                                                        )
                                                      : kIsWeb
                                                          ? Center(
                                                              child:
                                                                  Image.memory(
                                                                webImage4,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.file(
                                                                _coverImage!,
                                                                fit:
                                                                    BoxFit.fill,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                                color: AppColor.borderColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _titleController5,
                                                      tite: "Product Name",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _detailController5,
                                                      tite: "Product Weight",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller: _price5,
                                                      tite: "Product Price",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Upload Product Image",
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
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: previewImage5 == null
                                                      ? DottedBor(
                                                          color: color,
                                                          tap: _pickImage5,
                                                        )
                                                      : kIsWeb
                                                          ? Center(
                                                              child:
                                                                  Image.memory(
                                                                webImage5,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.file(
                                                                _coverImage!,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                            border: Border.all(
                                                color: AppColor.borderColor)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _titleController6,
                                                      tite: "Product Name",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller:
                                                          _detailController6,
                                                      tite: "Product Weight",
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: BundleField(
                                                      controller: _price6,
                                                      tite: "Product Price",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                "Upload Product Image",
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
                                                height: 12,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: AppColor
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: previewImage6 == null
                                                      ? DottedBor(
                                                          color: color,
                                                          tap: _pickImage6,
                                                        )
                                                      : kIsWeb
                                                          ? Center(
                                                              child:
                                                                  Image.memory(
                                                                webImage6,
                                                                fit: BoxFit
                                                                    .fitWidth,
                                                              ),
                                                            )
                                                          : Center(
                                                              child: Image.file(
                                                                _coverImage!,
                                                                fit:
                                                                    BoxFit.fill,
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
                              ),
                              const SizedBox(
                                height: 20,
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
