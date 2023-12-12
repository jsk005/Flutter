import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/common/product.dart';

// Cubit은 이벤트를 내부 함수로 구현하였지만, Bloc는 별도 클래스로 선언한다.
@immutable
abstract class CartEvent {
  const CartEvent();
}

class OnProductPressed extends CartEvent {
  // 클릭한 상품을 전달 받는다.
  final Product product;

  const OnProductPressed(this.product);
}

// Bloc<이벤트 타입, 상태 타입>을 상속받아 Bloc클래스를 생성
class BlocCart extends Bloc<CartEvent, List<Product>> {
  BlocCart() : super([]) {
    on<OnProductPressed>((event, emit) {
      if (state.contains(event.product)) {
        //state.remove(event.product);
        //emit(state);
        emit(state.where((element) => element != event.product).toList()); // state 참조 재할당
        // emit(새로운 상태);을 이용해 상태를 변경하고, 알림을 보낸다.
      } else {
        //state.add(event.product);
        //emit(state);
        emit([...state, event.product]);
      }
    });
  }
}

/***
 *  Bloc를 이용한 상태관리
 *  - 스트림 기반으로 작동
 *  - 이벤트(Event) 클래스를 별도로 분리
 *  - 작성해야 하는 코드가 가장 많음
 *  중앙 집중식
 *  - 공유 상태를 한 곳에서 관리하여 상태 변화에 대한 일관성 유지
 *  비즈니스 로직 분리
 *  - 비즈니스 로직(이벤트 & 상태)를 UI와 분리
 *  - 코드 유지보수 용이
 *  - 코드 재사용 가능
 *  불변성(Immutability)
 *   - 상태를 변경할 수 없도록 만들고, 변경 시 새로운 상태 객체를 생성
 *   - 상태변경에 대한 이전 상태를 보존
 *   - 상태 추적 및 디버깅이 용이
 */