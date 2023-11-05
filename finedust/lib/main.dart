import 'package:finedust/screen/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'sunflower',
    ),
    home: HomeScreen(),
  ));
}

