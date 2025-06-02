import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/home/home_page.dart';
import 'package:gptkids_app/profile/profile_page.dart';
import 'package:gptkids_app/task/task_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

  late final List<BottomNavItem> navItems = [
    BottomNavItem(
      icon:
          (isSelected) => SvgPicture.asset(
            'assets/images/icons/robot.svg',
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
      label: 'ИИ-помощник',
      toPage: const HomePage(),
    ),
    BottomNavItem(
      icon:
          (isSelected) => SvgPicture.asset(
            'assets/images/icons/gamepad.svg',
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
      label: 'Игровая',
      // toPage: const Placeholder(), // Замените на нужную страницу
    ),
    BottomNavItem(
      icon:
          (isSelected) => SvgPicture.asset(
            'assets/images/icons/task_list.svg',
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
      label: 'Задания',
      toPage: const TaskPage(),
    ),
    BottomNavItem(
      icon:
          (isSelected) => SvgPicture.asset(
            'assets/images/icons/profile.svg',
            color: isSelected ? AppColors.primary : Colors.grey,
          ),
      label: 'Профиль',
      toPage: const ProfilePage(),
    ),
  ];

  void _onTap(int index) {
    if (_currentIndex == index) return;

    final destination = navItems[index].toPage;
    if (destination != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: _onTap,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items:
          navItems
              .asMap()
              .entries
              .map(
                (entry) => BottomNavigationBarItem(
                  icon: entry.value.icon(_currentIndex == entry.key),
                  label: entry.value.label,
                ),
              )
              .toList(),
    );
  }
}

class BottomNavItem {
  final Widget Function(bool isSelected) icon;
  final String label;
  final Widget? toPage;

  BottomNavItem({required this.icon, required this.label, this.toPage});
}
