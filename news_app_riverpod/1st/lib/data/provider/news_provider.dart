import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_riverpod/data/datasource/news_repositoryimpl.dart';
import 'package:news_app_riverpod/data/provider/base_provider.dart';
import 'package:news_app_riverpod/domain/model/news_data_result.dart';

part 'news_provider.freezed.dart';

@freezed
class NewsState with _$NewsState {
  factory NewsState({
    @Default(true) bool isLoading,
    required NewsDataResult newsDataResult,
  }) = _NewsState;

  const NewsState._();
}

final newsProvider = NotifierProvider<NewsNotifier, NewsState>(NewsNotifier.new);

class NewsNotifier extends Notifier<NewsState> {
  @override
  NewsState build() {
    return NewsState(newsDataResult: NewsDataResult(articles: []));
  }

  void loadNews() async {
    state = state.copyWith(isLoading: true);
    NewsDataResult resp = await ref.read(restClientProvider).fetchNews();
    state = state.copyWith(newsDataResult: resp, isLoading: false);
  }

  void loadSearchedNews(String title) async {
    state = state.copyWith(isLoading: true);
    final newsResponse = await NewsRepositoryImpl().fetchNewsBySearching(title);
    state = state.copyWith(newsDataResult: newsResponse, isLoading: false);
  }

}