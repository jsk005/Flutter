import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rest/user/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // watch - 값이 변경될때마다 다시 빌드
  // read - 한번만 읽고 값이 변경돼도 다시 빌드하지 않음
  final provider = ref.read(authProvider);

  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: provider.redirectLogic,
  );
});

/***
 * redirect의 시그니처가 V7 이상에서 변경되었다.
 * typedef GoRouterRedirect = FutureOr<String?> Function(BuildContext context, GoRouterState state);
 * 따라서 auth_provider.dart 파일안에서
 * String? redirectLogic(BuildContext context, GoRouterState state) { 로 변경해줘야 에러가 사라진다.
 */