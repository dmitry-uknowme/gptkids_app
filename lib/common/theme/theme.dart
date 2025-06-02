import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF6C63FF); // Фиолетовая кнопка
  static const lightPrimary = Color.fromARGB(
    255,
    240,
    239,
    255,
  ); // Фиолетовая кнопка
  static const secondary = Color(0xFFF9A826); // Жёлтый акцент
  static const lightSecondary = Color.fromARGB(
    255,
    255,
    246,
    220,
  ); // Светло-жёлтый акцент
  // static const background = Color(0xFFF8F9FC); // Светло-серый фон
  static const background = Color(0xFFF5F6FA); // Светло-серый фон
  static const card = Colors.white; // Белые карточки
  // static const card = Color.fromARGB(255, 245, 245, 247); // Белые карточки
  // static const card = Colors.grey;
  static const textPrimary = Color(0xFF1E1E1E);
  static const textSecondary = Color(0xFF6B7280);
  static const border = Color(0xFFE0E0E0);
  static const icon = Color(0xFF9CA3AF);
}

final appTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Inter',
  cardColor: Colors.white,

  scaffoldBackgroundColor: AppColors.background, // светлый серый фон
  // scaffoldBackgroundColor: AppColors.background.withOpacity(0.9),
  primaryColor: AppColors.primary,
  splashColor: AppColors.primary.withOpacity(0.2), // ripple эффект
  highlightColor: AppColors.primary.withOpacity(0.1), // при удержании
  hoverColor: AppColors.primary.withOpacity(
    0.05,
  ), // при наведении (на вебе/десктопе)
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
  ),
  // colorScheme: ColorScheme.,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    labelLarge: TextStyle(fontSize: 16),
    labelMedium: TextStyle(
      color: AppColors.textPrimary,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      side: BorderSide(color: AppColors.primary),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
);

// final appTheme = ThemeData(
//   useMaterial3: true,
//   fontFamily: 'Inter',
//   scaffoldBackgroundColor: AppColors.background,
//   shadowColor: DefaultSelectionStyle.defaultColor,
//   primaryColor: AppColors.primary,
//   textTheme: TextTheme(
//     bodyLarge: TextStyle(color: AppColors.textPrimary, fontSize: 16),
//     titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     labelLarge: TextStyle(fontSize: 16),
//   ),
//   elevatedButtonTheme: ElevatedButtonThemeData(
//     style: ElevatedButton.styleFrom(
//       backgroundColor: AppColors.primary,
//       foregroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//       textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//     ),
//   ),
// );

final lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: Colors.deepPurple,
    secondary: Colors.amber,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(fontSize: 16),
    titleLarge: TextStyle(fontWeight: FontWeight.bold),
  ),
);
