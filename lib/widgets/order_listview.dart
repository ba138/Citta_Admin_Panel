import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/order_widget.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(0)),
      ),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("saller")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('my_orders')
            .orderBy("date", descending: true)
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
                  text: "You did not have any order yet",
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
                  String title = data['title'];
                  String price = data['salePrice'];
                  String name = data['name'];
                  String img = data['imageUrl'];
                  String date = data['date'];
                  String address = data['address'];
                  String status = data['status'];
                  String buyyerId = data['buyyerId'];
                  String productId = data['productId'];
                  String phone = data['phone'];
                  String paymentType = data['paymentType'];
                  String weight = data['weight'] ?? '1';
                  String uuid = data['uuid'];
                  return Column(
                    children: [
                      OrdersWidget(
                        title: title,
                        price: price,
                        name: name,
                        img: img,
                        date: date,
                        address: address,
                        status: status,
                        phone: phone,
                        buyyerId: buyyerId,
                        productId: productId,
                        paymentType: paymentType,
                        weight: weight,
                        uuid: uuid,
                        // Add more parameters as needed
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
