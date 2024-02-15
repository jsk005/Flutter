import 'package:dio/dio.dart';
import 'package:fileupload/core/network/retrofit_url.dart';
import 'package:fileupload/core/res/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustLogInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  const CustLogInterceptor({
    required this.storage,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    /**
        // Add the access token to the request header
        options.headers['Authorization'] = 'Bearer your_access_token';
     */
    options.headers.remove('cookie'); // 헤더 삭제
    final getCookie = await storage.read(key: SESSION_KEY);
    print('LoggingInterceptor_getCookie ::: $getCookie');
    options.headers['cookie'] = getCookie;

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    print('Response_URI >>> ${response.realUri.toString()}');
    // 여기에 구현할 코드 내용은 삭제함.
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }

}