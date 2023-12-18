import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/popular_packs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';
import 'text_widget.dart';

class PopularPacksGride extends StatelessWidget {
  const PopularPacksGride({
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
        stream:
            FirebaseFirestore.instance.collection("bundle pack").snapshots(),
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
                  return PopularPacksWidget(
                    id: snapshot.data!.docs[index]["id"],
                    title: snapshot.data!.docs[index]["title"],
                    price: snapshot.data!.docs[index]["price"],
                    saleprice: snapshot.data!.docs[index]["salePrice"],
                    coverimage: snapshot.data!.docs[index]["imageUrl"],
                    weight: snapshot.data!.docs[index]["weight"],
                    img1: snapshot.data!.docs[index]["product1"]['image'],
                    img2: snapshot.data!.docs[index]["product2"]['image'],
                    img3: snapshot.data!.docs[index]["product3"]['image'],
                    img4: snapshot.data!.docs[index]["product4"]['image'],
                    img5: snapshot.data!.docs[index]["product5"]['image'],
                    img6: snapshot.data!.docs[index]["product6"]['image'],
                    title1: snapshot.data!.docs[index]["product1"]['title'],
                    weight1: snapshot.data!.docs[index]["product1"]['amount'],
                    title2: snapshot.data!.docs[index]["product2"]['title'],
                    weight2: snapshot.data!.docs[index]["product2"]['amount'],
                    title3: snapshot.data!.docs[index]["product3"]['title'],
                    weight3: snapshot.data!.docs[index]["product3"]['amount'],
                    title4: snapshot.data!.docs[index]["product4"]['title'],
                    weight4: snapshot.data!.docs[index]["product4"]['amount'],
                    title5: snapshot.data!.docs[index]["product5"]['title'],
                    weight5: snapshot.data!.docs[index]["product5"]['amount'],
                    title6: snapshot.data!.docs[index]["product6"]['title'],
                    weight6: snapshot.data!.docs[index]["product6"]['amount'],
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
