import 'package:flutter/material.dart';
import 'package:house_mvvm/src/view/base_view.dart';
import 'package:house_mvvm/src/view/shopping/shopping_view_model.dart';
import 'package:house_mvvm/src/view/shopping/widget/product_card_grid.dart';
import 'package:house_mvvm/src/view/shopping/widget/product_empty.dart';
import 'package:house_mvvm/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:house_mvvm/theme/component/button/button.dart';
import 'package:house_mvvm/theme/component/cart_button.dart';
import 'package:house_mvvm/theme/component/hide_keyboard.dart';
import 'package:house_mvvm/theme/component/input_field.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';

class ShoppingView extends StatefulWidget {
  const ShoppingView({super.key});

  @override
  State<ShoppingView> createState() => _ShoppingViewState();
}

class _ShoppingViewState extends State<ShoppingView> {
  final ShoppingViewModel shoppingViewModel = ShoppingViewModel();

  @override
  void initState() {
    super.initState();
    shoppingViewModel.searchProductList();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: shoppingViewModel,
      builder: (context, viewModel) => HideKeyboard(
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.shopping),
            actions: [
              /// 설정 버튼
              Button(
                icon: 'option',
                type: ButtonType.flat,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return const SettingBottomSheet();
                    },
                  );
                },
              ),
      
              /// 카트 버튼
              const CartButton(),
            ],
          ),
          //backgroundColor: context.color.surface,
          body: Column(
            children: [
              _SearchBar(
                controller: viewModel.textController,
                onClear: viewModel.searchProductList,
                onSubmitted: (text) => viewModel.searchProductList(),
                onPressed: viewModel.searchProductList,
              ),
      
              /// ProductCardList
              Expanded(
                child: viewModel.productList.isEmpty
                    ? const ProductEmpty()
                    : ProductCardGrid(viewModel.productList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final void Function() onPressed; // 클릭 이벤트
  final TextEditingController? controller;
  final void Function(String text)? onSubmitted;
  final void Function()? onClear;

  const _SearchBar({
    required this.onPressed,
    required this.controller,
    required this.onClear,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          /// 검색
          Expanded(
            child: InputField(
              controller: controller,
              onClear: onClear,
              onSubmitted: (text) => onSubmitted,
              hint: S.current.searchProduct,
            ),
          ),
          const SizedBox(width: 16),

          /// 검색 버튼
          Button(
            icon: 'search',
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
