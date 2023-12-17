import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:house_mvvm/src/model/product.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/theme/component/rating.dart';
import 'package:house_mvvm/util/helper/intl_helper.dart';
import 'package:house_mvvm/util/route_path.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    required this.product,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RoutePath.product,
          arguments: product,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: context.color.surface,
          boxShadow: context.deco.shadow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            if (product.productColorList.isNotEmpty)
              AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: product.productColorList.first.imageUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            const SizedBox(height: 4),

            /// Name
            Text(
              product.name.toString(),
              style: context.typo.headline4.copyWith(
                fontWeight: context.typo.semiBold,
              ),
            ),
            const SizedBox(height: 4),

            /// Brand
            Text(
              product.brand.toString(),
              style: context.typo.body2.copyWith(
                fontWeight: context.typo.light,
                color: context.color.subtext,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                /// Price
                Expanded(
                  child: Text(
                    IntlHelper.currency(
                      symbol: product.priceUnit,
                      number: product.price,
                    ),
                    style: context.typo.subtitle2,
                  ),
                ),

                /// Rating
                Rating(rating: product.rating),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
