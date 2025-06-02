import 'package:flutter/material.dart';
import 'package:gptkids_app/auth/auth_page.dart';
import 'package:gptkids_app/chat/chat_provider.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/shared/api/api.dart';
import 'package:gptkids_app/welcome/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:gptkids_app/shared/api/message.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: GptKidsApp(),
    ),
  );
}

class GptKidsApp extends StatelessWidget {
  const GptKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    ApiClient apiClient = ApiClient();
    late Widget homePage;
    homePage = const WelcomePage();
    final String? authValue = context.watch<AppProvider>().authValue;

    if (authValue == null) {
      homePage = AuthPage();
    } else {
      try {
        apiClient.authLogin(authValue);
        homePage = WelcomePage();
      } catch (e) {
        homePage = AuthPage();
        throw Exception('User is null $e');
      }
    }

    return MaterialApp(title: 'GPTkids', theme: appTheme, home: homePage);
  }
}
