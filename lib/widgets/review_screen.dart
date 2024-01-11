import 'package:citta_admin_panel/consts/constants.dart';
import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/widgets/header.dart';
import 'package:citta_admin_panel/widgets/review_listview.dart';
import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({super.key, required this.productId, required this.productType});
  String productType;
  String productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    // Size size = Utils(context).getScreenSize;

    return Scaffold(
      key: getOrderScaffoldKey,
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
                        controlOrderScreen();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ReviewListView(
                      productId: widget.productId,
                      productType: widget.productType,
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
