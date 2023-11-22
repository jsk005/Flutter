import 'package:flutter/material.dart';
import 'package:rest/user/view/login_screen.dart';
import 'package:rest/user/view/splash_screen.dart';

void main() {
  runApp(_App());
}


class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

