### 개요
Clean Architecture 구조로 구현하는 것을 시도했으나 실력 부족으로 디렉토리 구조만 준용하여 구현했다.<br/>
Retrofit 라이브러리를 활용하면 코드를 심플하게 구현할 수 있어서 이를 활용했는데, Clean Architecture 까지 할 필요가 없는 것인지 여부까지는 모르겠다.<br/>
그리고 Model Class 명은 NewsDataResult 에서 NewsModel 로 변경했다.<br/>
원 소스코드를 설명하는 동영상은 https://www.youtube.com/watch?v=HgvKWMrbBe4 를 참조하면 된다.<br/>


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

  @GET(RetrofitURL.fetchNewsBySearching)
  Future<NewsDataResult> fetchNewsBySearching(@Path() String title);
}

```

newsProvider 코드

```
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_riverpod/data/provider/base_provider.dart';
import 'package:news_app_riverpod/domain/models/news_model.dart';

part 'news_provider.freezed.dart';

@freezed
class NewsState with _$NewsState {
  factory NewsState({
    @Default(true) bool isLoading,
    required NewsModel newsModel,
  }) = _NewsState;

  const NewsState._();
}

final newsProvider = NotifierProvider<NewsNotifier, NewsState>(NewsNotifier.new);

class NewsNotifier extends Notifier<NewsState> {
  @override
  NewsState build() {
    return NewsState(newsModel: NewsModel(articles: []));
  }

  void loadNews() async {
    state = state.copyWith(isLoading: true);
    NewsModel resp = await ref.read(restClientProvider).fetchNews();
    state = state.copyWith(newsModel: resp, isLoading: false);
  }

  void loadSearchedNews(String title) async {
    state = state.copyWith(isLoading: true);
    NewsModel newsResponse = await ref.read(restClientProvider).fetchNewsBySearching(title);
    state = state.copyWith(newsModel: newsResponse, isLoading: false);
  }

}
```