import 'package:flutter/material.dart';

class MobileContainer extends StatelessWidget {
  const MobileContainer(
      {super.key,
      required this.title,
      required this.number,
      required this.color});
  final String title;
  final String number;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 4,
      width: (MediaQuery.of(context).size.width / 2) - 20,
      color: const Color(0xFFCB0166),
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            number,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
