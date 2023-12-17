import 'package:flutter/material.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/theme/component/base_dialog.dart';
import 'package:house_mvvm/theme/component/button/button.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';

class CartCheckoutDialog extends StatelessWidget {
  final void Function() onCheckoutPressed;

  const CartCheckoutDialog({
    Key? key,
    required this.onCheckoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: S.current.checkout,
      content: Text(
        S.current.checkoutDialogDesc,
        style: context.typo.headline6,
      ),
      actions: [
        /// Checkout
        Button(
          text: S.current.checkout,
          width: double.infinity,
          color: context.color.onPrimary,
          backgroundColor: context.color.primary,
          onPressed: () {
            Navigator.pop(context);
            onCheckoutPressed();
          },
        ),
        const SizedBox(height: 12),

        /// Cancel
        Button(
          text: S.current.cancel,
          width: double.infinity,
          color: context.color.text,
          borderColor: context.color.hint,
          type: ButtonType.outline,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
