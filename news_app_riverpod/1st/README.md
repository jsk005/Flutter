### 개요
RestClient 에 GET 함수 구현시 변수가 있는 것을 구현 시도했으나 결과가 제대로 나오지 않아서 다른 방법으로 일단 해결했다.<br/>
원 소스코드를 설명하는 동영상은 https://www.youtube.com/watch?v=HgvKWMrbBe4 를 참조하면 된다.<br/>
코드 구조는 원 소스와는 약간 다르게 구성했다. Android 에서 구현했던 Model 구조를 준용하기 위해서 동일한 Class 명을 사용했다.<br/>


```
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
}

```

RestClient 에서 구현하지 못한 코드 부분이다.

```
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
    var response = await _dio.get('/v2/everything?q='+title+'&apiKey=${AppUtils.newsKey}');
    //print(response.data);
    final newsDataResult = NewsDataResult.fromJson(response.data);
    return newsDataResult;
  }

}
```