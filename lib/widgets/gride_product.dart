import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';
import 'product_widgets.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isInMain = true,
  });
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("saller")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("my_products")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: TextWidget(
                  text: "You did not add any product yet",
                  color: color,
                ),
              );
            } else {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: isInMain && snapshot.data!.docs.length > 4
                    ? 4
                    : snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                ),
                itemBuilder: (context, index) {
                  var product = snapshot.data!.docs[index];
                  bool isOnSale = product['isOnSale'];
                  double price = double.parse(product['price']);
                  double salePrice = price;

                  if (isOnSale) {
                    String discountStr = product['discount'];
                    double discount = double.tryParse(discountStr) ?? 0.0;
                    salePrice = price - (price * discount / 100);
                  }

                  return ProductWidget(
                    productID: product['id'],
                    price: price.toStringAsFixed(2), // Original price
                    amount: product['weight'],
                    title: product['title'],
                    image: snapshot.data!.docs[index]['imageUrl'][1],
                    salePrice: salePrice.toStringAsFixed(2), // Sale price
                    detail: product['detail'],
                  );
                },
              );
            }
          }

          return Center(
            child: TextWidget(text: "Something went wrong", color: color),
          );
        });
  }
}
