import 'package:citta_admin_panel/widgets/fashion_widget.dart';
import 'package:flutter/material.dart';

import '../consts/constants.dart';
import 'product_widgets.dart';

class FashionGrid extends StatelessWidget {
  const FashionGrid({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    this.isInMain = true,
  });
  final int crossAxisCount;
  final double childAspectRatio;
  final bool isInMain;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: isInMain ? 4 : 20,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) {
        return const FashionWidget(); // Return the widget for each item
      },
    );
  }
}
