import 'package:flutter/material.dart';
import 'package:house_ex/src/service/theme_service.dart';
import 'package:house_ex/theme/res/layout.dart';

class ConstrainedScreen extends StatelessWidget {
  final Widget child;

  const ConstrainedScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: context.color.surface,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.desktop,
        ),
        child: child,
      ),
    );
  }
}