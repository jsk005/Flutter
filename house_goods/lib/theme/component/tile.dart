import 'package:flutter/material.dart';
import 'package:house_ex/src/service/theme_service.dart';
import 'package:house_ex/theme/component/asset_icon.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String icon;
  final String title;
  final String subtitle;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent, // behavior은 이벤트를 수신하는 동작을 정의하는 속성
      // translucent : 반투명한 대상 & 시각적으로 뒤에 있는 대상도 이벤트 수신
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            /// Start Icon
            AssetIcon(icon),
            const SizedBox(width: 8),

            /// Title
            Expanded(
              child: Text(
                title,
                style: context.typo.headline5,
              ),
            ),
            const SizedBox(width: 8),

            /// Subtitle
            Text(
              subtitle,
              style: context.typo.subtitle1.copyWith(
                color: context.color.primary,
              ),
            ),
            const SizedBox(width: 8),

            /// End Icon
            const AssetIcon('chevron-right'),
          ],
        ),
      ),
    );
  }
}