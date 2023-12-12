import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/common/bottom_bar.dart';
import 'package:state_ex/screen/bloc/cart.dart';
import 'package:state_ex/screen/bloc/store.dart';
import 'package:state_ex/state/bloc/bloc_badge.dart';
import 'package:state_ex/state/bloc/bloc_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 현재 선택된 index
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // 자식 위젯에서 접근할 수 있도록 BlocProvider로 위젯 트리에 등록
        BlocProvider(
          create: (context) => BlocCart(),
        ),
        BlocProvider(create: (context) => BlocBadge(blocCart: context.read())),
      ],
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: const [
            /// Store
            Store(),

            /// Cart
            Cart(),
          ],
        ),
        bottomNavigationBar: BlocBuilder<BlocBadge, int>(
          builder: (context, total) => BottomBar(
            currentIndex: currentIndex,
            cartTotal: "$total",
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}