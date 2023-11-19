import 'package:citta_admin_panel/inner_screen/all_poducts.dart';
import 'package:citta_admin_panel/inner_screen/fashion.dart';
import 'package:citta_admin_panel/inner_screen/order_screen.dart';
import 'package:citta_admin_panel/inner_screen/popular_pcaks.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../screens/main_screen.dart';
import '../services/utils.dart';
import 'text_widget.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);

    // final color = Utils(context).color;
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/groceries.png",
            ),
          ),
          DrawerListTile(
            title: "Main",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
            icon: Icons.home_filled,
          ),
          DrawerListTile(
            title: "Product",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const AllProducts(),
                ),
              );
            },
            icon: Icons.store,
          ),
          DrawerListTile(
            title: "Popular Packs",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const PopularPacks(),
                ),
              );
            },
            icon: Icons.move_down_outlined,
          ),
          DrawerListTile(
            title: "Fashion",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const FashionView(),
                ),
              );
            },
            icon: Icons.style_outlined,
          ),
          DrawerListTile(
            title: "Orders",
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OrderScreen(),
                ),
              );
            },
            icon: IconlyBold.bag_2,
          ),
          SwitchListTile(
              title: const Text('Theme'),
              secondary: Icon(themeState.getDarkTheme
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined),
              value: theme,
              onChanged: (value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              })
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final color = theme == true ? Colors.white : Colors.black;

    return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: Icon(
          icon,
          size: 18,
        ),
        title: TextWidget(
          text: title,
          color: color,
        ));
  }
}
