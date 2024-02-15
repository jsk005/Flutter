import 'package:flutter/material.dart';

abstract class Typo {
  final String name; // 폰트 종류
  final FontWeight light; // 폰트 굵기
  final FontWeight regular;
  final FontWeight semiBold;
  final FontWeight Bold;

  const Typo({
    required this.name,
    required this.light,
    required this.regular,
    required this.semiBold,
    required this.Bold,
  });
}

class NotoSans implements Typo {
  const NotoSans();

  @override
  final String name = 'noto_sans';

  @override
  final FontWeight light = FontWeight.w300;

  @override
  final FontWeight regular = FontWeight.w400;

  @override
  final FontWeight semiBold = FontWeight.w600;

  @override
  final FontWeight Bold = FontWeight.w700;
}