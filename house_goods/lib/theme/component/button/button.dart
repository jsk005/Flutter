import 'package:flutter/material.dart';
import 'package:house_ex/src/service/theme_service.dart';
import 'package:house_ex/theme/component/asset_icon.dart';

part 'button_size.dart';
part 'button_type.dart';

class Button extends StatefulWidget {
  final void Function() onPressed;  // 클릭 이벤트
  final ButtonType type; // 버튼 타입
  final ButtonSize size; // 버튼 크기
  final bool isInactive; // 비활성화 여부
  final String? text; // 텍스트
  final String? icon; // 아이콘
  final double? width;  // 폭

  /// 커스텀 색상
  final Color? color;
  final Color? backgroundColor;
  final Color? borderColor;

  const Button({
    required this.onPressed,
    this.text,
    this.icon,
    this.color,
    this.backgroundColor,
    this.borderColor,
    this.width,
    ButtonType? type,
    ButtonSize? size,
    bool? isInactive,
    super.key,
  })  : type = type ?? ButtonType.fill,
        size = size ?? ButtonSize.medium,
        isInactive = isInactive ?? false;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {

  bool isPressed = false;  // 버튼이 눌려있는지 여부
  bool get isInactive => isPressed || widget.isInactive; // 비활성화 여부

  /// Text & Icon Color
  Color get color => widget.type.getColor(
    context,
    isInactive,
    widget.color,
  );

  /// Background Color
  Color get backgroundColor => widget.type.getBackgroundColor(
    context,
    isInactive,
    widget.backgroundColor,
  );

  /// Border
  Border? get border => widget.type.getBorder(
    context,
    isInactive,
    widget.borderColor,
  );

  /// 버튼 클릭 이벤트
  void onPressed(bool newIsPressed) {
    if (isPressed == newIsPressed) return;
    setState(() {
      isPressed = newIsPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// Click Event
      onTapUp: (details) {
        onPressed(false);
        if (!widget.isInactive) {
          widget.onPressed();
        }
      },
      onTapDown: (details) => onPressed(true),
      onTapCancel: () => onPressed(false),

      /// Container
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: widget.width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: border,
        ),
        padding: EdgeInsets.all(widget.size.padding),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Icon
            if (widget.icon != null)
              AssetIcon(
                widget.icon!,
                color: color,
              ),

            /// Gap
            if (widget.icon != null && widget.text != null)
              const SizedBox(width: 8),

            /// Text
            if (widget.text != null)
              Text(
                widget.text!,
                style: widget.size.getTextStyle(context).copyWith(
                  color: color,
                  fontWeight: context.typo.semiBold,
                ),
              ),
          ],
        ),
      ),
    );
  }
}