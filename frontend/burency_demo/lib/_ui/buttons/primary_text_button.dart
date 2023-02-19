import 'package:flutter/material.dart';

import 'package:burency_demo/global_styles.dart';

class PrimaryTextButton extends StatelessWidget {
  final String label;
  final Color? color;
  final Color? backgroundColor;
  final Size? size;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final Widget? icon;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;

  const PrimaryTextButton({
    Key? key,
    this.color,
    this.backgroundColor,
    this.textStyle,
    this.size,
    this.icon,
    this.padding,
    this.textAlign = TextAlign.start,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final foregroundColor = color ?? theme.primaryColor;

    return TextButton(
      child: Row(
        mainAxisAlignment: textAlign == TextAlign.center
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: textAlign,
          ),
          if (icon != null) ...[const SizedBox(width: kBaseSpacing), icon!]
        ],
      ),
      style: TextButton.styleFrom(
        fixedSize: size,
        padding: padding,
        foregroundColor: foregroundColor,
        backgroundColor: backgroundColor,
        textStyle: textStyle ?? theme.textTheme.titleLarge,
      ),
      onPressed: onPressed,
    );
  }
}
