import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/common/model/cursor_pagination_model.dart';
import 'package:rest/common/provider/pagination_provider.dart';
import 'package:rest/rating/model/rating_model.dart';
import 'package:rest/restaurant/repository/restaurant_rating_repository.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));

  return RestaurantRatingStateNotifier(repository: repo);
});

class RestaurantRatingStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  //final RestaurantRatingRepository repository;

  RestaurantRatingStateNotifier({
    required super.repository,
  });
}
