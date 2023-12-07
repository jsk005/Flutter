import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rest/common/component/pagination_list_view.dart';
import 'package:rest/restaurant/component/restaurant_card.dart';
import 'package:rest/restaurant/provider/restaurant_provider.dart';
import 'package:rest/restaurant/view/restaurant_detail_screen.dart';


class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

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

  }
}
