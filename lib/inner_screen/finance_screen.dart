import 'package:citta_admin_panel/consts/constants.dart';
import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/header.dart';
import 'package:citta_admin_panel/widgets/mobile_container.dart';
import 'package:citta_admin_panel/widgets/order_listview.dart';
import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:citta_admin_panel/widgets/web_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
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

  @override
  void initState() {
    super.initState();
    analyzeOrders();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;

    return Scaffold(
      key: getFinanceScaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Header(
                        fct: () {
                          controlFinanceScreen();
                        },
                      ),
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
                                  title: "Pending",
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
                                  number: "4",
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
                              title: "Pending",
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
