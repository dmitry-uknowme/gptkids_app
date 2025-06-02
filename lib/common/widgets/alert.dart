import 'package:flutter/material.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/button.dart';

class Alert extends StatelessWidget {
  const Alert({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Хочешь 10 запросов в день бесплатно?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            'Привяжи аккаунт родителя и получи бонусы!',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
          ),
          SizedBox(height: 16),
          PrimaryButton(
            text: "Привязать",
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
            onPressed: () {},
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: TextButton(onPressed: () {}, child: Text('OK')),
          // ),
        ],
      ),
    );
    // return Card(
    //   // elevation: 4,
    //   color: AppColors.secondary,
    //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    //   child: Padding(
    //     padding: const EdgeInsets.all(16),
    //     child: Column(
    //       children: [
    //         Text(
    //           'Хочешь 10 запросов в день бесплатно?',
    //           style: Theme.of(context).textTheme.titleMedium,
    //         ),
    //         SizedBox(height: 8),
    //         Text('Привяжи аккаунт родителя и получи бонусы!'),
    //         Align(
    //           alignment: Alignment.centerRight,
    //           child: TextButton(onPressed: () {}, child: Text('OK')),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
