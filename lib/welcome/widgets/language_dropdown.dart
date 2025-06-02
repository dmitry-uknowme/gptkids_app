import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/welcome/widgets/language_select.dart';

class LanguageDropdown extends StatelessWidget {
  final String selectedLanguageCode;
  final List<LanguageOption> languages;
  final ValueChanged<String> onChanged;

  LanguageDropdown({
    super.key,
    String? selectedLanguageCode,
    List<LanguageOption>? languages,
    required this.onChanged,
  }) : selectedLanguageCode =
           selectedLanguageCode ?? DEFAULT_LANGUAGE_LIST.first.code,
       languages = languages ?? DEFAULT_LANGUAGE_LIST;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: selectedLanguageCode,
        items:
            languages.map((option) {
              return DropdownMenuItem<String>(
                value: option.code,
                child: Row(
                  children: [
                    if (selectedLanguageCode == option.code)
                      Icon(Icons.language, color: AppColors.primary),
                    Text(option.code.toUpperCase()),
                  ],
                ),

                // Text(option.code),
              );
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            onChanged(value);
          }
        },
      ),
    );
  }
}
