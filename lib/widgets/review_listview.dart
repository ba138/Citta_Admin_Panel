import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/order_widget.dart';
import 'package:citta_admin_panel/widgets/review_widget.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';

class ReviewListView extends StatelessWidget {
  ReviewListView(
      {super.key, required this.productId, required this.productType});
  String productId;
  String productType;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection(productType)
            .doc(productId)
            .collection('commentsAndRatings')
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
                  text: "This product did not have any review yet!",
                  color: color,
                ),
              );
            } else {
              return ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;

                  // Access data like title, price, etc.
                  String name = data['userName'];
                  String rating = data['currentUserRating'].toString();
                  String img = data['profilePic'];
                  String date = data['time'];
                  String comment = data['comment'];

                  return Column(
                    children: [
                      ReviewWidget(
                        name: name,
                        date: date,
                        profilePic: img,
                        rating: rating,
                        comment: comment,
                      ),
                      const Divider(
                        thickness: 3,
                      ),
                    ],
                  );
                }).toList(),
              );
            }
          }

          debugPrint("${snapshot.data!}");
          return Center(
            child: TextWidget(text: "Something went wrong", color: color),
          );
        },
      ),
    );
  }
}
