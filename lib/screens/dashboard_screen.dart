import 'package:citta_admin_panel/responsive.dart';

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
  int productnumber = 0;
  int fashionNumber = 0;
  int bundleNumber = 0;
  String totlaIcome = "0";
  String totalOrders = "0";
  String complete = "0";

  String pending = "0";

  String processing = "0";

  Future<void> analyzeOrders() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("saller")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("my_orders")
          .get();

      int collectionIndex = 0;

      int pendingCount = 0;
      int processingCount = 0;
      int completeCount = 0;

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String status = doc['status'] ?? '';

        if (status == 'pending') {
          pendingCount++;
        } else if (status == 'processing') {
          processingCount++;
        } else if (status == 'Delivered') {
          completeCount++;
        }

        collectionIndex++;
      }

      setState(() {
        totalOrders = collectionIndex.toString();
        pending = pendingCount.toString();
        processing = processingCount.toString();
        complete = completeCount.toString();
      });
    } catch (e) {
      debugPrint('Error analyzing orders: $e');
    }
  }

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
    } catch (e) {
      debugPrint(
          "this is the error in the try catch block of products items:$e");
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
    } catch (e) {
      debugPrint(
          "this is the error in the try catch block of products items:$e");
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
    } catch (e) {
      debugPrint(
          "this is the error in the try catch block of products items:$e");
    }
  }

  Future<void> sumAndAssignSalePrices() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("saller")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("my_orders")
        .get();

    int totalSalePrice = 0;

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      int salePrice = int.tryParse(doc['salePrice'] ?? '0') ?? 0;

      totalSalePrice += salePrice;
    }

    totlaIcome = totalSalePrice.toString();
  }

  @override
  void initState() {
    super.initState();
    getDocumentIndex();
    getFashionIndex();
    getBundleIndex();
    analyzeOrders();
    sumAndAssignSalePrices();
  }

  @override
  Widget build(BuildContext context) {
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
                                  color: color,
                                ),
                                MobileContainer(
                                  title: "Total Fashion Products",
                                  number: fashionNumber.toString(),
                                  color: color,
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
                                  color: color,
                                ),
                                MobileContainer(
                                  title: "Total Icome",
                                  number: totlaIcome.toString(),
                                  color: color,
                                ),
                              ],
                            ),
                          ],
                        ),
                        desktop: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WebContainer(
                              number: productnumber.toString(),
                              title: "Total Products",
                            ),
                            WebContainer(
                              number: fashionNumber.toString(),
                              title: "Total Fashion Products",
                            ),
                            WebContainer(
                              number: bundleNumber.toString(),
                              title: "Total Bundle Packs",
                            ),
                            WebContainer(
                              number: "₹${totlaIcome.toString()}",
                              title: "Total Income",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'Orders Details',
                            color: color,
                            textSize: 24,
                            isTitle: true,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Responsive(
                        mobile: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MobileContainer(
                                  title: "Total Orders",
                                  number: complete,
                                  color: Colors.white,
                                ),
                                MobileContainer(
                                  title: "Recent",
                                  number: pending,
                                  color: Colors.white,
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
                                  title: processing,
                                  number: processing,
                                  color: Colors.white,
                                ),
                                MobileContainer(
                                  title: "Complete",
                                  number: complete,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                        desktop: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WebContainer(
                              number: totalOrders,
                              title: "Total Orders",
                            ),
                            WebContainer(
                              number: pending,
                              title: "Recent",
                            ),
                            WebContainer(
                              number: processing,
                              title: "Processing",
                            ),
                            WebContainer(
                              number: complete,
                              title: "Complete",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
