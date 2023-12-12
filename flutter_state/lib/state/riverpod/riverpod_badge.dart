import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_ex/common/product.dart';
import 'package:state_ex/state/riverpod/riverpod_cart.dart';

final badgeProvider = NotifierProvider<RiverpodBadge, int>(
  () {
    return RiverpodBadge();
  },
);

// Notifier를 상속 받은 클래스만 NotifierProvider에 등록 가능

class RiverpodBadge extends Notifier<int> {
  @override
  int build() {
    List<Product> cartProductList = ref.watch(cartProvider);
    return cartProductList.length;
  }
}
