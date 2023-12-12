// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class PopularPacksWidget extends StatefulWidget {
  PopularPacksWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.saleprice,
    required this.coverimage,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.img4,
    required this.img5,
    required this.img6,
  }) : super(key: key);
  final String id;
  final String title;
  final String price;
  final String saleprice;
  final String coverimage;
  final String img1;
  final String img2;
  final String img3;

  final String img4;

  final String img5;

  final String img6;

  @override
  _PopularPacksWidgetState createState() => _PopularPacksWidgetState();
}

class _PopularPacksWidgetState extends State<PopularPacksWidget> {
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
                          "assets/images/vigatable_bundle.jpg",
                          height: size.width * 0.12,
                          fit: BoxFit.fill,
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
                      text: '\$30',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          '\$40',
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: '20kg',
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: 'Pack Of Vigatables',
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/cabbage.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/pepper.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/cabbage.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/molo.jpeg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/images/Tomato.jpg",
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
