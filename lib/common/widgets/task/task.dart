import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/status.dart';
import 'package:gptkids_app/common/widgets/text.dart';

class TaskList extends StatelessWidget {
  final List<TaskModel> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    var tasksAllCount = tasks.length;
    var tasksDoneCount = tasks.where((task) => task.done).length;
    var tasksDonePercent = tasksDoneCount / tasksAllCount;
    return Column(
      children: [
        Row(
          children: [
            TitleMediumText("Прогресс"),
            SizedBox(width: 6),
            Text(
              '$tasksDoneCount/$tasksAllCount',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            // TitleMediumText('$tasksDoneCount/$tasksAllCount'),
            Spacer(),
            Text(
              '${(tasksDonePercent * 100).toInt()}%',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          backgroundColor: AppColors.border,
          color: AppColors.primary,
          value: tasksDonePercent,
        ),
        SizedBox(height: 16),
        Column(
          children:
              tasks.map((task) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TaskCard(
                    label: task.label,
                    description: task.description,
                    icon: task.icon,
                    done: task.done,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

class TaskCard extends StatelessWidget {
  final String label;
  final String description;
  final Widget icon;
  final bool done;

  const TaskCard({
    super.key,
    required this.label,
    required this.description,
    required this.icon,
    this.done = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      // shape: RoundedRectangleBorder(),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: const TextStyle(fontSize: 16)),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CircleStatusIndicator(done: done),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskModel {
  final String label;
  final String description;
  final Widget icon;
  final bool done;

  const TaskModel({
    required this.label,
    required this.description,
    required this.icon,
    this.done = false,
  });
}
