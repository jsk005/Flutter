import 'package:flutter/material.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/theme/component/button/button.dart';

class PopButton extends StatelessWidget {
  const PopButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      icon: 'arrow-left',
      color: context.color.text,
      type: ButtonType.flat,
      onPressed: () => Navigator.pop(context),
    );
  }
}