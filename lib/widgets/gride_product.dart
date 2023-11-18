import 'package:flutter/material.dart';

import '../consts/constants.dart';
import 'product_widgets.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  });
  final int crossAxisCount;
  final double childAspectRatio;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
      ),
      itemBuilder: (context, index) {
        return const ProductWidget(); // Return the widget for each item
      },
    );
  }
}
