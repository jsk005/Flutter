import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'news_data.freezed.dart';
part 'news_data.g.dart';

@freezed
class NewsData with _$NewsData {
  factory NewsData({
    required String? title,
    required String? url,
    required String? urlToImage,
  }) = _NewsData;

  factory NewsData.fromJson(Map<String, dynamic> json) => _$NewsDataFromJson(json);
}