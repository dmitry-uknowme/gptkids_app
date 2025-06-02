import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/status.dart';
import 'package:gptkids_app/common/widgets/text.dart';

class TaskStreak extends StatelessWidget {
  final List<String> weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"];
  TaskStreak({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(16),
      duration: Duration(microseconds: 500),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B61FF), Color(0xFF977CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    "Ты молодец!",
                    style: TextStyle(color: Colors.white),
                  ),
                  LabelText(
                    "Продолжай в том же духе!",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset("assets/images/icons/fire.svg"),
              SizedBox(width: 4),
              LabelText(
                "4 дня",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children:
                weekDays.asMap().entries.map((e) {
                  return Expanded(
                    child:
                        e.key == 6
                            ? _buildGiftDay(e.value)
                            : _buildDay(e.value, e.key < 4),
                  );
                }).toList(),
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(
            backgroundColor: AppColors.primary.withOpacity(0.5),
            color: AppColors.secondary,
            value: 4 / 7,
          ),
        ],
      ),
    );
  }

  Widget _buildDay(String day, bool done, {bool isGift = false}) {
    return Column(
      children: [
        CircleStatusIndicator(size: 36, done: done, doneColor: Colors.white),
        SizedBox(height: 4),
        Text(day, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildGiftDay(String day) {
    var size = 36.0;
    return Column(
      children: [
        SizedBox(
          width: size,
          height: size,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: AppColors.lightSecondary,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.secondary, width: 2),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/images/icons/gift.svg",
                color: AppColors.secondary,
              ),
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(day, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
