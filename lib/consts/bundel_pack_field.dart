import 'package:citta_admin_panel/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BundleField extends StatefulWidget {
  const BundleField({
    super.key,
    required this.controller,
    required this.tite,
  });
  final TextEditingController controller;
  final String tite;

  @override
  State<BundleField> createState() => _BundleFieldState();
}

class _BundleFieldState extends State<BundleField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.tite,
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.titleColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: AppColor.borderColor),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: widget.controller,
              decoration: const InputDecoration(
                  border: InputBorder.none, isDense: true),
            ),
          ),
        ),
      ],
    );
  }
}
