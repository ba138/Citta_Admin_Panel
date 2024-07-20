// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';

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

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadProductForm({super.key});

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const menuItems = <String>[
    'New Items',
    'Hot Selling',
    'Lightening Deals',
  ];
  Uint8List webListedImage1 = Uint8List(8);
  File? _listedImage1;
  Uint8List webListedImage2 = Uint8List(8);
  File? _listedImage2;
  Uint8List webListedImage3 = Uint8List(8);
  File? _listedImage3;
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
  String? releatedButton;
  static const releatedmenuItems = <String>[
    'Potatoes',
    'Beets',
    'Onions',
    "Garlic",
    'Pumpkin',
    'Tomatoes',
    'Cucumber',
    'Carrots',
    'Radishes',
    'Broccoli',
    'Kale',
    'Pasta',
    'Rice',
    'Sauces & Gravies',
    'Fruits',
    'Baking Mixes',
    'Flour & Sugar',
    'Fresh Meat',
    'Eggs',
    'Lamb',
    'Fish Meat',
    'Other',
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
  final List<DropdownMenuItem<String>> _dropDownMenuItems2 = menuItems2
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
  final TextEditingController _amountController = TextEditingController();

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  String? _btn2SelectedVal;
  String? _btn2SelectedVal2;
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

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _detailController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void clearForm() {
    _detailController.clear();

    _titleController.clear();
    _amountController.clear();
    _priceController.clear();

    setState(() {
      _pickedImage = null;
      _btn2SelectedVal = null;
      _btn2SelectedVal2 = null;
    });
  }

  Future<String> _uploadImageToStorage(String uuid, File? imageFile) async {
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child('product_images')
          .child('${uuid}jpg');
      if (kIsWeb) {
        await storage.putData(webImage);
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

  bool isLoading = false;

  void _uploadForm() async {
    try {
      if (_pickedImage == null) {
        errorDialog(subtitle: 'Please pick up an image', context: context);
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        errorDialog(subtitle: 'User is not authenticated', context: context);
        return;
      }
      if (releatedButton == null) {
        errorDialog(subtitle: 'Please select the Category', context: context);
        return;
      }

      final _uuid = const Uuid().v1();
      setState(() {
        isLoading = true;
      });

      final imageUrl = await _uploadImageToStorage(_uuid, _pickedImage!);
      Map<String, dynamic> myProducts = {};

      if (_btn2SelectedVal != 'Lightening Deals') {
        myProducts = {
          'id': _uuid,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          "weight": _amountController.text,
          'imageUrl': imageUrl,
          'isOnSale': false,
          'createdAt': Timestamp.now(),
          "sellerId": user.uid,
          "category": _btn2SelectedVal,
          'releated': releatedButton,
        };
      } else {
        myProducts = {
          'id': _uuid,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          "weight": _amountController.text,
          'imageUrl': imageUrl,
          'isOnSale': true,
          'createdAt': Timestamp.now(),
          "sellerId": user.uid,
          "category": _btn2SelectedVal,
          "discount": _btn2SelectedVal2,
          'releated': releatedButton,
        };
      }

      await FirebaseFirestore.instance
          .collection('products')
          .doc(_uuid)
          .set(myProducts);
      await FirebaseFirestore.instance
          .collection('saller')
          .doc(user.uid)
          .collection("my_products")
          .doc(_uuid)
          .set(myProducts);

      clearForm();

      Fluttertoast.showToast(
        msg: "Product uploaded successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    } on FirebaseException catch (error) {
      errorDialog(subtitle: '${error.message}', context: context);
    } catch (error) {
      errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        isLoading = false;
      });
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

  @override
  Widget build(BuildContext context) {
    final color = Utils(context).color;
    Size size = Utils(context).getScreenSize;

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
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(24),
                          child: TextWidget(
                            text: 'Add Product Details',
                            color: color,
                            isTitle: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Name",
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
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _titleController,
                                          key: const ValueKey('Title'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a Title';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: 'Enter Title',
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Dscription",
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
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _detailController,
                                          key: const ValueKey('Detail'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a Detail ';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: 'Please enter a Detail',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Weight",
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
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _amountController,
                                          key: const ValueKey('Weight'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a weight';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: '1kg',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          width: 1.0, // Specify border width
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
                                                  _btn2SelectedVal = newValue);
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
                                width: 16,
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product Price",
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
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _priceController,
                                          key: const ValueKey('Price'),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter a Price';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                            isDense: true,
                                            border: InputBorder.none,
                                            hintText: 'Please enter a Price',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          width: 1.0, // Specify border width
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
                                                  _btn2SelectedVal2 = newValue);
                                            }
                                          },
                                          items: _dropDownMenuItems2,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          width: 1.0, // Specify border width
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
                                                  releatedButton = newValue);
                                            }
                                          },
                                          items: _dropDownReleatedMenuItems,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 300,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
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
                                borderRadius: BorderRadius.circular(4.0),
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
                                borderRadius: BorderRadius.circular(4.0),
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
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonsWidget(
                                onPressed: clearForm,
                                text: 'Clear form',
                                bgColor: Colors.transparent,
                                textColor: Colors.black,
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
                onPressed: () {
                  Navigator.pop(context);
                },
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
