import 'package:flutter/material.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';

class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        S.current.cartIsEmpty,
        style: context.typo.headline4.copyWith(
          color: context.color.inactive,
          fontWeight: context.typo.light,
        ),
      ),
    );
  }
}