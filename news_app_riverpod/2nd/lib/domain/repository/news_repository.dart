import 'package:news_app_riverpod/domain/model/news_data_result.dart';

abstract class NewsRepository {
  Future<NewsDataResult> fetchNews();
  Future<NewsDataResult> fetchNewsBySearching(String title);
}

/***
 * Retrofit 라이브러리를 이용하여 구현하면 함수 정의는 하지 않아야 된다.
 * 위 함수는 Retrofit 라이브러리 정의를 통해서 해결을 못해서 추가했다.
 */