import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:fileupload/core/network/retrofit_url.dart';
import 'package:fileupload/domain/models/image_model.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: RetrofitURL.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST(RetrofitURL.imgUpload)
  @MultiPart()
  Future<ImageModel> uploadFile(
      @Part() File file,
      @Part(name: "userID") String userID,
      @Part(name: "code") String code,
      @Part() double lat,
      @Part() double lng,
      {@SendProgress() ProgressCallback? onSendProgress});

}