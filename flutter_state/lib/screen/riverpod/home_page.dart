import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_ex/common/bottom_bar.dart';
import 'package:state_ex/screen/riverpod/cart.dart';
import 'package:state_ex/screen/riverpod/store.dart';
import 'package:state_ex/state/riverpod/riverpod_badge.dart';
import 'package:state_ex/state/riverpod/riverpod_cart.dart';

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
    return ProviderScope(
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
        bottomNavigationBar: Consumer(
          builder: (context, ref, child) => BottomBar(
            currentIndex: currentIndex,
            cartTotal: "${ref.watch(badgeProvider)}",
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
          ),
        ),
      ),
    );
  }
}