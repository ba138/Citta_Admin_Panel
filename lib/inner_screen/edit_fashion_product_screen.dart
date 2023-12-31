// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, unnecessary_null_comparison

import 'dart:io';

import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';

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
import '../responsive.dart';

class EditFashionProductScreen extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const EditFashionProductScreen({super.key, required this.id});
  final String id;
  @override
  _EditFashionProductScreenState createState() =>
      _EditFashionProductScreenState();
}

class _EditFashionProductScreenState extends State<EditFashionProductScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  Uint8List webImage = Uint8List(8);
  bool isLoading = false;

  String imageUrl = '';
  String title = '';
  String amount = '';
  String discription = '';
  String price = '';

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProductData();
    // Set the initial values for the controllers
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
    imageUrl = '';
    setState(() {
      _pickedImage = null;
    });
  }

  void getProductData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('fashion')
          .doc(widget.id)
          .get();
      if (productsDoc == null) {
        return;
      } else {
        setState(() {
          _titleController.text = productsDoc.get('title');
          _detailController.text = productsDoc.get('detail');
          _priceController.text = productsDoc.get('price');
        });
        imageUrl = productsDoc.get('imageUrl');
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }
      errorDialog(subtitle: error.toString(), context: context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<String> _uploadImageToStorage(String uuid, File? imageFile) async {
    try {
      final storage = FirebaseStorage.instance
          .ref()
          .child('Fashion_product')
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

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();

      try {
        setState(() {
          isLoading = true;
        });
        if (_pickedImage != null) {
          imageUrl = await _uploadImageToStorage(widget.id, _pickedImage!);
        }

        Map<String, dynamic> myFashionProducts = {
          'id': widget.id,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          'imageUrl': imageUrl,
          'createdAt': Timestamp.now(),
        };
        await FirebaseFirestore.instance
            .collection('fashion')
            .doc(widget.id)
            .set(myFashionProducts);
        await FirebaseFirestore.instance
            .collection('saller')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_products")
            .doc(widget.id)
            .set(myFashionProducts);

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
    // final theme = Utils(context).getTheme;
    final color = Utils(context).color;
    final scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    Size size = Utils(context).getScreenSize;

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
                    // Header(fct: () {
                    //   controlAddProductsMenu();
                    // }),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextWidget(
                        text: 'Edit Product Details',
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
                                hintText: title,
                                filled: true,
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
                              child: Center(
                                child: Container(
                                  height: size.width > 650
                                      ? 350
                                      : size.width * 0.45,
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: _pickedImage == null
                                      ? Image(
                                          image: NetworkImage(imageUrl),
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
                                                _pickedImage!,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    color: const Color(0xFFCB0166),
                                    child: const Center(
                                      child: Text(
                                        "change",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
                            TextFormField(
                              maxLines: 4,
                              key: const ValueKey('Detail'),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Detail ';
                                }
                                return null;
                              },
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
                                hintText: discription,
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
                              text: 'Product Price*',
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
                                hintText: price,
                                filled: true,
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
