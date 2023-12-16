import 'package:flutter/material.dart';
import 'package:house_ex/src/model/cart_item.dart';
import 'package:house_ex/src/model/product.dart';
import 'package:house_ex/src/service/cart_service.dart';
import 'package:house_ex/src/view/product/widget/product_bottom_sheet.dart';
import 'package:house_ex/src/view/product/widget/product_color_preview.dart';
import 'package:house_ex/src/view/product/widget/product_desc.dart';
import 'package:house_ex/src/view/product/widget/product_layout.dart';
import 'package:house_ex/theme/component/cart_button.dart';
import 'package:house_ex/theme/component/color_picker.dart';
import 'package:house_ex/theme/component/pop_button.dart';
import 'package:house_ex/theme/component/toast/toast.dart';
import 'package:house_ex/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final Product product;

  const ProductView({
    required this.product,
    super.key,
  });

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  /// 선택한 수량
  int count = 1;

  /// 선택한 색상
  int colorIndex = 0;

  /// 수량 업데이트 이벤트 함수
  void onCountChanged(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  /// 색상 업데이트 이벤트 함수
  void onColorIndexChanged(int newColorIndex) {
    setState(() {
      colorIndex = newColorIndex;
    });
  }

  /// 카트에 상품 추가
  void onAddToCartPressed() {
    final CartService cartService = context.read();
    final CartItem newCartItem = CartItem(
      colorIndex: colorIndex,
      count: count,
      isSelected: true,
      product: widget.product,
    );
    cartService.add(newCartItem);
    //Toast.show(context, S.current.productAdded(widget.product.name));
    Toast.show(S.current.productAdded(widget.product.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.product),
        leading: const PopButton(),
        titleSpacing: 0,
        actions: const [
          /// 카트 버튼
          CartButton(),
        ],
      ),
      body: ProductLayout(
        productInfo: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 32.0),
          child: Wrap(
            runSpacing: 32,
            alignment: WrapAlignment.center,
            children: [
              ProductColorPreview(
                colorIndex: colorIndex,
                product: widget.product,
              ),
              ColorPicker(
                colorIndex: colorIndex,
                colorList: widget.product.productColorList.map((e) {
                  return e.color;
                }).toList(),
                onColorSelected: onColorIndexChanged,
              ),

              ProductDesc(product: widget.product),
            ],
          ),
        ),

        /// ProductBottomSheet
        productBottomSheet:  ProductBottomSheet(
          count: count,
          product: widget.product,
          onCountChanged: onCountChanged,
          onAddToCartPressed: onAddToCartPressed,
        ),
      ),
    );
  }
}
