import 'package:flutter/material.dart';
import 'package:house_mvvm/src/model/product.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/theme/component/rating.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';

class ProductDesc extends StatelessWidget {
  final Product product;

  const ProductDesc({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.description,
                  style: context.typo.headline4.copyWith(
                    fontWeight: context.typo.semiBold,
                  ),
                ),
              ),
              Rating(rating: product.rating),
            ],
          ),
          const SizedBox(height: 24.0),

          /// Content
          Text(
            product.desc.toString(),
            style: context.typo.headline6.copyWith(
              color: context.color.subtext,
            ),
          ),
        ],
      ),
    );
  }
}
