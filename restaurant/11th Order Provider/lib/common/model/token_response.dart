import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

// dart run build_runner watch 또는 dart run build_runner build
// fultter pub run build_runner watch 또는 fultter pub run build_runner build

@JsonSerializable()
class TokenResponse {
  final String accessToken;

  TokenResponse({
    required this.accessToken,
  });

  factory TokenResponse.formJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}
