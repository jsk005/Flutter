import 'package:collection/collection.dart';
import 'package:debounce_throttle/debounce_throttle.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/product/model/product_model.dart';
import 'package:rest/user/model/basket_item_model.dart';
import 'package:rest/user/model/patch_basket_body.dart';
import 'package:rest/user/repository/user_me_repository.dart';

final basketProvider =
    StateNotifierProvider<BasketProvider, List<BasketItemModel>>(
  (ref) {
    final repository = ref.watch(userMeRepositoryProvider);

    return BasketProvider(
      repository: repository,
    );
  },
);

class BasketProvider extends StateNotifier<List<BasketItemModel>> {
  final UserMeRepository repository;
  // debounce 선언 및 초기화
  final updateBasketDebounce = Debouncer(
    Duration(seconds: 1),
    initialValue: null, // 초기값은 null 로, 왜냐 super 생성자에 파라미터로 넘겨줄게 없기 떄문이다.
    checkEquality: false,
  );

  BasketProvider({
    required this.repository,
  }) : super([]) {
    updateBasketDebounce.values.listen(
      (event) {
        patchBasket(); // patchBasket 함수 실행
      },
    );
  }

  /***
   * Debounce : 장바구니에 담아 수량을 증가, 감소시킨 후 맨 마지막 것만 서버에 전송해도록 하는데 유용하다.
   */

  Future<void> patchBasket() async {
    await repository.patchBasket(
      body: PatchBasketBody(
        basket: state
            .map(
              (e) => PatchBasketBodyBasket(
                productId: e.product.id,
                count: e.count,
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> addToBasket({
    required ProductModel product,
  }) async {
    // 요청을 먼저 보내고, 응답이 오면, 캐시를 업데이트 했다.

    // 1) 아직 장바구니에 해당되는 상품이 없다면, 장바구니에 상품을 추가한다.
    // 2) 만약에 이미 들어있다면,  장바구니에 있는 값에 +1을 한다.

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (exists) {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count + 1,
                  )
                : e,
          )
          .toList();
    } else {
      state = [
        ...state,
        BasketItemModel(
          product: product,
          count: 1,
        ),
      ];
    }

    // Optimistic Response (긍정적 응답) : 응답이 성공할거라고 가정하고 상태를 먼저 업데이트함
    //await patchBasket();
    updateBasketDebounce.setValue(null);
  }

  Future<void> removeFromBasket({
    required ProductModel product,
    bool isDelete = false, // true면 count와 관계없이 아예 삭제한다.
  }) async {
    // 1) 장바구니에 상품이 존재할때
    //    1) 상품의 카운트가 1보다 크면 -1한다.
    //    2) 상품의 카운트가 1이면 삭제한다.
    // 2) 상품이 존재하지 않을때
    //    즉시 함수를 반환하고 아무것도 하지 않는다.

    final exists =
        state.firstWhereOrNull((e) => e.product.id == product.id) != null;

    if (!exists) {
      return;
    }

    final existingProduct = state.firstWhere((e) => e.product.id == product.id);

    if (existingProduct.count == 1 || isDelete) {
      state = state
          .where(
            (e) => e.product.id != product.id,
          )
          .toList();
    } else {
      state = state
          .map(
            (e) => e.product.id == product.id
                ? e.copyWith(
                    count: e.count - 1,
                  )
                : e,
          )
          .toList();
    }

    //await patchBasket();
    updateBasketDebounce.setValue(null);
  }
}
