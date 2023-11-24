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

class UploadFashionProduct extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadFashionProduct({Key? key}) : super(key: key);

  @override
  _UploadFashionProductFormState createState() =>
      _UploadFashionProductFormState();
}

class _UploadFashionProductFormState extends State<UploadFashionProduct> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _detailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  File? roductImage;
  Uint8List webImage = Uint8List(8);
  html.File? imageFile;
  Image? previewImage;
  @override
  void dispose() {
    _priceController.dispose();
    _titleController.dispose();
    _detailController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _uploadForm() async {
    final isValid = _formKey.currentState!.validate();
  }

  Future<void> pickImage() async {
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
                      text: 'Add Fashion Product Details',
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
                            decoration: inputDecoration,
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
                                previewImage,
                              ),
                            ),
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
                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: color, // Use the desired color here
                              //   ),
                              // ),
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
                            decoration: inputDecoration,
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
                      text: "Choose an Image For Cover",
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
