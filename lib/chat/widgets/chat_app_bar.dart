import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/common/widgets/text.dart';
import 'package:provider/provider.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoPressed;
  const ChatAppBar({super.key, required this.onLogoPressed});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context, listen: true);
    var selectedLanguageCode = provider.selectedLanguageCode;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white70,
      elevation: 0,
      centerTitle: false,
      title: Row(
        children: [
          IconButton(
            icon: Image.asset('assets/images/raw_logo.png', height: 32),
            // icon: SvgPicture.asset('assets/images/raw_logo.svg', height: 10),
            onPressed: onLogoPressed,
          ),
          Text(
            "ИИ-ассистент",
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
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
                'assets/images/icons/settings.svg',
                color: Colors.black,
              ),
              SizedBox(width: 4),
              Text("Режимы", style: TextStyle(fontWeight: FontWeight.normal)),
            ],
          ),
        ),
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
      ],
    );
  }
}
