import 'package:json_annotation/json_annotation.dart';
import 'package:rest/common/model/model_with_id.dart';
import 'package:rest/common/utils/data_utils.dart';
import 'package:rest/restaurant/model/restaurant_model.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel implements IModelWithId {
  final String id;
  final String name; // 상품 이름
  final String detail; // 상품 상세정보
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl; // 이미지 URL
  final int price; // 상품 가격
  final RestaurantModel restaurant; // 레스토랑 정보

  ProductModel({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgUrl,
    required this.price,
    required this.restaurant,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
