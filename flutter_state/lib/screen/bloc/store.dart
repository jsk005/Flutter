import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';
import 'package:state_ex/state/bloc/bloc_cart.dart';

class Store extends StatelessWidget {
  const Store({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final BlocCart blocCart = context.watch();
    
    return Scaffold(
      body: ListView.builder(
        itemCount: storeProductList.length,
        itemBuilder: (context, index) {
          Product product = storeProductList[index];
          return ProductTile(
            product: product,
            isInCart: blocCart.state.contains(product),
            onPressed: (product) => blocCart.add(OnProductPressed(product)),
            // add(이벤트 클래스)로 이벤트를 트리거할 수 있다.
          );
        },
      ),
    );
  }
}