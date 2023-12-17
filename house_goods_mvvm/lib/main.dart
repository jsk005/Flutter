import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:house_mvvm/src/service/cart_service.dart';
import 'package:house_mvvm/src/service/lang_service.dart';
import 'package:house_mvvm/src/service/theme_service.dart';
import 'package:house_mvvm/src/view/shopping/shopping_view.dart';
import 'package:house_mvvm/util/lang/generated/l10n.dart';
import 'package:house_mvvm/util/route_path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeService()),
        ChangeNotifierProvider(
          create: (context) => LangService(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartService(),
        ),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, child) {
        return Overlay(
          initialEntries: [
            OverlayEntry(builder: (context) => child!),
          ],
        );
      },
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.watch<LangService>().locale,
      theme: context.themeService.themeData,
      //home: const ShoppingView(),
      initialRoute: RoutePath.shopping,
      onGenerateRoute: RoutePath.onGenerateRoute,
    );
  }
}