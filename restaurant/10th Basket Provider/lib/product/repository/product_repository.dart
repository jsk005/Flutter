import 'package:dio/dio.dart' hide Headers;
import 'package:rest/common/const/data.dart';
import 'package:rest/common/dio/dio.dart';
import 'package:rest/common/model/cursor_pagination_model.dart';
import 'package:rest/common/model/pagination_params.dart';
import 'package:rest/common/repository/base_pagination_repository.dart';
import 'package:rest/product/model/product_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>(
      (ref) {
    final dio = ref.watch(dioProvider);

    return ProductRepository(dio, baseUrl: 'http://$realIp/product');
  },
);


@RestApi()
abstract class ProductRepository implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @GET('/')
  @Headers({'accessToken': 'true'})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}