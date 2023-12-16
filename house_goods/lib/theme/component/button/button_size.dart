part of 'button.dart';

// enum은 dart에서 고정된 개수의 상수 값들을 표현할 때 사용된다.
/// 버튼 크기
enum ButtonSize {
  small,
  medium,
  large;

  double get padding {
    switch (this) {
      case ButtonSize.small:
        return 8;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
        return 16;
    }
  }

  TextStyle getTextStyle(BuildContext context) {
    switch (this) {
      case ButtonSize.small:
        return context.typo.subtitle2;
      case ButtonSize.medium:
        return context.typo.subtitle1;
      case ButtonSize.large:
        return context.typo.headline6;
    }
  }
}