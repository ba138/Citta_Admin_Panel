// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final _formKey = GlobalKey<FormState>();
  static const menuItems = <String>[
    'Grocerry',
    'Fashion',
    'Bundle',
  ];
  static const menuItems2 = <String>[
    'Grocerry',
    'Fashion',
    'Bundle',
  ];

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
  final TextEditingController _salePriceController = TextEditingController();

  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  String? _btn2SelectedVal;
  String? _btn2SelectedVal2;

  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _detailController.dispose();
    _amountController.dispose();
    _salePriceController.dispose();
    super.dispose();
  }

  void clearForm() {
    _detailController.clear();

    _titleController.clear();
    _amountController.clear();
    _priceController.clear();
    _salePriceController.clear();

    setState(() {
      _pickedImage = null;
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
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      final _uuid = const Uuid().v1();
      if (_pickedImage == null) {
        errorDialog(subtitle: 'Please pick up an image', context: context);
        return;
      }
      try {
        setState(() {
          isLoading = true;
        });
        final imageUrl = await _uploadImageToStorage(_uuid, _pickedImage!);

        Map<String, dynamic> myProducts = {
          'id': _uuid,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          "weight": _amountController.text,
          'imageUrl': imageUrl,
          'isOnSale': false,
          'createdAt': Timestamp.now(),
          'salePrice': _salePriceController.text,
          "sellerId": FirebaseAuth.instance.currentUser!.uid,
        };
        await FirebaseFirestore.instance
            .collection('products')
            .doc(_uuid)
            .set(myProducts);
        await FirebaseFirestore.instance
            .collection('saller')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_products")
            .doc(_uuid)
            .set(myProducts);

        clearForm();
        Fluttertoast.showToast(
          msg: "Product uploaded succefully",
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
      backgroundColor: const Color(0xffF5F5F5),
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
                  padding: const EdgeInsets.all(16),
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
                                    TextWidget(
                                      text: 'product name',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust border radius as needed
                                        border: Border.all(
                                          color: Colors
                                              .grey, // Specify border color
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
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
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          border: InputBorder.none,
                                          hintText: 'Enter Title',
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
                                    TextWidget(
                                      text: 'product description',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust border radius as needed
                                        border: Border.all(
                                          color: Colors
                                              .grey, // Specify border color
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
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
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          border: InputBorder.none,
                                          hintText: 'Please enter a Detail',
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
                                    TextWidget(
                                      text: 'Product Weight',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust border radius as needed
                                        border: Border.all(
                                          color: Colors
                                              .grey, // Specify border color
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: _amountController,
                                        key: const ValueKey('Amount'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a Amount';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          border: InputBorder.none,
                                          hintText: 'Please enter a Amount',
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
                                    TextWidget(
                                      text: 'Product Categorie',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust border radius as needed
                                        border: Border.all(
                                          color: Colors
                                              .grey, // Specify border color
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
                                          value: _btn2SelectedVal,
                                          hint: const Text(
                                              'Choose the product Categories'),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              setState(() =>
                                                  _btn2SelectedVal = newValue);
                                            }
                                          },
                                          items: _dropDownMenuItems,
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
                                    TextWidget(
                                      text: 'Product Price',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust border radius as needed
                                        border: Border.all(
                                          color: Colors
                                              .grey, // Specify border color
                                          width: 1.0, // Specify border width
                                        ),
                                      ),
                                      child: TextFormField(
                                        controller: _detailController,
                                        key: const ValueKey('Price'),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter a Price';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 16.0),
                                          border: InputBorder.none,
                                          hintText: 'Please enter a Price',
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
                                    TextWidget(
                                      text: 'Related Products',
                                      color: color,
                                      isTitle: true,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8.0), // Adjust border radius as needed
                                        border: Border.all(
                                          color: Colors
                                              .grey, // Specify border color
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
                                          value: _btn2SelectedVal2,
                                          hint: const Text(
                                              'Choose the releated Products'),
                                          onChanged: (String? newValue) {
                                            if (newValue != null) {
                                              setState(() =>
                                                  _btn2SelectedVal2 = newValue);
                                            }
                                          },
                                          items: _dropDownMenuItems2,
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
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: size.width > 650 ? 350 : size.width * 0.45,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(
                                  8.0), // Adjust border radius as needed
                              border: Border.all(
                                color: Colors.grey, // Specify border color
                                width: 1.0, // Specify border width
                              ),
                            ),
                            child: _pickedImage == null
                                ? DottedBor(
                                    color: color,
                                    tap: _pickImage,
                                  )
                                : kIsWeb
                                    ? Image.memory(
                                        webImage,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      )
                                    : Image.file(
                                        _pickedImage!,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.fill,
                                      ),
                          ),
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
                                onPressed: _uploadForm,
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
