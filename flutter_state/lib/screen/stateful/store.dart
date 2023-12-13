import 'package:flutter/material.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';

class Store extends StatelessWidget {
  final List<Product> cartProductList; // 카트에 담긴 상품 목록
  final void Function(Product product) onPressed; // 클릭 이벤트

  const Store({
    required this.cartProductList,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: cartProductList.contains(product),
            onPressed: onPressed,
          );
        },
      ),
    );
  }
}
