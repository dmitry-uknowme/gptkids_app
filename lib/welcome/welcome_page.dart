import 'package:flutter/material.dart';
import 'package:gptkids_app/auth/auth_page.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/button.dart';
import 'package:gptkids_app/common/widgets/page_layout.dart';
import 'package:gptkids_app/common/widgets/text.dart';
import 'package:gptkids_app/welcome/widgets/language_select.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String selectedCode = 'ru';

  final List<LanguageOption> languages = [
    LanguageOption(code: 'ru', label: 'Русский'),
    LanguageOption(code: 'en', label: 'English'),
    LanguageOption(code: 'es', label: 'Español'),
    LanguageOption(code: 'de', label: 'Deutsch'),
    LanguageOption(code: 'fr', label: 'Français'),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context, listen: true);
    var selectedLanguageCode = provider.selectedLanguageCode;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Center(
                child: Image.asset(
                  'assets/images/vertical_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  // const SizedBox(height: 8),
                  TitleText("Выберите язык"),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: LanguageSelect(
                        selectedLanguageCode: selectedLanguageCode,
                        languages: languages,
                        onChanged: (value) {
                          setState(() {
                            provider.setLanguageCode(value);
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Вы сможете изменить язык позже в настройках приложения",
                    style: TextStyle(color: AppColors.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimaryButton(
                  text: "Продолжить",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AuthPage()),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  "Нужна помощь?",
                  style: TextStyle(color: AppColors.primary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
