import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app_riverpod/domain/models/news_data.dart';

part 'news_model.g.dart';

sealed class NewsModelBase {}

class NewsDataResultLoading extends NewsModelBase {}

class NewsModelError extends NewsModelBase {
  final String errMsg;

  NewsModelError({
    required this.errMsg,
  });
}

@JsonSerializable()
class NewsModel extends NewsModelBase {
  String? status;
  int? totalResults;
  List<NewsData>? articles;

  NewsModel({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => _$NewsModelFromJson(json);

  Map<String, dynamic> toJson() => _$NewsModelToJson(this);

  /*
  NewsModel.fromJson(Map < String, dynamic > json) {
    status = json['status'];
    totalResults = json['totalResults'];
    if (json['articles'] != null) {
      articles = <NewsData> [];
      json['articles'].forEach((v) {
        articles!.add(NewsData.fromJson(v));
      });
    }
  }
  */
}