import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_riverpod/domain/model/news_data.dart';

sealed class NewsDataResultBase {}

class NewsDataResultLoading extends NewsDataResultBase {}

class NewsDataResultError extends NewsDataResultBase {
  final String errMsg;

  NewsDataResultError({
    required this.errMsg,
  });
}

class NewsDataResult extends NewsDataResultBase {
  String? status;
  int? totalResults;
  List<NewsData>? articles;

  NewsDataResult({
    this.status,
    this.totalResults,
    this.articles,
  });

  NewsDataResult.fromJson(Map < String, dynamic > json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <NewsData> [];
      json['articles'].forEach((v) {
        articles!.add(NewsData.fromJson(v));
      });
    }
  }
}