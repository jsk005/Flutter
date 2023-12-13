import 'package:flutter/material.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';

class Cart extends StatelessWidget {
  /// 카트에 담긴 상품 목록
  //final List<Product> cartProductList = const [];
  final List<Product> cartProductList;
  final void Function(Product product) onPressed; // 클릭 이벤트

  const Cart({
    required this.cartProductList,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: cartProductList.isEmpty

          /// Empty
          ? const Center(
              child: Text(
                "Empty",
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            )

          /// Not Empty
          : ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                Product product = cartProductList[index];
                return ProductTile(
                  product: product,
                  isInCart: true,
                  onPressed: onPressed, // ProductTile 클릭 이벤트 부모로 전달
                );
              },
            ),
    );
  }
}
