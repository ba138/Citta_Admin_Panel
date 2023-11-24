import 'dart:io';

import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';

import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive.dart';
import 'dart:html' as html;

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
  File? roductImage;
  Uint8List webImage = Uint8List(8);
  html.File? imageFile;
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
    super.dispose();
  }

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
  }

  Future<void> pickImage(Image? previewImage) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      final image = Image.memory(Uint8List.fromList(bytes));

      setState(() {
        previewImage = image;
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
      body: Row(
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: dottedBorder(
                                color,
                                pickImage,
                                coverImage,
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
                            controller: _detailController,
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
                            controller: _titleController,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: dottedBorder(
                                color,
                                pickImage,
                                previewImage1,
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
                          TextWidget(
                            text: 'Amount*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _detailController,
                            key: const ValueKey('Amount'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Amount';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              hintText: "Enter The Price Of Product",
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
                            controller: _titleController,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: dottedBorder(
                                color,
                                pickImage,
                                previewImage2,
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
                          TextWidget(
                            text: 'Amount*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _detailController,
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
                            controller: _titleController,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: dottedBorder(
                                color,
                                pickImage,
                                previewImage3,
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
                          TextWidget(
                            text: 'Amount*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _detailController,
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
                            controller: _titleController,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: dottedBorder(
                                color,
                                pickImage,
                                previewImage4,
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
                          TextWidget(
                            text: 'Amount*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _detailController,
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
                            controller: _titleController,
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
                              color: Theme.of(context).scaffoldBackgroundColor,
                              child: dottedBorder(
                                color,
                                pickImage,
                                previewImage5,
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
                          TextWidget(
                            text: 'Amount*',
                            color: color,
                            isTitle: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: _detailController,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ButtonsWidget(
                                  onPressed: () {},
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
    );
  }

  Widget dottedBorder(Color color, Function tap, Image? previewImage) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: previewImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: color,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => tap(),
                    child: TextWidget(
                      text: "Choose an Image",
                      color: const Color(0xFFCB0166),
                    ),
                  ),
                ],
              )
            : previewImage,
      ),
    );
  }
}
