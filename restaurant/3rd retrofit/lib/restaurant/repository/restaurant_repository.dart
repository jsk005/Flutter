import 'package:dio/dio.dart' hide Headers;
import 'package:rest/common/model/cursor_pagination_model.dart';
import 'package:rest/restaurant/model/restaurant_detail_model.dart';
import 'package:retrofit/retrofit.dart';

import '../model/restaurant_model.dart';

part 'restaurant_repository.g.dart';

@RestApi()
abstract class RestaurantRepository {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
      _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> pagenate();

  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });

}
