import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final ButtonStyle? style;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).elevatedButtonTheme.style;
    return ElevatedButton(
      onPressed: enabled ? onPressed : null,
      style: defaultStyle?.merge(style),
      child: Text(text),
    );
  }
}

// class Button extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;

//   const Button({super.key, required this.text, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         shape: StadiumBorder(),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//       ),
//       onPressed: onPressed,
//       child: Text(text),
//     );
//   }
// }
