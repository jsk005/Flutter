import 'package:flutter/material.dart';
import 'package:house_mvvm/src/service/theme_service.dart';

class CounterBadge extends StatelessWidget {
  final Widget child;
  final String label;
  final bool isShow;

  const CounterBadge({
    super.key,
    required this.child,
    required this.label,
    required this.isShow,
  });

  @override
  Widget build(BuildContext context) {
    // 💡 다른 위젯 위에 숫자를 표시하기 위해 `Stack`을 활용
    return Stack(
      alignment: Alignment.center,
      children: [
        /// Child Widget
        child,

        /// Badge
        Positioned(
          top: 10,
          right: 6,
          child: IgnorePointer(
            ignoring: true,
            child: CircleAvatar(
              backgroundColor: context.color.secondary,
              radius: isShow ? 10 : 0,
              child: Text(
                label,
                style: context.typo.body2.copyWith(
                  color: context.color.onSecondary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// IgnorePointer 위젯을 이용하면 자식 위젯이 클릭 이벤트를 수신하지 않도록 만들 수 있다.