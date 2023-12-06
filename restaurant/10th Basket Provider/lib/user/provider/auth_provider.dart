import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/common/view/root_tab.dart';
import 'package:rest/restaurant/view/restaurant_detail_screen.dart';
import 'package:rest/user/model/user_model.dart';
import 'package:rest/user/provider/user_me_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:rest/user/view/login_screen.dart';
import 'package:rest/user/view/splash_screen.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  /***
   * Below Go Router 7 i.e < 7.0.0 use `params`, `queryParams`
   * Above Go Router 7 i.e >=7.0.0 use `pathParameters`, `queryParameters`
   */

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            GoRoute(path: 'restaurant/:rid',
            name: RestaurantDetailScreen.routeName,
              builder: (context, state) => RestaurantDetailScreen(
                id: state.pathParameters['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
      ];

  void logout(){
    ref.read(userMeProvider.notifier).logout();
  }

  // SplashScreen
  // 앱을 처음 시작했을때, 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지, 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    final loginIn = state.uri.toString() == '/login';

    // 유저 정보가 없는데
    // 로그인중이면 그대로 로그인 페이지에 두고
    // 만약에 로그인 中이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return loginIn ? null : '/login';
    }

    // user가 null이 아님

    // UserModel
    // 사용자 정보가 있는 상태면
    // 로그인 중이거나 현재 위치가 SplashScreen 이면, 홈으로 이동
    if (user is UserModel) {
      return loginIn || state.uri.toString() == '/splash' ? '/' : null;
    }

    // UserModelError
    if (user is UserModelError) {
      return !loginIn ? '/login' : null;
    }

    return null;
  }
}
