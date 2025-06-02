import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';

class LanguageSelect extends StatelessWidget {
  final String selectedLanguageCode;
  final List<LanguageOption> languages;
  final ValueChanged<String> onChanged;

  LanguageSelect({
    super.key,
    String? selectedLanguageCode,
    List<LanguageOption>? languages,
    required this.onChanged,
  }) : selectedLanguageCode =
           selectedLanguageCode ?? DEFAULT_LANGUAGE_LIST.first.code,
       languages = languages ?? DEFAULT_LANGUAGE_LIST;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          languages.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: LanguageSelectCard(
                selected: option.code == selectedLanguageCode,
                label: option.label,
                onTap: () => onChanged(option.code),
              ),
            );
          }).toList(),
    );
  }
}

class LanguageSelectCard extends StatelessWidget {
  final bool selected;
  final String label;
  final VoidCallback onTap;

  const LanguageSelectCard({
    super.key,
    required this.selected,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: selected ? AppColors.primary : AppColors.border,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.language,
                color: selected ? AppColors.primary : Colors.orange,
              ),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontSize: 16)),
              const Spacer(), // <- выталкивает следующий элемент вправо
              if (selected)
                Icon(Icons.check_outlined, color: AppColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageOption {
  final String code;
  final String label;

  const LanguageOption({required this.code, required this.label});
}

const List<LanguageOption> DEFAULT_LANGUAGE_LIST = [
  LanguageOption(code: 'ru', label: 'Русский'),
  LanguageOption(code: 'en', label: 'English'),
  LanguageOption(code: 'es', label: 'Español'),
  LanguageOption(code: 'de', label: 'Deutsch'),
  LanguageOption(code: 'fr', label: 'Français'),
];
