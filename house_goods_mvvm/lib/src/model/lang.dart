import 'package:house_mvvm/util/helper/intl_helper.dart';

class Lang {
  final String ko;
  final String en;

  const Lang({
    required this.ko,
    required this.en,
  });

  Map<String, dynamic> toJson() {
    return {
      'ko': ko,
      'en': en,
    };
  }

  factory Lang.fromJson(Map<String, dynamic> json) {
    return Lang(
      ko: json['ko'] ?? '',
      en: json['en'] ?? '',
    );
  }

  @override
  String toString() => IntlHelper.isKo ? ko : en;

}
