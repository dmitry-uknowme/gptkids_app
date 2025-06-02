import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gptkids_app/common/provider/app_provider.dart';
import 'package:gptkids_app/welcome/widgets/language_dropdown.dart';
import 'package:provider/provider.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogoPressed;
  const AuthAppBar({super.key, required this.onLogoPressed});

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
      title: IconButton(
        icon: SvgPicture.asset('assets/images/horizontal_logo.svg', height: 32),
        onPressed: onLogoPressed,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: LanguageDropdown(
            selectedLanguageCode: selectedLanguageCode,
            onChanged: (value) {
              provider.setLanguageCode(value);
            },
          ),
        ),
      ],
    );
  }
}
