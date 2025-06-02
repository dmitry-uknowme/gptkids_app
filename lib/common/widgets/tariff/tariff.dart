import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/text.dart';

class TariffCard extends StatelessWidget {
  TariffCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(16),
      duration: Duration(microseconds: 500),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7B61FF), Color(0xFF977CFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset("assets/images/icons/crown.svg"),
                      SizedBox(width: 4),
                      TitleText(
                        "Премиум",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  LabelText(
                    "Осталось 25 дней",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              Spacer(),
              OutlinedButton(
                onPressed: () {},
                child: Text(
                  "Изменить тариф",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(8),
            minHeight: 8,
            backgroundColor: AppColors.primary.withOpacity(0.5),
            color: AppColors.secondary,
            value: 75 / 200,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              LabelText(
                "Использовано запросов: 75",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Spacer(),
              LabelText(
                "Осталось запросов: 125",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
