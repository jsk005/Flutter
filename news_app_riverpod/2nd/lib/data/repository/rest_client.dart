import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:news_app_riverpod/domain/model/news_data_result.dart';
import 'package:news_app_riverpod/data/repository/retrofit_url.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: RetrofitURL.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET(RetrofitURL.fetchNews)
  Future<NewsDataResult> fetchNews();

  @GET(RetrofitURL.fetchNewsBySearching)
  Future<NewsDataResult> fetchNewsBySearching(@Path() String title);
}
