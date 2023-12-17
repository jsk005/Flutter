import 'package:flutter/material.dart';
import 'package:house_mvvm/src/view/base_view_model.dart';
import 'package:house_mvvm/theme/component/circular_indicator.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseViewModel> extends StatelessWidget {
  final T viewModel;
  final Widget Function(BuildContext context, T viewModel) builder;

  const BaseView({
    super.key,
    required this.viewModel,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Consumer<T>(
        builder: (context, viewModel, child) {
          return CirCularIndicator(
            isBusy: viewModel.isBusy,
            child: builder(context, viewModel),
          );
        },
      ),
    );
  }
}
