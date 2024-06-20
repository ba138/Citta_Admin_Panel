// ignore_for_file: library_private_types_in_public_api

import 'package:citta_admin_panel/inner_screen/order_detail_screen.dart';
import 'package:citta_admin_panel/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({
    super.key,
    required this.price,
    required this.title,
    required this.name,
    required this.img,
    required this.date,
    required this.address,
    required this.status,
    required this.buyyerId,
    required this.productId,
    required this.phone,
    required this.paymentType,
    required this.weight,
    required this.uuid,
    required this.size,
    required this.color,
    required this.quantity,
    required this.discount,
  });
  final String title;
  final String price;
  final String name;
  final String img;
  final String date;
  final String address;
  final String status;
  final String buyyerId;
  final String productId;
  final String phone;
  final String paymentType;
  final String weight;
  final String uuid;
  final String size;
  final String color;
  final String quantity;
  final String discount;

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  String formatDateAndTime(String time) {
    DateTime dateTime = DateTime.parse(time);
    String formattedDateTime =
        "${DateFormat.MMMd().format(dateTime)},${DateFormat.y().format(dateTime)},${DateFormat.jm().format(dateTime)}";
    return formattedDateTime;
  }

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
                  widget.img,

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
                      text: widget.title,
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
                            text: widget.name,
                            color: color,
                            textSize: 14,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      formatDateAndTime(
                        widget.date,
                      ),
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
                        text: widget.address,
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
                        text: widget.status,
                        color: color,
                        textSize: 14,
                        isTitle: true,
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OrderDetailScreen(
                            userName: widget.name,
                            phone: widget.phone,
                            imageUrl: widget.img,
                            title: widget.title,
                            price: widget.price,
                            productId: widget.productId,
                            buyyerId: widget.buyyerId,
                            address: widget.address,
                            salePrice: widget.price,
                            paymentType: widget.paymentType,
                            weight: widget.weight,
                            uuid: widget.uuid,
                            status: widget.status,
                            size: widget.size,
                            color: widget.color,
                            items: widget.quantity,
                            discount: widget.discount,
                          ),
                        ),
                      );
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
