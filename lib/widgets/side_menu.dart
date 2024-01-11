import 'package:citta_admin_panel/auth/screens/login_screen.dart';
import 'package:citta_admin_panel/inner_screen/all_poducts.dart';
import 'package:citta_admin_panel/inner_screen/fashion.dart';
import 'package:citta_admin_panel/inner_screen/order_screen.dart';
import 'package:citta_admin_panel/inner_screen/popular_pcaks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';
import '../screens/main_screen.dart';
import '../services/utils.dart';
import 'text_widget.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    super.key,
  });

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  FirebaseAuth auth = FirebaseAuth.instance;
  void logoutUser() {
    auth.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (c) => const LoginScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);
    final color = theme == false ? Colors.white : const Color(0xFF0a0d2c);
    return Drawer(
      backgroundColor: color,
      elevation: 0,
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
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(0.0), // Adjust the radius as needed
            ),
            child: Row(
              children: [
                Icon(
                  themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  color: theme == true ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    'Theme',
                    style: TextStyle(
                      color: theme == true ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      themeState.setDarkTheme = !theme;
                    });
                  },
                  child: Container(
                    width: 40.0,
                    height: 24.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          0.0), // Adjust the radius as needed
                      color: theme
                          ? Colors.blue
                          : Colors.grey, // Use appropriate colors
                    ),
                    child: Center(
                      child: Text(
                        theme ? 'ON' : 'OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          DrawerListTile(
            title: "Logout",
            press: () {
              logoutUser();
            },
            icon: IconlyBold.logout,
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  });

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
          color: color,
        ),
        title: TextWidget(
          text: title,
          color: color,
        ));
  }
}
