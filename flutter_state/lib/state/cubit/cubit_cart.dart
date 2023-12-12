import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/common/product.dart';

class CubitCart extends Cubit<List<Product>> {
  CubitCart() : super([]);

  /// 상품 클릭
  void onProductPressed(Product product) {
    if (state.contains(product)) {
      //state.remove(product);
      //emit(state);
      emit(state.where((element) => element != product).toList());
    } else {
      //state.add(product);
      //emit(state);
      emit([...state,product]);
    }
  }
}

/***
 * cart_cubit.dart 파일에서 state.remove()와 state.add()을 이용하면
 * state의 참조(메모리 주소)가 바뀌지 않기 때문에 데이터 변경 알림이 작동하지 않는다
 */