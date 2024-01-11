import 'package:flutter/material.dart';

class WebContainer extends StatelessWidget {
  const WebContainer({
    super.key,
    required this.number,
    required this.title,
  });

  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001) // Perspective
        ..rotateX(0.02), // X-axis rotation for a 3D effect
      child: Container(
        height: MediaQuery.of(context).size.height / 5,
        width: (MediaQuery.of(context).size.width / 6) - 20,
        decoration: BoxDecoration(
          color: const Color(0xFFCD2379), // Set the desired color here
          borderRadius: BorderRadius.circular(0.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0.0, 5.0),
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
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
      ),
    );
  }
}
