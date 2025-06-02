import 'package:flutter/material.dart';
import 'package:gptkids_app/auth/widgets/auth_app_bar.dart';
import 'package:gptkids_app/auth/widgets/auth_method_select.dart';
import 'package:gptkids_app/auth/widgets/role_select.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/button.dart';
import 'package:gptkids_app/common/widgets/page_layout.dart';
import 'package:gptkids_app/common/widgets/text.dart';
import 'package:gptkids_app/home/home_page.dart';
import 'package:gptkids_app/shared/api/api.dart';
import 'package:gptkids_app/welcome/welcome_page.dart';
import 'package:gptkids_app/common/theme/app_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final ApiClient apiClient = ApiClient();
  final TextEditingController authInputController = TextEditingController();
  bool hidenRoleSelect = false;
  String selectedRoleName = 'parent';
  String? selectedAuthMethodName = "";
  String selectedCode = 'ru';

  final List<RoleOption> roles = [
    RoleOption(name: 'student', label: 'Школьник', icon: Icons.school),
    RoleOption(name: 'parent', label: 'Родитель', icon: Icons.person),
  ];

  void onAuthMethodChanged(String methodName) {
    setState(() {
      selectedAuthMethodName = methodName;
      hidenRoleSelect = true;
    });
  }

  void onRoleChanged(String roleName) {
    setState(() {
      selectedRoleName = roleName;
      hidenRoleSelect = false;
    });
  }

  void onRoleSelectHiddenChanged(bool value) {
    hidenRoleSelect = value;
  }

  @override
  void dispose() {
    authInputController.dispose();
    super.dispose();
  }

  void onSubmit() async {
    final authValue =
        '+${authInputController.text.replaceAll(RegExp(r'\D'), '')}';
    // throw Exception("Value $authValue");

    try {
      final user = await apiClient.authLogin(authValue);

      // Можно добавить доп. проверки:
      if (user == null) {
        throw Exception('Пользователь невалиден');
      }

      // Только если всё прошло успешно
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } catch (e, stackTrace) {
      debugPrint('Ошибка авторизации: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Ошибка авторизации')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(
        onLogoPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WelcomePage()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TitleText("Регистрация"),
                  // TitleMediumText("Выберите роль:"),
                  // RoleSelect(
                  //   selectedRoleName: selectedRoleName,
                  //   roles: roles,
                  //   onChanged: onRoleChanged,
                  //   selectHidden: hidenRoleSelect,
                  //   onChangedSelectHidden: onRoleSelectHiddenChanged,
                  // ),
                  TitleMediumText("Выберите способ входа:"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: AuthMethodSelect(
                        authInputController: authInputController,
                        selectedMethodName: selectedAuthMethodName,
                        onChanged: onAuthMethodChanged,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PrimaryButton(text: "Продолжить", onPressed: onSubmit),
                const SizedBox(height: 8),
                Text(
                  "Уже есть аккаунт? Войти",
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
