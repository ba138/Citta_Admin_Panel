// ignore_for_file: must_be_immutable

import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  ButtonsWidget({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor,
    this.textColor,
  });
  final VoidCallback onPressed;
  final String text;
  Color? bgColor;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 176,
        decoration: BoxDecoration(
          color: bgColor ?? const Color(0xFFCB0166),
          border: Border.all(
            color: const Color(0xFFCB0166),
          ),
          borderRadius: BorderRadius.circular(
            8,
          ),
        ),
        child: Center(
          child: TextWidget(text: text, color: textColor ?? Colors.white),
        ),
      ),
    );
  }
}
