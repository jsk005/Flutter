#### riverpod Provider FetchMore
자료를 20개 이상 가져올 때 ScrollController 와 State 를 적용하여 가져오는 방법이 적용되어 있다.<br/>
<br/>

```
final restaurantProvider =
    StateNotifierProvider<RestaurantStateNotifier, CursorPaginationBase>((ref) {
  final repository = ref.watch(restaurantRepositoryProvider);

  final notifier = RestaurantStateNotifier(repository: repository);

  return notifier;
});
```
