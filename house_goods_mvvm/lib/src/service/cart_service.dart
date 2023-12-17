import 'package:flutter/material.dart';
import 'package:house_mvvm/src/model/cart_item.dart';
import 'package:house_mvvm/util/helper/immutable_helper.dart';

class CartService with ChangeNotifier {
  List<CartItem> cartItemList = const []; // 상품 목록

  // 선택된 상품 목록
  List<CartItem> get selectedCartItemList {
    return cartItemList.where((cartItem) => cartItem.isSelected).toImmutable();
    // cartItemList에서 isSelected 값이 true 항목만 불변 배열로 반환하는 Getter를 구현
  }

  // 상품 추가
  void add(CartItem newCartItem){
    cartItemList = [...cartItemList, newCartItem].toImmutable();
    notifyListeners();
  }

  // 상품 수정
  void update(int selectedIndex, CartItem newCartItem) {
    cartItemList = cartItemList.asMap().entries.map((entry) {
      return entry.key == selectedIndex ? newCartItem : entry.value;
    }).toImmutable();
    notifyListeners();
    /***
     * 업데이트하고 싶은 항목의 인덱스인 selectedIndex에 해당하는 항목을
     * 새로운 newCartItem으로 변경하여 새로운 불변 배열을 생성하도록 구현
     */
  }

  // 상품 삭제
  void delete(List<CartItem> deleteList){
    cartItemList = cartItemList.where((cartItem) {
      return !deleteList.contains(cartItem);
    }).toImmutable();
    notifyListeners();
    /***
     * 삭제하고 싶은 목록을 deleteList로 전달받고,
     * 해당 배열에 들어있지 않은 CartItem만 남긴 불변 배열을 생성하도록 구현
     */
  }


}