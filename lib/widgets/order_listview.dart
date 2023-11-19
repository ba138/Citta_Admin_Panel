import 'package:citta_admin_panel/widgets/order_widget.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return const Column(
              children: [
                OrdersWidget(),
                Divider(
                  thickness: 3,
                ),
              ],
            );
          }),
    );
  }
}
