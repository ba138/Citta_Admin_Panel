// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, unnecessary_null_comparison

import 'package:citta_admin_panel/inner_screen/edit_product_screen.dart';
import 'package:citta_admin_panel/widgets/review_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    super.key,
    required this.productID,
    required this.image,
    required this.title,
    required this.price,
    required this.amount,
    required this.salePrice,
    required this.detail,
  });
  final String productID;
  final String image;
  final String title;
  final String price;
  final String amount;
  final String salePrice;
  final String detail;
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool isLoading = false;
  String imageUrl = "";
  bool isAvailable = true;

  Future<void> updateProduct() async {
    try {
      if (isAvailable == true) {
        await FirebaseFirestore.instance
            .collection("saller")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_products")
            .doc(widget.productID)
            .update({
          "stock": "out of Stock",
        });
        await FirebaseFirestore.instance
            .collection("products")
            .doc(widget.productID)
            .delete();
      } else if (isAvailable == false) {
        await FirebaseFirestore.instance
            .collection("products")
            .doc(widget.productID)
            .set({
          'id': widget.productID,
          'title': widget.title,
          'price': widget.price,
          'detail': widget.detail,
          "weight": widget.amount,
          'imageUrl': widget.image,
          'isOnSale': false,
          'createdAt': Timestamp.now(),
          'salePrice': widget.salePrice,
          "sellerId": FirebaseAuth.instance.currentUser!.uid,
        });
        await FirebaseFirestore.instance
            .collection("saller")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_products")
            .doc(widget.productID)
            .update({
          'stock': FieldValue.delete(),
        });
      }
    } catch (e) {
      debugPrint(('this is the try catch block$e'));
    }
  }

  Future<void> checkProductAvailability() async {
    try {
      var docSnapshot = await FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('my_products')
          .doc(widget.productID)
          .get();

      if (docSnapshot.exists) {
        if (docSnapshot.data()!.containsKey('stock')) {
          setState(() {
            isAvailable = false;
          });
          debugPrint("this is after setstate$isAvailable");
        } else {
          setState(() {
            isAvailable = true;
          });
        }
      } else {
        setState(() {
          isAvailable = true;
        });
      }
    } catch (e) {
      print("Error checking product availability: $e");
    }
  }

  @override
  void initState() {
    checkProductAvailability();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(0.0), // Set the desired border radius
        ),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(0),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 3,
                      child: imageUrl == null
                          ? Image.network(
                              "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAMAAACahl6sAAAAMFBMVEXU1NT////Y2Nj7+/va2trm5ubz8/Pf39/29vbe3t7j4+P8/Pzt7e3Z2dn09PTp6enlgXfuAAAEj0lEQVR4nO2dCZarOgxEMVPCkGT/u31N8+mEEIIHVUmf47sC6ghNRhZFkclkMplMJpPJZDKZTCaTyWQymUwmk8lsKLuu75sf+r7rSu2niaNrxrZyK6p2bDrt5wqibtrB7TC0Ta39fH6Uj+ueiIXrw/5r1rdHKmbaXvtJv9JUxxL+PKbRfto9yhAZsxSTb1gfKONXir0XrPb0jXdaYyHssRtujxge2s/+wu0w4H7jetN+/oU+2hz/GcWIp4xpMiZGbQ0TkV6+ptVWUZR3CR3O3ZVTSpnk5q9cVZWUEUlwj0pRiZw9JhRtIuQfC3ctHSLx6hWl2PWQ1uGcSrlykdfh3IWvQzJgPVEIXeIOMkN3kwajwzlyA1wmFrz7DNyXS6Di3YNaCXc4Hc4xDyNFS5N3rjwdPVKHc7yGEWoQokkgOf0VVn4HG4RmEmjImuEELmAOWeDkEki1uKZi6ADH3hlGBAaVvWsYRTCsXHxlwOuAJ5EZfCoBdOqfwHfv8Gw4A8+JJUeHc+j+iuQieCeB9ervoHt3Qn0yg65SKOlwAp0SCYXWDLrcYulwDquDFn3R8bfmCcGORBC6wwVsl3gaIbTEjk7tlPZwBtsknsYip/GR0wg5TR45TYlynqKR1LLjm/bT9COk0yD8edBpDh9OcxzEClv4DwukYxT8px5S/Yv/QEJyEsJECiUlMr7rUg5NGcNOlHeLMutEqFI4c3SEuEUaq4HnRMpn9oLg7qy5RtxA4wxvrBFcy/PmsTHDywvMIWaol1Anf4F1CnE2s4Ae1JGv7sPaEvZNPpS/868r1JBkMijcQYaUXCqXXQFuonTVVTwGcyPvE2mH17tS2Yk6/KC4/KWTvOKqusSmFlNSKS9/kFKiraMobiJKKgN7HySuUOteZv8jOTOaWPkwcUl6vSqFC7p7lAmHdq2N12ohdjeKlZ0oT25RnjIaiFYbuuDwdbW6ke4S5CqtISff0Hi7ymB24VlR9mNQGK7G3lbA+qVsonaL3I1tb/PdBfgJO/sB67A3aks1qpe+P1xE1tXctSPYRW6bk6aUXnYJkpazyFnjT4qGVW6Qr9QtvfaKX8z4HfLaxph1n74Q14KmtFE+sFqttMbWB07zSxmhwx9H1KxLx+CqJXVtqT/YZp42vjwBDMS0i7ozKEeRXS/pA+YkVe4Lgj+IM3oNHQglOjrklWjpkFYi+a0wWIngcaSePX6ViNkEOzDnoUQoCvPzxztC+YR2P2wfkclscl3yGYFqhbbR5TvJZ/fEW8bfSQzC2gHrSWLoMuDoC0kOb8RBZhLcBDOAGUvC4KZ6JlwTPSlI7dB9iOzibb1YE5Evl6GItRAVuYi7XPyJOOyykwpfiUiLJmrFLcHVI/pCWCzBF8mMGiTYJFYNEmwSswYJNMnNrEF+TBLy4dewQYJMYtdDJgK8xFy1uMa/djSZ1J943xInLpqLw/frtcGyd41nEUzcVxqLn7sbd/UJP3c31ql/wqt7Jy7+i8en5zV1lrWHzxmX8E8OMXj8OvF/ELMmjuOWyTOHLcenEOaz4cxxTjRd+D7Z/KDkH+MbT03dnEr6AAAAAElFTkSuQmCC",
                              scale: 5.0,
                              fit: BoxFit.fill,
                              // width: screenWidth * 0.12,
                              height: size.width * 0.12,
                            )
                          : FancyShimmerImage(
                              imageUrl: widget.image,
                              boxFit: BoxFit.fill,
                              height: size.width * 0.12,
                              width: 150,
                            ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0.0), // Set the desired border radius
                        ),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => EditProductScreen(
                                          id: widget.productID),
                                    ),
                                  );
                                },
                                value: 1,
                                child: const Text('Edit'),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('products')
                                      .doc(widget.productID)
                                      .delete();
                                  FirebaseFirestore.instance
                                      .collection('Saller')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .collection("my_products")
                                      .doc(widget.productID)
                                      .delete();
                                },
                                value: 2,
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) => ReviewScreen(
                                        productId: widget.productID,
                                        productType: "products",
                                      ),
                                    ),
                                  );
                                },
                                value: 3,
                                child: const Text('Reviews'),
                              ),
                            ])
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: widget.salePrice,
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          widget.price,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: widget.amount,
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: widget.title,
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
                GestureDetector(
                  onTap: () {
                    updateProduct();

                    setState(() {
                      isAvailable = !isAvailable;
                    });
                    print("after setstate");
                  },
                  child: Container(
                    width: 100.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          0.0), // Adjust the radius as needed
                      color: isAvailable
                          ? const Color(0xFFCB0166)
                          : const Color(0xFFCB0166), // Use appropriate colors
                    ),
                    child: Center(
                      child: Text(
                        isAvailable ? 'InStock' : 'OutOfStock',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
