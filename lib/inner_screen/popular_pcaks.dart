import 'package:citta_admin_panel/consts/constants.dart';
import 'package:citta_admin_panel/controllers/MenuController.dart';
import 'package:citta_admin_panel/inner_screen/add_bundle_pack_screen.dart';
import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/widgets/buttons.dart';
import 'package:citta_admin_panel/widgets/header.dart';
import 'package:citta_admin_panel/widgets/populr_packs_gride.dart';
import 'package:citta_admin_panel/widgets/side_menu.dart';
import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class PopularPacks extends StatefulWidget {
  const PopularPacks({super.key});

  @override
  State<PopularPacks> createState() => _PopularPacksState();
}

class _PopularPacksState extends State<PopularPacks> {
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: 'All Popular Packs',
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
                                      const AddBundlpackScreen(),
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
                      mobile: PopularPacksGride(
                        crossAxisCount: size.width < 650 ? 2 : 4,
                        childAspectRatio:
                            size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                      ),
                      desktop: PopularPacksGride(
                        childAspectRatio: size.width < 1400 ? 0.8 : 1.05,
                        isInMain: false,
                      ),
                    ),
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
