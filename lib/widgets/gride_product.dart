import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        stream: FirebaseFirestore.instance.collection("products").snapshots(),
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
              debugPrint(
                snapshot.data!.docs.toString(),
              );
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
                  return ProductWidget(
                    productID: snapshot.data!.docs[index]['id'],
                    price: snapshot.data!.docs[index]["price"],
                    amount: snapshot.data!.docs[index]['weight'],
                    title: snapshot.data!.docs[index]['title'],
                    image: snapshot.data!.docs[index]['imageUrl'],
                    salePrice: snapshot.data!.docs[index]["salePrice"],
                  ); // Return the widget for each item
                },
              );
            }
          }
          debugPrint(
            "${snapshot.data!}",
          );
          return Center(
            child: TextWidget(text: "Something went wrong", color: color),
          );
        });
  }
}
