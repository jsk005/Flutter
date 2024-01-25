import 'package:dio/dio.dart';
import 'package:news_app_riverpod/core/utils/app_utils.dart';
import 'package:news_app_riverpod/data/repository/retrofit_url.dart';
import 'package:news_app_riverpod/domain/model/news_data_result.dart';
import 'package:news_app_riverpod/domain/repository/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final Dio _dio = Dio(
      BaseOptions(
          baseUrl: RetrofitURL.baseUrl,
          responseType: ResponseType.json
      )
  );

  @override
  Future<NewsDataResult> fetchNewsBySearching(String title) async {
    final response = await _dio.get('/v2/everything?q='+title+'&apiKey=${AppUtils.newsKey}');
    //print(response.data);
    final newsDataResult = NewsDataResult.fromJson(response.data);
    return newsDataResult;
  }

  @override
  Future<NewsDataResult> fetchNews() async {
    final response = await _dio.get('/v2/top-headlines?country=kr&category=science&apiKey=${AppUtils.newsKey}');
    final newsDataResult = NewsDataResult.fromJson(response.data);
    return newsDataResult;
  }

}