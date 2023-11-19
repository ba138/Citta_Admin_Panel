import 'package:citta_admin_panel/services/utils.dart';
import 'package:flutter/material.dart';

import 'text_widget.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({Key? key}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
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
                  'https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvZnJzdHJhd2JlcnJ5X3JlZF9kZWxpY2lvdXNfc3dlZXQtaW1hZ2Utam9iNjIxXzEucG5n.png',

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
                      text: '12x For \$19.9',
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
                            text: '  Hadi K.',
                            color: color,
                            textSize: 14,
                            isTitle: true,
                          ),
                        ],
                      ),
                    ),
                    const Text(
                      '20/03/2022',
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
                        text: '  New HussainAbad Danyore Gilgit',
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
                        text: '  Padding',
                        color: color,
                        textSize: 14,
                        isTitle: true,
                      ),
                    ],
                  ),
                  Container(
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
