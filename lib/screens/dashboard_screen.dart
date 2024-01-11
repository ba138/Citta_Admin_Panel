import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/widgets/fashion_gride.dart';
import 'package:citta_admin_panel/widgets/gride_product.dart';
import 'package:citta_admin_panel/widgets/mobile_container.dart';
import 'package:citta_admin_panel/widgets/order_listview.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:citta_admin_panel/widgets/web_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';
import '../services/utils.dart';
import '../widgets/header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  int productnumber = 0;
  int fashionNumber = 0;
  int bundleNumber = 0;
  String totlaIcome = "0";

  Future<void> getDocumentIndex() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("my_products")
          .get();
      setState(() {
        productnumber = querySnapshot.docs.length;
      });
      print("this is product number in firebase:$productnumber");
    } catch (e) {
      print("this is the error in the try catch block of products items:$e");
    }
  }

  Future<void> getFashionIndex() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("myFashionProducts")
          .get();
      setState(() {
        fashionNumber = querySnapshot.docs.length;
      });
      print("this is product number in firebase:$productnumber");
    } catch (e) {
      print("this is the error in the try catch block of products items:$e");
    }
  }

  Future<void> getBundleIndex() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("myPacks")
          .get();
      setState(() {
        bundleNumber = querySnapshot.docs.length;
      });
      print("this is product number in firebase:$productnumber");
    } catch (e) {
      print("this is the error in the try catch block of products items:$e");
    }
  }

  Future<void> sumAndAssignSalePrices() async {
    // Get the query snapshot
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("saller")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_orders")
        .get();

    // Initialize a variable to store the sum
    int totalSalePrice = 0;

    // Iterate through the documents in the query snapshot
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      // Access the 'salePrice' field and convert it to an integer
      int salePrice = int.tryParse(doc['salePrice'] ?? '0') ?? 0;

      // Add the converted salePrice to the total
      totalSalePrice += salePrice;
    }

    // Convert the totalSalePrice back to a string
    totlaIcome = totalSalePrice.toString();

    // Use the totalSalePriceString as needed
    print('Total Sale Price: $totlaIcome');
  }

  @override
  void initState() {
    super.initState();
    getDocumentIndex();
    getFashionIndex();
    getBundleIndex();
    sumAndAssignSalePrices();
  }

  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                // context.read<MenuController>().controlDashboarkMenu();
              },
            ),
            const SizedBox(height: defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'All Details',
                  color: color,
                  textSize: 24,
                  isTitle: true,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MobileContainer(
                                  title: "Total Products",
                                  number: productnumber.toString(),
                                ),
                                MobileContainer(
                                  title: "Total Fashion Products",
                                  number: fashionNumber.toString(),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MobileContainer(
                                  title: "Total Bundle Products",
                                  number: bundleNumber.toString(),
                                ),
                                MobileContainer(
                                  title: "Total Icome",
                                  number: totlaIcome.toString(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // ProductGrid(
                        //   crossAxisCount: size.width < 650 ? 2 : 4,
                        //   childAspectRatio:
                        //       size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                        // ),
                        desktop: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WebContainer(
                                number: productnumber.toString(),
                                title: "Total Products"),
                            WebContainer(
                                number: fashionNumber.toString(),
                                title: "Total Fashion Products"),
                            WebContainer(
                                number: bundleNumber.toString(),
                                title: "Total Bundle Packs"),
                            WebContainer(
                                number: "₹${totlaIcome.toString()}",
                                title: "Total Income"),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // const FashionGrid(),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'All Orders',
                            color: color,
                            textSize: 24,
                            isTitle: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const OrdersList(),
                      const SizedBox(
                        height: 20,
                      ),

                      // MyProductsHome(),
                      // SizedBox(height: defaultPadding),
                      // OrdersScreen(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
