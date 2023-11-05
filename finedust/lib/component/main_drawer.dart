import 'package:finedust/const/colors.dart';
import 'package:flutter/material.dart';

const regions = [
  '서울',
  '경기',
  '부산',
  '대구',
  '대전',
  '인천',
  '광주',
  '울산',
  '세종',
  '경남',
  '경북',
  '전남',
  '전북',
  '충남',
  '충북',
  '강원',
  '제주'
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              '지역 선택',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ),
          ...regions
              .map(
                (e) => ListTile(
                  tileColor: Colors.white,
                  selectedTileColor: lightColor,
                  selectedColor: Colors.black,
                  selected: e == '서울',
                  onTap: () {},
                  title: Text(e),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
