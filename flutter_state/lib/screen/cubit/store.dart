import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';
import 'package:state_ex/state/cubit/cubit_cart.dart';

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubitCart = context.watch<CubitCart>();

    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: cubitCart.state.contains(product),
            onPressed: cubitCart.onProductPressed,
          );
        },
      ),
    );
  }
}