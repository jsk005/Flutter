import 'package:flutter/cupertino.dart';
import 'package:house_ex/main.dart';
import 'package:house_ex/theme/component/toast/toast_builder.dart';

abstract class Toast {
  static void show(
    //BuildContext context,
    String text, {
    Duration duration = const Duration(seconds: 3),
  }) async {
    BuildContext? context = MyApp.navigatorKey.currentContext;
    if(context == null) return;

    /// Insert
    GlobalKey<ToastBuilderState> toastKey =
        GlobalKey(); // GlobalKey을 이용하면 특정 StatefulWidget의 State 및 BuildContext에 접근할 수 있다.
    final overlay = Overlay.of(context);
    const animDuration = Duration(microseconds: 333);
    final toast = OverlayEntry(
      builder: (context) => ToastBuilder(
        key: toastKey,
        text: text,
        animDuration: animDuration,
      ),
    );
    overlay.insert(toast);
    print("1 : ${toastKey.currentState?.isShow}");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      print("2 : ${toastKey.currentState?.isShow}");
      toastKey.currentState?.isShow = true;
    });
    print("3 : ${toastKey.currentState?.isShow}");

    /// Remove
    await Future.delayed(duration);
    toastKey.currentState?.isShow = false;
    await Future.delayed(animDuration);
    toast.remove();
  }
}
