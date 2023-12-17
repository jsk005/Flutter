import 'package:flutter/material.dart';
import 'package:house_mvvm/src/model/product.dart';
import 'package:house_mvvm/src/view/base_view.dart';
import 'package:house_mvvm/src/view/product/product_vew_model.dart';
import 'package:house_mvvm/src/view/product/widget/product_bottom_sheet.dart';
import 'package:house_mvvm/src/view/product/widget/product_color_preview.dart';
import 'package:house_mvvm/src/view/product/widget/product_desc.dart';
import 'package:house_mvvm/src/view/product/widget/product_layout.dart';
import 'package:house_mvvm/theme/component/cart_button.dart';
import 'package:house_mvvm/theme/component/color_picker.dart';
import 'package:house_mvvm/theme/component/pop_button.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  final Product product;

  const ProductView({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: ProductViewModel(
        product: product,
        cartService: context.read(),
      ),
      builder: (context, viewModel) => Scaffold(
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
                  colorIndex: viewModel.colorIndex,
                  product: product,
                ),
                ColorPicker(
                  colorIndex: viewModel.colorIndex,
                  colorList: product.productColorList.map((e) {
                    return e.color;
                  }).toList(),
                  onColorSelected: viewModel.onColorIndexChanged,
                ),

                ProductDesc(product: product),
              ],
            ),
          ),

          /// ProductBottomSheet
          productBottomSheet:  ProductBottomSheet(
            count: viewModel.count,
            product: product,
            onCountChanged: viewModel.onCountChanged,
            onAddToCartPressed: viewModel.onAddToCartPressed,
          ),
        ),
      ),
    );
  }
}
