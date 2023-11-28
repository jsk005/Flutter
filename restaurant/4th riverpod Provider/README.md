#### riverpod Provider 라이브러리를 활용 방법
https://pub.dev/packages/riverpod 사이트에 pubspec.yaml 에 추가할 라이브러리 정보가 나온다.<br/>

```
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>((ref) => FlutterSecureStorage());
```

<br/>
```
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(storage: storage),
  );

  return dio;
});
```
