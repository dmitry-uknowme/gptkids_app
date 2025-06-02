import 'package:flutter/material.dart';
import 'package:gptkids_app/auth/tg_login_page.dart';
import 'package:gptkids_app/common/theme/theme.dart';
import 'package:gptkids_app/welcome/widgets/phone_number_field.dart';

class AuthMethodSelect extends StatelessWidget {
  final String selectedRoleName;
  final List<AuthMethodOption> methods;
  final ValueChanged<String> onChanged;
  final TextEditingController authInputController;

  AuthMethodSelect({
    super.key,
    String? selectedMethodName,
    List<AuthMethodOption>? methods,
    required this.onChanged,
    required this.authInputController,
  }) : selectedRoleName =
           selectedMethodName ?? DEFAULT_AUTH_METHOD_LIST.first.name,
       methods = methods ?? DEFAULT_AUTH_METHOD_LIST;

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          methods.map((option) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: SizedBox(
                width: double.infinity,
                child: AuthMethodSelectCard(
                  inputController: authInputController,
                  selected: option.name == selectedRoleName,
                  name: option.name,
                  label: option.label,
                  icon: option.icon,
                  onTap: () => onChanged(option.name),
                  // onTap:
                  //     () => {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => TelegramLoginPage(),
                  //         ),
                  //       ),
                  //     },
                ),
              ),
            );
          }).toList(),
    );
  }
}

// class AuthMethodSelectCard extends StatelessWidget {
//   final bool selected;
//   final String name;
//   final String label;
//   final IconData icon;
//   final VoidCallback onTap;

//   const AuthMethodSelectCard({
//     super.key,
//     required this.selected,
//     required this.name,
//     required this.label,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 200),
//       decoration: BoxDecoration(
//         color: selected ? AppColors.primary.withOpacity(0.1) : AppColors.card,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(
//           color: selected ? AppColors.primary : AppColors.border,
//           width: 1.5,
//         ),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Padding(
//           padding: const EdgeInsets.all(12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(
//                 icon,
//                 color: selected ? AppColors.primary : AppColors.textPrimary,
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 label,
//                 style: const TextStyle(fontSize: 16),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class AuthMethodSelectCard extends StatefulWidget {
  final bool selected;
  final String name;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final TextEditingController inputController;

  const AuthMethodSelectCard({
    super.key,
    required this.selected,
    required this.name,
    required this.label,
    required this.icon,
    required this.onTap,
    required this.inputController,
  });

  @override
  State<AuthMethodSelectCard> createState() => _AuthMethodSelectCardState();
}

class _AuthMethodSelectCardState extends State<AuthMethodSelectCard>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        decoration: BoxDecoration(
          color:
              widget.selected
                  ? AppColors.primary.withOpacity(0.1)
                  : AppColors.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: widget.selected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      widget.icon,
                      color:
                          widget.selected
                              ? AppColors.primary
                              : AppColors.textPrimary,
                    ),
                    const SizedBox(width: 12),
                    Text(widget.label, style: const TextStyle(fontSize: 16)),
                  ],
                ),
                if (widget.selected) const SizedBox(height: 12),
                if (widget.selected)
                  _buildFormFields(widget.name, widget.inputController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormFields(
    String methodName,
    TextEditingController inputController,
  ) {
    switch (methodName) {
      case 'email':
        return Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 8),
            // TextFormField(
            //   decoration: const InputDecoration(labelText: 'Пароль'),
            //   obscureText: true,
            // ),
          ],
        );
      case 'phone':
        return PhoneNumberField(controller: inputController);
      case 'telegram':
        return PhoneNumberField(controller: inputController);
      default:
        return const SizedBox.shrink();
    }
  }
}

class AuthMethodOption {
  final String name;
  final String label;
  final IconData icon;

  AuthMethodOption({
    required this.name,
    required this.label,
    required this.icon,
  });
}

List<AuthMethodOption> DEFAULT_AUTH_METHOD_LIST = [
  AuthMethodOption(
    name: "telegram",
    label: "Через Telegram",
    icon: Icons.telegram_outlined,
  ),
  // AuthMethodOption(
  //   name: "phone",
  //   label: "Через телефон",
  //   icon: Icons.phone_android_outlined,
  // ),
  // AuthMethodOption(
  //   name: "email",
  //   label: "Через email",
  //   icon: Icons.email_rounded,
  // ),
];
