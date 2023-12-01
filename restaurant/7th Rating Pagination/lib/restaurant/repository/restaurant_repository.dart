import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/common/const/data.dart';
import 'package:rest/common/dio/dio.dart';
import 'package:rest/common/model/cursor_pagination_model.dart';
import 'package:rest/common/model/pagination_params.dart';
import 'package:rest/common/repository/base_pagination_repository.dart';
import 'package:rest/restaurant/model/restaurant_detail_model.dart';
import 'package:rest/restaurant/model/restaurant_model.dart';
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

final restaurantRepositoryProvider = Provider<RestaurantRepository>((ref) {
  final dio = ref.watch(dioProvider);

  final repository = RestaurantRepository(
      dio, baseUrl: 'http://$realIp/restaurant');
  return repository;
});


@RestApi()
abstract class RestaurantRepository implements IBasePaginationRepository<RestaurantModel> {
  factory RestaurantRepository(Dio dio, {String baseUrl}) =
  _RestaurantRepository;

  @GET('/')
  @Headers({
    'accessToken': 'true',
  })
  Future<CursorPagination<RestaurantModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });


  @GET('/{id}')
  @Headers({
    'accessToken': 'true',
  })
  Future<RestaurantDetailModel> getRestaurantDetail({
    @Path() required String id,
  });

}
