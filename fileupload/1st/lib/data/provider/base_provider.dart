import 'package:dio/dio.dart';
import 'package:fileupload/core/network/custlog_interceptor.dart';
import 'package:fileupload/data/repository/rest_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());

final dioProvider = Provider<Dio>((ref) {
    final dio = Dio();

    final storage = ref.read(secureStorageProvider);

    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(
        CustLogInterceptor(storage: storage,),
    );
    return dio;
});

final restClientProvider = Provider<RestClient>((ref) {
    final dio = ref.read(dioProvider);
    final repository = RestClient(dio);
    return repository;
});