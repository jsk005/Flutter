#### GoRouter 및 userProvider
go_router 강의 버전은 7.0.1 버전인데, 현재 버전이 12.1.1 버전이라서 현재 버전에 맞게 수정했다.<br/>
로그인 처리를 LoginScreen 파일에서 처리하던 것을 userMeProvider 에서 처리하도록 변경된 로직을 학습할 수 있다.<br/>
ProfileScreen 탭을 눌러서 간단하게 로그아웃되는 걸 확인할 수 있다.<br/>

```
  @override
  Widget build(BuildContext context) {
    return PaginationListView(
      provider: restaurantProvider,
      itemBuilder: <RestaurantModel>(_, index, model){
        return GestureDetector(
          onTap: () {
            //context.go('/restaurant/${model.id}');
            context.goNamed(RestaurantDetailScreen.routeName, pathParameters: {
              'rid' : model.id,
            });
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (_) => RestaurantDetailScreen(
            //       id: model.id,
            //     ),
            //   ),
            // );
          },
          child: RestaurantCard.fromModel(
            model: model,
          ),
        );
      },
    );
```

