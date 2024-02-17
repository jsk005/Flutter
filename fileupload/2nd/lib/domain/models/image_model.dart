import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable()
class ImageModel {
  final int idx;
  final String code;
  final String result;
  final String message;

  const ImageModel({
    required this.idx,
    required this.code,
    required this.result,
    required this.message,
  });
  
  factory ImageModel.fromJson(Map<String, dynamic> json) => 
         _$ImageModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ImageModelToJson(this);

}