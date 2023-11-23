import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/inner_screen/add_fashion_product_screen.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/fashion_gride.dart';
import 'package:citta_admin_panel/widgets/header.dart';
import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';
import '../services/utils.dart';

class FashionView extends StatefulWidget {
  const FashionView({super.key});

  @override
  State<FashionView> createState() => _FashionViewState();
}

class _FashionViewState extends State<FashionView> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;

    return Scaffold(
      key: getgridscaffoldKey,
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
              child: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Header(
                      fct: () {
                        controlProductsMenu();
                        // context.read<MenuController>().controlDashboarkMenu();
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: 'All Fashion',
                          color: color,
                          textSize: 18,
                          isTitle: true,
                        ),
                        const Spacer(),
                        ButtonsWidget(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const UploadFashionProduct(),
                                ),
                              );
                            },
                            text: "Add")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Responsive(
                      mobile: FashionGrid(
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: FashionGrid(
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        isInMain: false,
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
