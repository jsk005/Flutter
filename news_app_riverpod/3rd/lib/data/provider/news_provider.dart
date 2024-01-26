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