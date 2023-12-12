import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/common/product_tile.dart';
import 'package:state_ex/state/riverpod/riverpod_cart.dart';

class Cart extends ConsumerWidget {
  const Cart({
    super.key,
  });

  // Riverpod은 WidgetRef를 이용해 접근할 수 있다.
  // ref.watch() : 상태 변경시 갱신
  // ref.read() : 갱신 없이 단순 접근

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final List<Product> cartProductList = [];
    final List<Product> cartProductList = ref.watch(cartProvider);

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
            onPressed: ref.read(cartProvider.notifier).onProductPressed,
          );
        },
      ),
    );
  }
}