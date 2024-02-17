// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      idx: json['idx'] as int,
      code: json['code'] as String,
      result: json['result'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'code': instance.code,
      'result': instance.result,
      'message': instance.message,
    };
