import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  const ButtonsWidget({
    super.key,
    required this.onPressed,
    required this.text,
  });
  final VoidCallback onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 100,
        color: const Color(0xFFCB0166),
        child: Center(
          child: TextWidget(text: text, color: Colors.white),
        ),
      ),
    );
  }
}
