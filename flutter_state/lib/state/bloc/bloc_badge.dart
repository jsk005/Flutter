import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/state/bloc/bloc_cart.dart';

@immutable
abstract class BadgeEvent {
  const BadgeEvent();
}

// 부모 이벤트 클래스를 만들고, 하위 이벤트들은 이를 상속받아 구현

class OnCartTotalChanged extends BadgeEvent {
  final int total;

  const OnCartTotalChanged(this.total);
}

// Bloc<이벤트 타입, 상태 타입>을 상속받아 Bloc클래스를 생성
class BlocBadge extends Bloc<BadgeEvent, int> {
  BlocBadge({
    required BlocCart blocCart,
  }) : super(0) {
    blocCartSubs = blocCart.stream.listen((cartProductList) {
      add(OnCartTotalChanged(cartProductList.length));
    });

    on<OnCartTotalChanged>((event, emit) {
      emit(event.total); // emit(새로운 상태);을 이용해 상태를 변경하고, 알림을 보낸다.
    });
  }

  late final StreamSubscription blocCartSubs;

  // 다른 Bloc을 listen하는 경우 StreamSubscription을 반환하며,
  // 사용하지 않을 때 cancel()을 실행하여 취소해야 메모리가 낭비되지 않는다.

  @override
  Future<void> close() {
    blocCartSubs.cancel(); // Bloc은 메모리에서 삭제될 때 close() 메소드를 호출한다.
    return super.close();
  }
}