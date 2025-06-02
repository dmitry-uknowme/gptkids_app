import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool noPadding;

  const TitleText(this.text, {super.key, this.style, this.noPadding = false});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.titleLarge;
    return noPadding
        ? Text(
          text,
          style: defaultStyle?.merge(style),
          textAlign: TextAlign.center,
        )
        : Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text,
            style: defaultStyle?.merge(style),
            textAlign: TextAlign.center,
          ),
        );
  }
}

class TitleMediumText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool noPadding;

  const TitleMediumText(
    this.text, {
    super.key,
    this.style,
    this.noPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return noPadding
        ? Text(
          text,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        )
        : Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        );
  }
}

class LabelText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const LabelText(this.text, {this.style, super.key});

  @override
  Widget build(BuildContext context) {
    final defaultStyle = Theme.of(context).textTheme.labelMedium;
    return Text(
      text,
      style: defaultStyle?.merge(style),
      textAlign: TextAlign.center,
    );
  }
}
