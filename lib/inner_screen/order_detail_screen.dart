// ignore_for_file: library_private_types_in_public_api, unused_element, unused_local_variable, avoid_web_libraries_in_flutter

import 'dart:io';

import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/services/utils.dart';

import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive.dart';
import 'dart:html' as html;

class OrderDetailScreen extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const OrderDetailScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailScreenFormState createState() => _OrderDetailScreenFormState();
}

class _OrderDetailScreenFormState extends State<OrderDetailScreen> {
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
                      text: 'Order Details',
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(0xFFCB0166),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: 'Name Here',
                                    color: color,
                                    isTitle: true,
                                  ),
                                  TextWidget(
                                    text: 'Phone Number',
                                    color: color,
                                    isTitle: true,
                                  ),
                                  TextWidget(
                                    text: 'Shipping Address',
                                    color: color,
                                    isTitle: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: color,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Container(
                            height: size.width > 650 ? 350 : size.width * 0.45,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("assets/images/Tomato.jpg"),
                                  fit: BoxFit.fill),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Product Name:',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: 'hhhhhh',
                                color: color,
                                isTitle: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Product ID:',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: '123456789',
                                color: color,
                                isTitle: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Product Price:',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: '120',
                                color: color,
                                isTitle: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Product Amount:',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: '1kg',
                                color: color,
                                isTitle: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              TextWidget(
                                text: 'Payment Method:',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: 'Cash On Delivery',
                                color: color,
                                isTitle: true,
                              ),
                            ],
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(18.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //     children: [
                          //       ButtonsWidget(
                          //         onPressed: () {},
                          //         text: 'Clear form',
                          //       ),
                          //       ButtonsWidget(
                          //         onPressed: () {},
                          //         text: 'Send Delivery',
                          //       ),
                          //     ],
                          //   ),
                          // )
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: Container(
                              height: size.width > 650 ? 50 : size.width * 0.10,
                              color: const Color(0xFFCB0166),
                              child: const Center(
                                child: Text(
                                  "Send Delivery",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
          ),
        ],
      ),
    );
  }
}
