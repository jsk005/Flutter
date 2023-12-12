import 'package:flutter/material.dart';
import 'package:state_ex/screen/bloc/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/***
 * Provider 를 테스트할 때는 아래 import 추가
 * import 'package:state_ex/screen/provider/home_page.dart';
 *
 * Riverpod 를 테스트할 때는 아래 import 추가
 * import 'package:state_ex/screen/riverpod/home_page.dart';
 *
 * Cubit 을 테스트할 때는 아래 import 추가
 * import 'package:state_ex/screen/cubit/home_page.dart';
 * 
 * BLOC
 * import 'package:state_ex/screen/bloc/home_page.dart';
 */