import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_ex/common/bottom_bar.dart';
import 'package:state_ex/screen/cubit/cart.dart';
import 'package:state_ex/screen/cubit/store.dart';
import 'package:state_ex/state/cubit/cubit_badge.dart';
import 'package:state_ex/state/cubit/cubit_cart.dart';

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
        BlocProvider(
          create: (context) => CubitCart(),
        ),
        BlocProvider(
          create: (context) => CubitBadge(cubitCart: context.read()),
        ),
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
        bottomNavigationBar: BlocBuilder<CubitBadge, int>(
          builder: (context, state) => BottomBar(
            currentIndex: currentIndex,
            cartTotal: "$state",
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}