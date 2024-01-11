// ignore_for_file: library_private_types_in_public_api

import 'package:citta_admin_panel/inner_screen/order_detail_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class ReviewWidget extends StatefulWidget {
  ReviewWidget({
    super.key,
    required this.name,
    required this.date,
    required this.profilePic,
    required this.rating,
    required this.comment,
  });
  String name;
  String date;
  String profilePic;
  String rating;
  String comment;
  @override
  _ReviewWidgetState createState() => _ReviewWidgetState();
}

class _ReviewWidgetState extends State<ReviewWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    Color color = theme == true ? Colors.white : Colors.black;
    Size size = Utils(context).getScreenSize;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Theme.of(context).cardColor.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: size.width < 650 ? 3 : 1,
                child: Image.network(
                  widget.profilePic,
                  fit: BoxFit.fill,
                  // height: screenWidth * 0.15,
                  // width: screenWidth * 0.15,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextWidget(
                    text: widget.name,
                    color: color,
                    textSize: 16,
                    isTitle: true,
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        TextWidget(
                          text: "Rating: ",
                          color: const Color(0xFFCB0166),
                          textSize: 14,
                          isTitle: true,
                        ),
                        TextWidget(
                          text: widget.rating,
                          color: color,
                          textSize: 14,
                          isTitle: true,
                        ),
                      ],
                    ),
                  ),
                  FittedBox(
                    child: Row(
                      children: [
                        TextWidget(
                          text: "Comment: ",
                          color: const Color(0xFFCB0166),
                          textSize: 14,
                          isTitle: true,
                        ),
                        TextWidget(
                          text: widget.comment,
                          color: color,
                          textSize: 14,
                          isTitle: true,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(
                      color: color,
                    ),
                  )
                ],
              ),
              const SizedBox(
                width: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
