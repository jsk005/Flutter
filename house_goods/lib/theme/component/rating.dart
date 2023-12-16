import 'package:flutter/material.dart';
import 'package:house_ex/src/service/theme_service.dart';
import 'package:house_ex/theme/component/asset_icon.dart';

class Rating extends StatelessWidget {
  final String rating;

  const Rating({
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AssetIcon(
          'star',
          color: context.color.tertiary,
          size: 20.0,
        ),
        const SizedBox(width: 6),
        Text(
          rating,
          style: context.typo.body1.copyWith(
            color: context.color.subtext,
            fontWeight: context.typo.light,
          ),
        ),
      ],
    );
  }
}
