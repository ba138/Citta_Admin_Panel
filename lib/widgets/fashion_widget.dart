// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class FashionWidget extends StatefulWidget {
  const FashionWidget({
    Key? key,
  }) : super(key: key);

  @override
  _FashionWidgetState createState() => _FashionWidgetState();
}

class _FashionWidgetState extends State<FashionWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;

    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 3,
                        child: Image.asset(
                          "assets/images/jacket.jpg", fit: BoxFit.fill,
                          // width: screenWidth * 0.12,
                          height: size.width * 0.12,
                        )),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {},
                                value: 1,
                                child: const Text('Edit'),
                              ),
                              PopupMenuItem(
                                onTap: () {},
                                value: 2,
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ])
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    TextWidget(
                      text: '\$10.99',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          '\$18.89',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: 'Lather jacket',
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
