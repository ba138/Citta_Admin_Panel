// ignore_for_file: prefer_if_null_operators, must_be_immutable

import 'package:citta_admin_panel/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class DottedBor extends StatelessWidget {
  DottedBor(
      {super.key, this.previewImage, required this.color, required this.tap});
  Image? previewImage;
  Color color;
  Function tap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: previewImage == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: color,
                    size: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => tap(),
                    child: TextWidget(
                      text: "Choose an Image",
                      color: const Color(0xFFCB0166),
                    ),
                  ),
                ],
              )
            : previewImage,
      ),
    );
  }
}
