import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/achievement.dart';
import 'package:gptkids_app/common/widgets/avatar.dart';
import 'package:gptkids_app/common/widgets/button.dart';
import 'package:gptkids_app/common/widgets/page_layout.dart';
import 'package:gptkids_app/common/widgets/tariff/tariff.dart';
import 'package:gptkids_app/common/widgets/text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final avatar = File(picked.path);
      Provider.of<AppProvider>(context, listen: false).setUserAvatar(avatar);
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedAvatar =
        Provider.of<AppProvider>(context, listen: true).userAvatar;
    ;
    return PageLayout(
      page: Scaffold(
        appBar: AppBar(title: Text("Профиль")),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Center(
                  child: Avatar(
                    enableChange: true,
                    avatar: selectedAvatar,
                    onChange: _pickImage,
                  ),
                ),
                Column(
                  children: [
                    TitleText("Дмитрий Иванов"),
                    LabelText(
                      "7 класс   13 лет",
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    SizedBox(height: 16),
                    PrimaryButton(
                      text: "Редактировать профиль",
                      onPressed: () {},
                      style: ButtonStyle(
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        TitleMediumText("Ачивки и награды"),
                        Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            "Все >",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children:
                          DEFAULT_ACHIEVEMENT_LIST
                              .map(
                                (option) => Expanded(
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      child: AchievementCard(
                                        label: option.label,
                                        description: option.description,
                                        icon: option.icon,
                                        bgColor: option.bgColor,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                    ),
                    SizedBox(height: 16),
                    Card(
                      child: Row(
                        children:
                            DEFAULT_ACHIEVEMENT_LIST
                                .map(
                                  (option) => Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                      child: AchievementCard(
                                        label: option.label,
                                        description: option.description,
                                        icon: option.icon,
                                        bgColor: option.bgColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                    ),
                    SizedBox(height: 16),
                    TariffCard(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
