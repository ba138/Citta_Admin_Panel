// ignore_for_file: library_private_types_in_public_api

import 'package:citta_admin_panel/inner_screen/order_detail_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class ReviewWidget extends StatefulWidget {
  ReviewWidget({
    super.key,
  });

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
                  "",
                  fit: BoxFit.fill,
                  // height: screenWidth * 0.15,
                  // width: screenWidth * 0.15,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "widget.title",
                      color: color,
                      textSize: 16,
                      isTitle: true,
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          TextWidget(
                            text: 'By',
                            color: Colors.blue,
                            textSize: 16,
                            isTitle: true,
                          ),
                          TextWidget(
                            text: "widget.name",
                            color: color,
                            textSize: 14,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      " widget.date",
                      style: TextStyle(
                        color: color,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextWidget(
                        text: 'Shipping Address:',
                        color: Colors.blue,
                        textSize: 16,
                        isTitle: true,
                      ),
                      TextWidget(
                        text: "widget.address",
                        color: color,
                        textSize: 14,
                        isTitle: true,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Status:',
                        color: Colors.blue,
                        textSize: 16,
                        isTitle: true,
                      ),
                      TextWidget(
                        text: "widget.status",
                        color: color,
                        textSize: 14,
                        isTitle: true,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => OrderDetailScreen(
                      //       userName: widget.name,
                      //       phone: widget.phone,
                      //       imageUrl: widget.img,
                      //       title: widget.title,
                      //       price: widget.price,
                      //       productId: widget.productId,
                      //       buyyerId: widget.buyyerId,
                      //       address: widget.address,
                      //       salePrice: widget.price,
                      //       paymentType: widget.paymentType,
                      //       weight: widget.weight,
                      //       uuid: widget.uuid,
                      //       status: widget.status,
                      //     ),
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 40,
                      width: 80,
                      color: const Color(0xFFCB0166),
                      child: Center(
                        child: TextWidget(
                          text: 'View Detail',
                          color: Colors.white,
                          textSize: 14,
                          isTitle: true,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
