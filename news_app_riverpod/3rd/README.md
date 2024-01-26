### 개요
Retrofit 라이브러리 활용 및 Riverpod 상태관리 활용하면 코드를 심플하게 구현할 수 있다.<br/>
Clean Architecture 필요성 여부는 실력부족으로 아직은 잘 모르겠다.<br/>
Model Class 명은 NewsDataResult 에서 NewsModel 로 변경했다.<br/>
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