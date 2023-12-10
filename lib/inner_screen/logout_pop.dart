import 'package:flutter/material.dart';

class LogOutPop extends StatelessWidget {
  const LogOutPop({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 56,
            ),
            const Text(
              "Are you sure you want to logout\n your account",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 44,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: Colors.black),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 44,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: Colors.black54),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 56,
            ),
          ],
        ),
      ),
    );
  }
}
