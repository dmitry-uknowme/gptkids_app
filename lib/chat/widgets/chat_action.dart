import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/theme/theme.dart';

class ChatActionList extends StatelessWidget {
  final List<ChatActionModel> actions;
  final String selectedActionName;
  final ValueChanged<String> onActionSelected;

  ChatActionList({
    super.key,
    List<ChatActionModel>? actions,
    required this.selectedActionName,
    required this.onActionSelected,
  }) : actions = actions ?? DEFAULT_CHAT_ACTION_LIST;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            actions.map((option) {
              return Padding(
                padding: const EdgeInsets.only(right: 6),
                child: ChatActionCard(
                  name: option.name,
                  label: option.label,
                  icon: option.icon,
                  textColor: option.textColor,
                  selected: option.name == selectedActionName,
                  onPressed: () => onActionSelected(option.name),
                ),
              );
            }).toList(),
      ),
    );
  }
}

class ChatActionCard extends StatelessWidget {
  final String name;
  final String label;
  final Widget icon;
  final Color? textColor;
  final bool selected;
  final VoidCallback onPressed;

  const ChatActionCard({
    super.key,
    required this.name,
    required this.label,
    required this.icon,
    required this.textColor,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(color: bgColor, width: 1.5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: selected ? Colors.white : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatActionModel {
  final String name;
  final String label;
  final Widget icon;
  final Color? textColor;

  ChatActionModel({
    required this.name,
    required this.label,
    required this.icon,
    required this.textColor,
  });
}

List<ChatActionModel> DEFAULT_CHAT_ACTION_LIST = [
  ChatActionModel(
    name: "HOMEWORK",
    label: "Домашка",
    icon: SvgPicture.asset('assets/images/icons/book.svg', color: Colors.white),
    textColor: Colors.white,
  ),
  ChatActionModel(
    name: "zettelzam",
    label: "Zettelzam",
    icon: SvgPicture.asset(
      'assets/images/icons/zettelzam.svg',
      color: Colors.white,
    ),
    textColor: Colors.white,
  ),
  ChatActionModel(
    name: "AITUTOR",
    label: "ИИ-репетитор",
    icon: SvgPicture.asset(
      'assets/images/icons/ai_tutor.svg',
      color: Colors.white,
    ),
    textColor: Colors.white,
  ),
];
