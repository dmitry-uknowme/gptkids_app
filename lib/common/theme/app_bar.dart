import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/avatar.dart';
import 'package:gptkids_app/common/widgets/text.dart';
import 'package:provider/provider.dart';
import 'package:gptkids_app/welcome/widgets/language_dropdown.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoPressed;
  const BaseAppBar({super.key, required this.onLogoPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context, listen: true);
    var selectedLanguageCode = provider.selectedLanguageCode;
    var selectedAvatar = provider.userAvatar;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white70,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          InkWell(
            onTap: onLogoPressed,
            child: Avatar(avatar: selectedAvatar, size: 48),
          ),
          // IconButton(
          //   icon: Image.asset('assets/images/raw_logo.png', height: 32),
          //   // icon: SvgPicture.asset('assets/images/raw_logo.svg', height: 10),
          //   onPressed: onLogoPressed,
          // ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Привет,",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              TitleText("Дмитрий!", noPadding: true),
            ],
          ),
        ],
      ),
      actions: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/icons/diamond.svg',
                color: AppColors.primary,
              ),
              SizedBox(width: 4),
              Text(
                100.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 20),
          child: SvgPicture.asset(
            'assets/images/icons/notification.svg',
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
