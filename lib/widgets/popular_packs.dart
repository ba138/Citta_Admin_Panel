// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors_in_immutables

import 'package:citta_admin_panel/inner_screen/edit_popular_pack_screen.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';
import 'text_widget.dart';

class PopularPacksWidget extends StatefulWidget {
  PopularPacksWidget({
    super.key,
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
    required this.weight,
  });
  final String id;
  final String title;
  final String price;
  final String saleprice;
  final String weight;
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
                      child: FancyShimmerImage(
                        imageUrl: widget.coverimage,
                        boxFit: BoxFit.fill,
                        height: size.width * 0.12,
                      ),
                    ),
                    const Spacer(),
                    PopupMenuButton(
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (c) =>
                                          const EditPopularPackScreen(),
                                    ),
                                  );
                                },
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
                      text: widget.saleprice,
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                        visible: true,
                        child: Text(
                          widget.price,
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: color),
                        )),
                    const Spacer(),
                    TextWidget(
                      text: widget.weight,
                      color: color,
                      textSize: 18,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  text: widget.title,
                  color: color,
                  textSize: 20,
                  isTitle: true,
                ),
                Expanded(
                  child: Row(
                    children: [
                      FancyShimmerImage(
                        imageUrl: widget.img2,
                        boxFit: BoxFit.fill,
                        height: 40,
                        width: 40,
                      ),
                      FancyShimmerImage(
                        imageUrl: widget.img1,
                        boxFit: BoxFit.fill,
                        height: 40,
                        width: 40,
                      ),
                      FancyShimmerImage(
                        imageUrl: widget.img4,
                        boxFit: BoxFit.fill,
                        height: 40,
                        width: 40,
                      ),
                      FancyShimmerImage(
                        imageUrl: widget.img5,
                        boxFit: BoxFit.fill,
                        height: 40,
                        width: 40,
                      ),
                      FancyShimmerImage(
                        imageUrl: widget.img6,
                        boxFit: BoxFit.fill,
                        height: 40,
                        width: 40,
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
