import 'package:flutter/material.dart';
import 'package:house_mvvm/src/model/product.dart';
import 'package:house_mvvm/src/repository/product_repository.dart';
import 'package:house_mvvm/src/view/base_view_model.dart';

class ShoppingViewModel extends BaseViewModel {
  List<Product> productList = [];
  final TextEditingController textController = TextEditingController();
  final ProductRepository productRepository = ProductRepository();

  String get keyword => textController.text.trim();

  Future<void> searchProductList() async {
    isBusy = true;
    final results = await Future.wait([
      productRepository.searchProductList(keyword),
      Future.delayed(const Duration(microseconds: 555)),
    ]);
    productList = results[0];
    isBusy = false;
    // notifyListeners();
  }
}
