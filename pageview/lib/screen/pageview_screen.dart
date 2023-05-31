import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  Timer? timer;
  final PageController _pageController = PageController(initialPage: 0,viewportFraction: 1.0 );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 4), (timer) {
      int currentPage = _pageController.page!.toInt();
      int nextPage = currentPage + 1;

      if(nextPage > 4){
        nextPage = 0;
      }

      _pageController.animateToPage(nextPage, duration: Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    if(timer != null){
      timer!.cancel();
    }

    super.dispose();
  }

  // https://api.flutter.dev/flutter/widgets/PageView-class.html 참조

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return SafeArea(
      child: Scaffold(
        body: PageView( // PageView는 여러 페이지를 한 화면에서 구현할 수 있도록 해주는 위젯 클래스
          controller: _pageController,
          scrollDirection: Axis.vertical, // page 방향을 수직으로 설정
          children: [1, 2, 3, 4, 5]
              .map(
                (e) => Image.asset(
                  'asset/img/image_$e.jpeg',
                  fit: BoxFit.cover,
                ),
              )
              .toList(),

        ),

      ),
    );
  }
}
