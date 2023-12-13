import 'package:flutter/material.dart';
import 'package:state_ex/common/bottom_bar.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/screen/stateful/cart.dart';
import 'package:state_ex/screen/stateful/store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 선택된 index
  int currentIndex = 0;

  /***
   * Homepage 위젯은 Cart 위젯과 Store 위젯의 부모 위젯
   * 부모 위젯에 공유 상태를 등록해야 한다.
   */

  // 카트에 담긴 상품 목록
  List<Product> cartProductList = []; // 공유상태

  // 상품 클릭
  void onProductPressed(Product product) {
    setState(() { // 상태가 변경된 뒤, 자식 위젯들을 갱신하도록 setState()를 호출
      if (cartProductList.contains(product)) {
        cartProductList.remove(product);
      } else {
        cartProductList.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          /// Store
          Store(
            cartProductList: cartProductList,
            onPressed: onProductPressed,
          ),

          /// Cart
          Cart(
            cartProductList: cartProductList,
            onPressed: onProductPressed,
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: currentIndex,
        cartTotal: "${cartProductList.length}",
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
      ),
    );
  }
}