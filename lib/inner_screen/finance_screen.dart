import 'package:citta_admin_panel/consts/constants.dart';
import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/models.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/header.dart';
import 'package:citta_admin_panel/widgets/mobile_container.dart';
import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:citta_admin_panel/widgets/web_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  String totalIncome = "0";
  String currentMonthIcome = "0";

  String currentDayicome = "0";

  String pevriousMonthIcome = "0";

  Future<double> calculateSum(Query query) async {
    double totalSalePrice = 0.0;

    QuerySnapshot querySnapshot = await query.get();
    List<DocumentSnapshot> documents = querySnapshot.docs;

    for (DocumentSnapshot document in documents) {
      double salePrice = double.parse(document['salePrice'] ?? '0.0');
      totalSalePrice += salePrice;
    }

    return totalSalePrice;
  }

  String formatDateAndTime(String dateTime) {
    // Assuming the date format in Firestore is 'yyyy-MM-dd HH:mm:ss.SSSSSS'
    DateTime parsedDate = DateTime.parse(dateTime);

    // Format it as needed, for example: 'yyyy-MM-dd HH:mm:ss.SSSSSS'
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss.SSSSSS').format(parsedDate);

    return formattedDate;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    sumAndAssignSalePrices();
  }

  void fetchData() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection("saller")
        .doc(uid)
        .collection("my_orders");

    DateTime currentDate = DateTime.now();
    String todayFormatted = DateFormat('yyyy-MM-dd').format(currentDate);

    // Calculate the first day of the current month
    DateTime firstDayOfCurrentMonth =
        DateTime(currentDate.year, currentDate.month, 1);

    // Calculate the first day of the previous month
    DateTime firstDayOfPreviousMonth =
        firstDayOfCurrentMonth.subtract(const Duration(days: 1));

    Query todayQuery = collectionReference
        .where('date', isGreaterThanOrEqualTo: '$todayFormatted 00:00:00')
        .where('date', isLessThanOrEqualTo: '$todayFormatted 23:59:59');

    Query currentMonthQuery = collectionReference.where('date',
        isGreaterThanOrEqualTo: firstDayOfCurrentMonth.toString());

    Query previousMonthQuery = collectionReference
        .where('date', isGreaterThanOrEqualTo: firstDayOfPreviousMonth.toUtc())
        .where('date', isLessThan: firstDayOfCurrentMonth.toUtc());
    double todayTotalSalePrice = await calculateSum(todayQuery);

    double currentMonthTotalSalePrice = await calculateSum(currentMonthQuery);

    double previousMonthTotalSalePrice = await calculateSum(previousMonthQuery);
    debugPrint(
        'Total sale price for the previous month: $previousMonthTotalSalePrice');

    setState(() {
      currentMonthIcome = currentMonthTotalSalePrice.toString();
      pevriousMonthIcome = previousMonthTotalSalePrice.toString();
      currentDayicome = todayTotalSalePrice.toString();
    });
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

    totalIncome = totalSalePrice.toString();
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
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            text: 'All Finance Details',
                            color: color,
                            textSize: 24,
                            isTitle: true,
                          ),
                          const Spacer(),
                          ButtonsWidget(onPressed: () {}, text: "WithDraw")
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
                                  title: "Total Income",
                                  number: "₹$totalIncome",
                                  color: Colors.white,
                                ),
                                MobileContainer(
                                  title: "Current Month",
                                  number: "₹$currentMonthIcome",
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
                                  title: "Current Day",
                                  number: "₹$currentDayicome",
                                  color: Colors.white,
                                ),
                                MobileContainer(
                                  title: "Previous Month",
                                  number: "₹$pevriousMonthIcome",
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
                              number: "₹$totalIncome",
                              title: "Total Icome",
                            ),
                            WebContainer(
                              number: "₹$currentMonthIcome",
                              title: "Current Month",
                            ),
                            WebContainer(
                              number: "₹$currentDayicome",
                              title: "Current Day",
                            ),
                            WebContainer(
                              number: "₹$pevriousMonthIcome",
                              title: "Previous Month",
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
