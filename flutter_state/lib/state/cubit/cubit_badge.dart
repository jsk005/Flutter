import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/state/cubit/cubit_cart.dart';

class CubitBadge extends Cubit<int> {
  CubitBadge({
    required CubitCart cubitCart,
  }) : super(0) {
    cubitCartSubs = cubitCart.stream.listen((cartProductList) {
      emit(cartProductList.length);
    });
  }

  late final StreamSubscription cubitCartSubs;

  @override
  Future<void> close() {
    cubitCartSubs.cancel();
    return super.close();
  }
}