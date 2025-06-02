import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/theme/bottom_nav.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/theme/app_bar.dart';
import 'package:gptkids_app/common/widgets/alert.dart';
import 'package:gptkids_app/common/widgets/task/task.dart';
import 'package:gptkids_app/common/widgets/text.dart';
import 'package:gptkids_app/home/widgets/home_action_list.dart';
import 'package:gptkids_app/profile/profile_page.dart';
import 'package:gptkids_app/task/task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<TaskModel> tasks = [
    TaskModel(
      label: "Сделать домашку",
      description: "Математика, 5 заданий",
      icon: SvgPicture.asset(
        'assets/images/icons/book.svg',
        color: AppColors.primary,
      ),
      done: true,
    ),
    TaskModel(
      label: "Поиграть в Квизлик",
      description: "Биология, 10 вопросов",
      icon: SvgPicture.asset(
        'assets/images/icons/gamepad.svg',
        color: Colors.yellow,
      ),
    ),
    TaskModel(
      label: "Пригласить друга",
      description: "Получи дополнительные запросы",
      icon: SvgPicture.asset(
        'assets/images/icons/invite.svg',
        color: Colors.red,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        onLogoPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
            // MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText("Чем займемся сегодня?", noPadding: false),
            HomeActionList(),
            SizedBox(height: 16),
            Row(
              children: [
                TitleText("Задания на сегодня"),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TaskPage()),
                    );
                  },
                  child: Text(
                    "Посмотреть все",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  TaskList(tasks: tasks),
                  SizedBox(height: 16),
                  Alert(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
