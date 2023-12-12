import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';
import 'package:state_ex/state/bloc/bloc_cart.dart';

class Cart extends StatelessWidget {
  const Cart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //final List<Product> cartProductList = [];
    final List<Product> cartProductList = context.watch<BlocCart>().state;

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
            onPressed: (product) {
              context.read<BlocCart>().add(OnProductPressed(product));
              // add(이벤트 클래스)로 이벤트를 트리거할 수 있다.
            },
          );
        },
      ),
    );
  }
}