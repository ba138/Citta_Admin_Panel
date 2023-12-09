import 'package:citta_admin_panel/responsive.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            width: size.width > 650 ? 650 : size.width,
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/images/groceries.png"),
                                  fit: BoxFit.contain),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
