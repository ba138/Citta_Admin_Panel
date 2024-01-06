import 'package:flutter/material.dart';

class WebContainer extends StatelessWidget {
  WebContainer({
    super.key,
    required this.number,
    required this.title,
  });
  final String title;
  final String number;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: (MediaQuery.of(context).size.width / 6) - 20,
      color: Colors.blue,
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            number,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
