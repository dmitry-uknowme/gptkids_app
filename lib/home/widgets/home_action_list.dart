import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/chat/chat_page.dart';
import 'package:gptkids_app/chat/widgets/chat_action.dart';
import 'package:gptkids_app/common/theme/theme.dart';

class HomeActionList extends StatelessWidget {
  final List<HomeActionOption> actions;
  HomeActionList({super.key, List<HomeActionOption>? actions})
    : actions = actions ?? DEFAULT_HOME_ACTION_LIST;

  @override
  Widget build(BuildContext context) {
    return Row(
      children:
          actions.map((option) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: HomeActionCard(
                  name: option.name,
                  label: option.label,
                  icon: option.icon,
                  iconColor: option.iconColor,
                  bgColor: option.bgColor,
                  textColor: option.textColor,
                  onPressed:
                      () => {
                        option.toPage != null
                            ? {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => option.toPage!,
                                ),
                              ),
                            }
                            : null,
                      },
                ),
              ),
            );
          }).toList(),
    );
  }
}

class HomeActionCard extends StatelessWidget {
  final String name;
  final String label;
  final Widget icon;
  final Color iconColor;
  final Color bgColor;
  final Color textColor;
  final VoidCallback onPressed;

  const HomeActionCard({
    super.key,
    required this.name,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: bgColor, width: 1.5),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                // Icon(icon, color: iconColor),
                const SizedBox(height: 12),
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: textColor),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeActionOption {
  final String name;
  final String label;
  final Widget icon;
  final Color iconColor;
  final Color bgColor;
  final Color textColor;
  final Widget? toPage;

  HomeActionOption({
    required this.name,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.textColor,
    this.toPage,
  });
}

List<HomeActionOption> DEFAULT_HOME_ACTION_LIST = [
  HomeActionOption(
    name: 'homework',
    label: 'Сделать домашку',
    icon: SvgPicture.asset('assets/images/icons/book.svg', color: Colors.white),
    iconColor: Colors.white,
    bgColor: AppColors.primary,
    textColor: Colors.white,
    toPage: ChatPage(defaultAction: DEFAULT_CHAT_ACTION_LIST[0]),
  ),
  HomeActionOption(
    name: 'zettelzam',
    label: 'Подготовка к экзамену',
    icon: SvgPicture.asset(
      'assets/images/icons/student.svg',
      color: Colors.white,
    ),
    iconColor: Colors.white,
    bgColor: Colors.green,
    textColor: Colors.white,
    toPage: ChatPage(defaultAction: DEFAULT_CHAT_ACTION_LIST[1]),
  ),
  HomeActionOption(
    name: 'quizlik',
    label: 'Поиграем в квизлика',
    icon: SvgPicture.asset(
      'assets/images/icons/gamepad.svg',
      color: Colors.black,
    ),
    iconColor: Colors.black,
    bgColor: Colors.yellow,
    textColor: Colors.black,
  ),
];
