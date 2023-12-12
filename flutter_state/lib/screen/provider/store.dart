import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';
import 'package:state_ex/state/provider/provider_cart.dart';

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ProviderCart providerCart = context.watch<ProviderCart>();
    // 자식 위젯에서 context.watch()로 Provider에 접근할 수 있다.
    // context.watch() : notifyListeners() 호출시 위젯 갱신
    // context.read() : notifyListeners()가 호출되어도 갱신하지 않음

    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: providerCart.cartProductList.contains(product),
            onPressed: providerCart.onProductPressed,
          );
        },
      ),
    );
  }
}