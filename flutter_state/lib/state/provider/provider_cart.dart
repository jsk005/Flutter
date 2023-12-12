import 'package:flutter/material.dart';
import 'package:state_ex/common/product.dart';

// Provider는 ChangeNotifier를 상속 받거나 믹스인한 클래스에서 상태를 가지고 있다.
class ProviderCart with ChangeNotifier {
  /// 카트에 담긴 상품 목록
  List<Product> cartProductList = [];

  /// 상품 클릭
  void onProductPressed(Product product) {
    if (cartProductList.contains(product)) {
      //cartProductList.remove(product); // 참조 복사 문제
      cartProductList = cartProductList.where((cartProduct) {
        return cartProduct != product;
      }).toList();
    } else {
      //cartProductList.add(product); // 참조 복사 문제
      cartProductList = [...cartProductList, product];
      // 전개 연산자(Spread Operator)를 이용하여 새로운 배열을 생성하였다.
    }
    notifyListeners(); // 변경 사항이 있는 경우 notifyListeners()를 호출하여 자식 위젯들을 갱신
  }
}