import 'package:citta_admin_panel/consts/constants.dart';
import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/widgets/header.dart';
import 'package:citta_admin_panel/widgets/order_listview.dart';
import 'package:citta_admin_panel/widgets/populr_packs_gride.dart';
import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
                        controlProductsMenu();
                        // context.read<MenuController>().controlDashboarkMenu();
                      },
                    ),
                    // Responsive(
                    //   mobile: PopularPacksGride(
                    //     crossAxisCount: size.width < 650 ? 2 : 4,
                    //     childAspectRatio:
                    //         size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                    //   ),
                    //   desktop: PopularPacksGride(
                    //     childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                    //     isInMain: false,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    OrdersList()
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
