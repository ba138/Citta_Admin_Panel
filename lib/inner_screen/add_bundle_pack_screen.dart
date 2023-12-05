// ignore_for_file: unused_local_variable, use_build_context_synchronously, library_private_types_in_public_api

import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/screens/loading.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/dotted_border.dart';

import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  Image? coverImage;

  Image? previewImage1;
  Image? previewImage2;

  Image? previewImage3;

  Image? previewImage4;

  Image? previewImage5;
  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _detailController.dispose();
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

    setState(() {
      coverImage = null;
      previewImage1 = null;
      previewImage2 = null;

      previewImage3 = null;

      previewImage4 = null;

      previewImage5 = null;
    });
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
      try {
        await FirebaseFirestore.instance
            .collection('bundle pack')
            .doc(uuid)
            .set({
          'id': uuid,
          'title': _titleController.text,
          'price': _priceController.text,
          'detail': _detailController.text,
          'imageUrl': '',
          'isOnSale': false,
          'createdAt': Timestamp.now(),
          'product1': {
            "title": _titleController1.text,
            'image': "previewImage1",
            'amount': _detailController1.text,
          },
          'product2': {
            "title": _titleController2.text,
            'image': "previewImage2",
            'amount': _detailController2.text,
          },
          'product3': {
            "title": _titleController3.text,
            'image': "previewImage3",
            'amount': _detailController3.text,
          },
          'product4': {
            "title": _titleController4.text,
            'image': "previewImage4",
            'amount': _detailController4.text,
          },
          'product5': {
            "title": _titleController5.text,
            'image': "previewImage5",
            'amount': _detailController5.text,
          },
        });
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

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        coverImage = image;
      });
    }
  }

  Future<void> pickImage1() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        previewImage1 = image;
      });
    }
  }

  Future<void> pickImage2() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        previewImage2 = image;
      });
    }
  }

  Future<void> pickImage3() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        previewImage3 = image;
      });
    }
  }

  Future<void> pickImage4() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        previewImage4 = image;
      });
    }
  }

  Future<void> pickImage5() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        previewImage5 = image;
      });
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
                    // Header(fct: () {
                    //   controlAddProductsMenu();
                    // }),
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
                                child: DottedBor(
                                  color: color,
                                  tap: pickImage,
                                  previewImage: coverImage,
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
                                child: DottedBor(
                                  color: color,
                                  tap: pickImage1,
                                  previewImage: previewImage1,
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
                                child: DottedBor(
                                  color: color,
                                  tap: pickImage2,
                                  previewImage: previewImage2,
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
                                child: DottedBor(
                                  color: color,
                                  tap: pickImage3,
                                  previewImage: previewImage3,
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
                                child: DottedBor(
                                  color: color,
                                  tap: pickImage4,
                                  previewImage: previewImage4,
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
                                child: DottedBor(
                                  color: color,
                                  tap: pickImage5,
                                  previewImage: previewImage5,
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
