import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:house_mvvm/src/model/product.dart';
import 'package:house_mvvm/src/view/shopping/widget/product_card.dart';
import 'package:house_mvvm/theme/res/layout.dart';

class ProductCardGrid extends StatelessWidget {
  final List<Product> productList;

  const ProductCardGrid(
      this.productList, {
        super.key,
      });


  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: context.layout(
        2,
        tablet: 3,
        desktop: 4,
      ),
      mainAxisSpacing: 24,
      crossAxisSpacing: 16,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        final product = productList[index];
        return ProductCard(product: product);
      },
    );
  }
}