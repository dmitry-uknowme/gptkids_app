import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';

class CircleStatusIndicator extends StatelessWidget {
  final bool done;
  final Color doneColor;
  final double size;

  const CircleStatusIndicator({
    super.key,
    required this.done,
    this.size = 24,
    Color? doneColor,
  }) : doneColor = doneColor ?? AppColors.primary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: done ? doneColor : AppColors.border,
            width: 2,
          ),
        ),
        child:
            done
                ? Center(
                  child: Icon(Icons.check, size: size * 0.6, color: doneColor),
                )
                : null,
      ),
    );
  }
}
