import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_ex/common/bottom_bar.dart';
import 'package:state_ex/screen/provider/cart.dart';
import 'package:state_ex/screen/provider/store.dart';
import 'package:state_ex/state/provider/provider_badge.dart';
import 'package:state_ex/state/provider/provider_cart.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderCart(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProviderBadge(
            providerCart: context.read(),
          ),
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
        bottomNavigationBar: Selector<ProviderBadge, int>(
          // Selector() : select와 동일하나, 특정 위젯만 갱신
          selector: (context, providerBadge) => providerBadge.counter,
          builder: (context, counter, child) {
            return BottomBar(
              currentIndex: currentIndex,
              cartTotal: "${counter}",
              onTap: (index) => setState(() {
                currentIndex = index;
              }),
            );
          }
        ),
      ),
    );
  }
}