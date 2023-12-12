import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_ex/common/product.dart';

final cartProvider = NotifierProvider<RiverpodCart, List<Product>>(() {
  return RiverpodCart();
});

// Notifier를 상속 받은 클래스만 NotifierProvider에 등록 가능
// state의 참조(메모리 주소)가 바뀌는 경우 변경 사항을 알린다.

class RiverpodCart extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [];
  }

  /// 상품 클릭
  void onProductPressed(Product product) {
    if (state.contains(product)) {
      //state.remove(product);
      state = state.where((element) => element != product).toList();
    } else {
      //state.add(product);
      state = [...state, product];
    }
  }
}