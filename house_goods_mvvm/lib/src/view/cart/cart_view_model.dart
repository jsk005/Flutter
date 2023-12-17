import 'package:house_mvvm/src/model/cart_item.dart';
import 'package:house_mvvm/src/service/cart_service.dart';
import 'package:house_mvvm/src/view/base_view_model.dart';
import 'package:house_mvvm/theme/component/toast/toast.dart';
import 'package:house_mvvm/util/helper/intl_helper.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';

class CartViewModel extends BaseViewModel {
  final CartService cartService;

  CartViewModel({
    required this.cartService,
  }) {
    cartService.addListener(notifyListeners);
  }

  @override
  void dispose(){
    cartService.removeListener(notifyListeners);
    super.dispose();
  }

  /// 전체 CartItem
  List<CartItem> get cartItemList => cartService.cartItemList;

  /// 선택한 CartItem 목록
  List<CartItem> get selectedCartItemList => cartService.selectedCartItemList;

  /// 최종 가격
  String get totalPrice {
    return cartService.selectedCartItemList.isEmpty
        ? '0'
        : IntlHelper.currency(
            symbol: cartService.selectedCartItemList.first.product.priceUnit,
            number: cartService.selectedCartItemList.fold(0, (prev, curr) {
              return prev + curr.count * curr.product.price;
            }),
          );
  }

  /// 선택한 CartItem 삭제
  void onDeletePressed() {
    cartService.delete(cartService.selectedCartItemList);
    Toast.show(S.current.deleteDialogSuccessToast);
  }

  void onCartItemPressed(int index) {
    final cartItem = cartItemList[index];
    cartService.update(
      index,
      cartItem.copyWith(
        isSelected: !cartItem.isSelected,
      ),
    );
  }

  /// CartItem 개수 변경
  void onCountChanged(int index, int count) {
    final cartItem = cartItemList[index];
    cartService.update(
      index,
      cartItem.copyWith(
        count: count,
      ),
    );
  }

  /// 선택한 CartItem 결제
  void onCheckoutPressed() {
    cartService.delete(cartService.selectedCartItemList);
    Toast.show(S.current.checkoutDialogSuccessToast);
  }
}
