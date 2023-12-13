// ignore_for_file: unused_local_variable, annotate_overrides

import 'dart:async';

import 'package:citta_admin_panel/auth/screens/login_screen.dart';
import 'package:citta_admin_panel/screens/main_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(seconds: 6), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (c) => const MainScreen(),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (c) => const LoginScreen()),
          (route) => false,
        );
      }
    });
  }

  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        // width: size.width > 300 ? 300 : size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width / 3,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: AssetImage("assets/images/groceries.png"),
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
