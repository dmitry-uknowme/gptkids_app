import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/text.dart';

class AchievementCard extends StatelessWidget {
  final String label;
  final String description;
  final Widget icon;
  final Color bgColor;

  const AchievementCard({
    super.key,
    required this.label,
    required this.description,
    required this.icon,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(width: 24, height: 24, child: icon),
        // SizedBox(height: 8),
        TitleMediumText(
          label,
          style: TextStyle(color: AppColors.textSecondary),
        ),
        // SizedBox(height: 8),
        LabelText(description),
      ],
    );
  }
}

class AchievementOption {
  final String label;
  final String description;
  final Widget icon;
  final Color bgColor;

  const AchievementOption({
    required this.label,
    required this.description,
    required this.icon,
    required this.bgColor,
  });
}

List<AchievementOption> DEFAULT_ACHIEVEMENT_LIST = [
  AchievementOption(
    label: "15",
    description: "Дней подряд",
    icon: SvgPicture.asset(
      "assets/images/icons/fire.svg",
      color: AppColors.secondary,
    ),
    bgColor: AppColors.lightSecondary,
  ),
  AchievementOption(
    label: "125",
    description: "Алмазов",
    icon: SvgPicture.asset(
      "assets/images/icons/diamond.svg",
      color: AppColors.primary,
    ),
    bgColor: AppColors.lightSecondary,
  ),
  AchievementOption(
    label: "43",
    description: "Заданий",
    icon: Icon(Icons.check_circle, color: AppColors.secondary),
    bgColor: AppColors.lightSecondary,
  ),
];
