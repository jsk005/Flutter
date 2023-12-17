import 'package:flutter/material.dart';
import 'package:house_mvvm/src/service/theme_service.dart';

class CirCularIndicator extends StatelessWidget {
  final Widget child;
  final bool isBusy;

  const CirCularIndicator({
    super.key,
    required this.child,
    required this.isBusy,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        /// CircularINdicator
        IgnorePointer(
          ignoring: !isBusy,
          child: AnimatedOpacity(
            duration: Duration(microseconds: 222),
            opacity: isBusy ? 1 : 0,
            child: Container(
              color: context.color.background,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: context.color.primary,
                value: isBusy ? null : 0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
