import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:house_mvvm/src/service/theme_service.dart';

class AssetIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? size;

  const AssetIcon(
      this.icon, {
        super.key,
        this.color,
        this.size,
      });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? context.color.text,
        BlendMode.srcIn,
      ),
    );
  }
}

/***
 * flutter_svg 2.0.1 버전부터 색상을 변경할 때 colorFilter 를 사용한다.
 */