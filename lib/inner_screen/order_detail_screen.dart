// ignore_for_file: library_private_types_in_public_api, unused_element, unused_local_variable, avoid_web_libraries_in_flutter

import 'dart:io';

import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/screens/main_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';

import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../responsive.dart';
import 'dart:html' as html;

class OrderDetailScreen extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const OrderDetailScreen({
    super.key,
    required this.userName,
    required this.phone,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.productId,
    required this.buyyerId,
    required this.address,
    required this.salePrice,
    required this.paymentType,
    required this.weight,
    required this.uuid,
    required this.status,
    required this.size,
  });
  final String userName;
  final String phone;
  final String imageUrl;
  final String title;
  final String price;
  final String productId;
  final String buyyerId;
  final String address;
  final String salePrice;
  final String paymentType;
  final String weight;
  final String uuid;
  final String status;
  final String size;
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
  void updateDeliveryStatus() {
    if (widget.status == "pending") {
      FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('my_orders')
          .doc(widget.uuid)
          .update({'status': 'processing'});
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.buyyerId)
          .collection('my_orders')
          .doc(widget.uuid)
          .update({'status': 'processing'});
      Fluttertoast.showToast(
        msg: "Order is In Processing",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const MainScreen()),
          (route) => false);
    } else if (widget.status == 'processing') {
      FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('my_orders')
          .doc(widget.uuid)
          .update({'status': 'Delivered'});
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.buyyerId)
          .collection('my_orders')
          .doc(widget.uuid)
          .update({'status': 'Delivered'});
      Fluttertoast.showToast(
        msg: "Order is In Complete",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const MainScreen()),
          (route) => false);
    } else {
      Fluttertoast.showToast(
        msg: "Order is has been Complete",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
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

  String imageUrl = '';

  Future<void> getImageUrl() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.buyyerId)
          .get();

      if (documentSnapshot.exists) {
        String imageUrlFromFirestore = documentSnapshot['profilePic'];

        setState(() {
          imageUrl = imageUrlFromFirestore;
        });
      } else {
        debugPrint('Document does not exist');
      }
    } catch (error) {
      debugPrint('Error getting document: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getImageUrl();
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
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: const Color(0xFFCB0166),
                                backgroundImage: NetworkImage(imageUrl),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: widget.userName,
                                    color: color,
                                    isTitle: true,
                                  ),
                                  TextWidget(
                                    text: widget.phone,
                                    color: color,
                                    isTitle: true,
                                  ),
                                  TextWidget(
                                    text: widget.address,
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
                              image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
                                fit: BoxFit.contain,
                              ),
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
                                text: widget.title,
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
                                text: widget.productId,
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
                                text: widget.salePrice,
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
                                text: 'Amount/Items: ',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: widget.weight,
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
                                text: 'Size: ',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: widget.size,
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
                                text: widget.paymentType,
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
                                text: 'Status: ',
                                color: const Color(0xFFCB0166),
                                isTitle: true,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              TextWidget(
                                text: widget.status,
                                color: color,
                                isTitle: true,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: InkWell(
                              onTap: () {
                                updateDeliveryStatus();
                              },
                              child: Container(
                                height:
                                    size.width > 650 ? 50 : size.width * 0.10,
                                color: const Color(0xFFCB0166),
                                child: Center(
                                  child: widget.status == "pending"
                                      ? const Text(
                                          "Send Delivery",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const Text(
                                          "Mark As Complete",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
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
