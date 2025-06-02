import 'package:flutter/material.dart';
import 'package:gptkids_app/common/widgets/task/task_streak.dart';
import 'package:gptkids_app/common/widgets/text.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TitleText("Задания")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(children: [TaskStreak()]),
      ),
    );
  }
}
