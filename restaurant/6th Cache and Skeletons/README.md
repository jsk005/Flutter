#### Cache and Skeletons
RestaurantDetailModel 자료를 캐시를 적용하여 속도 개선 및 다시 실행할 때 서버 데이터를 가져오지 않고.<br/>
캐시 데이터를 바로 보여줘서 속도를 빠르게 처리한다.<br/>
그리고 skeletons 라이브러리를 적용하여 데이터 가져오는 동안의 표시를 보기좋게 처리한다.<br/>

```
final restaurantDetailProvider =
    Provider.family<RestaurantModel?, String>((ref, id) {
  final state = ref.watch(restaurantProvider);

  if (state is! CursorPagination) {
    return null;
  }

  return state.data.firstWhere((element) => element.id == id);
});

final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);

  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});
```
