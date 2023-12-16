import 'package:flutter/material.dart';
import 'package:house_ex/util/helper/intl_helper.dart';

class LangService with ChangeNotifier {
  /// 현재 언어
  Locale locale;

  LangService({
    Locale? locale,
  }) : locale = locale ?? IntlHelper.en;

  /// 언어 변경
  void toggleLang() {
    locale = IntlHelper.isKo ? IntlHelper.en : IntlHelper.ko;
    notifyListeners();
  }
}