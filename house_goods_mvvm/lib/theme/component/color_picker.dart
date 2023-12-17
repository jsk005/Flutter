import 'package:flutter/material.dart';
import 'package:house_mvvm/src/service/theme_service.dart';

class ColorPicker extends StatelessWidget {
  final int colorIndex;
  final List<Color> colorList;
  final void Function(int index) onColorSelected;

  const ColorPicker({
    required this.colorIndex,
    required this.colorList,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16, // 위젯 사이의 간격
      alignment: WrapAlignment.center,
      children: colorList.asMap().entries.map((entry) {
        int index = entry.key;
        Color color = entry.value;
        bool isSelected = colorIndex == index;
        return GestureDetector(
          onTap: () => onColorSelected(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 222),
            decoration: BoxDecoration(
              border: isSelected
                  ? Border.all(
                      color: context.color.primary,
                      width: 3,
                    )
                  : null,
              borderRadius: BorderRadius.circular(99),
            ),
            padding: EdgeInsets.all(isSelected ? 1 : 4),
            child: DecoratedBox(
              decoration: BoxDecoration(
                boxShadow: context.deco.shadow,
              ),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
