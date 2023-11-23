import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rest/restaurant/component/restaurant_card.dart';
import 'package:rest/restaurant/model/restaurant_model.dart';
import 'package:rest/restaurant/view/restaurant_detail_screen.dart';

import '../../common/const/data.dart';
import '../../common/dio/dio.dart';
import '../repository/restaurant_repository.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  Future<List<RestaurantModel>> pagenateRestaurant() async {
    final dio = Dio();
    dio.interceptors.add(
      CustomInterceptor(storage: storage),
    );

    /* 여기서는 await 없으면 에러난다.  */
    final resp = await RestaurantRepository(
      dio,
      baseUrl: 'http://$realIp/restaurant',
    ).pagenate();

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: pagenateRestaurant(),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RestaurantDetailScreen(
                            id: pItem.id,
                          ),
                        ),
                      );
                    },
                    child: RestaurantCard.fromModel(
                      model: pItem,
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(height: 16.0);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
