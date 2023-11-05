import 'package:finedust/component/card_title.dart';
import 'package:finedust/component/main_app_bar.dart';
import 'package:finedust/component/main_card.dart';
import 'package:finedust/component/main_drawer.dart';
import 'package:finedust/component/main_stat.dart';
import 'package:finedust/const/colors.dart';
import 'package:finedust/container/category_card.dart';
import 'package:finedust/container/hourly_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: [
          MainAppBar(),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CategoryCard(),
                const SizedBox(height: 16.0),
                HourlyCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
