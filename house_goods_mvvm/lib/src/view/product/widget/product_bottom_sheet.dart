import 'package:flutter/material.dart';
import 'package:house_mvvm/src/model/product.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:house_mvvm/theme/component/button/button.dart';
import 'package:house_mvvm/theme/component/counter_button.dart';
import 'package:house_mvvm/theme/res/layout.dart';
import 'package:house_mvvm/util/helper/intl_helper.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';

class ProductBottomSheet extends StatelessWidget {
  final int count;
  final Product product;
  final void Function(int count) onCountChanged;
  final void Function() onAddToCartPressed;

  const ProductBottomSheet({
    super.key,
    required this.count,
    required this.product,
    required this.onCountChanged,
    required this.onAddToCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      isRoundAll: context.layout(false, desktop: true),
      padding: EdgeInsets.only(
        top: context.layout(32, desktop: 16),
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Wrap(
        runSpacing: 16,
        children: [
          Row(
            children: [
              Text(
                S.current.quantity,
                style: context.typo.headline3,
              ),
              const Spacer(),
              CounterButton(
                count: count,
                onChanged: onCountChanged,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                S.current.totalPrice,
                style: context.typo.headline3,
              ),
              const Spacer(),
              /// 금액
              Text(
                IntlHelper.currency(
                  symbol: product.priceUnit,
                  number: product.price * count,
                ),
                style: context.typo.headline3.copyWith(
                  color: context.color.primary,
                ),
              ),
            ],
          ),

          /// 카트에 담기
          Button(
            width: double.infinity,
            size: ButtonSize.large,
            text: S.current.addToCart,
            onPressed: onAddToCartPressed,
          ),
        ],
      ),
    );
  }
}
