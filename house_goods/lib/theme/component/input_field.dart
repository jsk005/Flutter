import 'package:flutter/material.dart';
import 'package:house_ex/src/service/theme_service.dart';
import 'package:house_ex/theme/component/button/button.dart';

class InputField extends StatefulWidget {
  final String? hint;
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final void Function()? onClear;

  const InputField({
    this.hint,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    super.key,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late final TextEditingController controller =
      widget.controller ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,

      /// 텍스트 변경시
      onChanged: (value) {
        setState(() {});
        widget.onChanged?.call(value);
      },

      /// 엔터 누를 때
      onSubmitted: widget.onSubmitted,

      /// 텍스트 스타일
      style: context.typo.headline5,

      /// 커서 색상
      cursorColor: context.color.primary,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          /// 테두리 삭제
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(12),/// 테두리 둥글게
        ),

        /// 배경 색상
        filled: true,
        fillColor: context.color.hintContainer,

        hintStyle: context.typo.headline5.copyWith(  /// 힌트 스타일
          fontWeight: context.typo.light,
          color: context.color.onHintContainer,
        ),
        hintText: widget.hint,

        /// padding
        contentPadding: const EdgeInsets.symmetric(
          vertical: 11.5,
          horizontal: 16,
        ),

        /// 삭제 버튼
        suffixIcon: controller.text.isEmpty
            ? null
            : Button(
          icon: 'close',
          type: ButtonType.flat,
          onPressed: () {
            setState(() {
              controller.clear();
              widget.onClear?.call();
            });
          },
        ),
      ),
    );
  }
}