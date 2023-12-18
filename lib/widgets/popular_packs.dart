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
    required this.title1,
    required this.weight1,
    required this.title2,
    required this.weight2,
    required this.title3,
    required this.weight3,
    required this.title4,
    required this.weight4,
    required this.title5,
    required this.weight5,
    required this.title6,
    required this.weight6,
    required this.detail,
  });
  final String detail;
  final String id;
  final String title;
  final String price;
  final String saleprice;
  final String weight;
  final String coverimage;
  final String title1;
  final String weight1;
  final String img1;
  final String title2;
  final String weight2;
  final String img2;
  final String title3;
  final String weight3;
  final String img3;
  final String title4;
  final String weight4;

  final String img4;
  final String title5;
  final String weight5;

  final String img5;
  final String title6;
  final String weight6;
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
                                      builder: (c) => EditPopularPackScreen(
                                        title: widget.title,
                                        price: widget.price,
                                        coverimage: widget.coverimage,
                                        saleprice: widget.saleprice,
                                        weight: widget.weight,
                                        id: widget.id,
                                        img1: widget.img1,
                                        title1: widget.title,
                                        weight1: widget.weight1,
                                        img2: widget.img2,
                                        weight2: widget.weight2,
                                        title2: widget.title2,
                                        title3: widget.title3,
                                        weight3: widget.weight3,
                                        img3: widget.img3,
                                        title4: widget.title4,
                                        weight4: widget.weight4,
                                        img4: widget.img4,
                                        title5: widget.title5,
                                        weight5: widget.weight5,
                                        img5: widget.img5,
                                        title6: widget.img6,
                                        weight6: widget.weight6,
                                        img6: widget.img6,
                                        detail: widget.detail,
                                      ),
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
