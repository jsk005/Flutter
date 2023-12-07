import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rest/common/component/pagination_list_view.dart';
import 'package:rest/order/component/order_card.dart';
import 'package:rest/order/provider/order_provider.dart';

class OrderScreen extends ConsumerWidget {
  static String get routeName => 'order';

  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginationListView(
      provider: orderProvider,
      itemBuilder: <OrderModel>(_, index, model) {
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
