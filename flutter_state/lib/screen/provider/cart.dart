import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';
import 'package:state_ex/state/provider/provider_cart.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final List<Product> cartProductList = [];
    List<Product> cartProductList = context.select<ProviderCart, List<Product>>(
      (providerCart) => providerCart.cartProductList,
    );
    // context.select()로 ProviderCart의 cartProductList가 변경된 경우에만 Cart 위젯을 갱신한다.

    if(cartProductList.isEmpty){
      return Scaffold(
        body: SafeArea(
          child: const Center(
            child: Text(
              "Empty",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
              itemCount: cartProductList.length,
              itemBuilder: (context, index) {
                Product product = cartProductList[index];
                return ProductTile(
                  product: product,
                  isInCart: true,
                  onPressed: context.read<ProviderCart>().onProductPressed,
                  // context.read()를 이용하여 ProviderCart의 onProductPressed() 메소드에 접근한다.
                );
              },
            ),
    );
  }
}
