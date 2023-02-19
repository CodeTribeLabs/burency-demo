import 'package:flutter/material.dart';

import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/theme.dart';

class PrimaryMiniButton extends StatelessWidget {
  final String label;
  final Widget? icon;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const PrimaryMiniButton({
    Key? key,
    this.width = 60,
    this.height = 32,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeManager = ThemeManager.getInstance();

    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBaseBorderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: AppWidgetBuilder.primaryGradientBoxDecoration(
          primaryGradientDarkTone: themeManager.primaryGradientLightTone,
          primaryGradientLightTone: themeManager.primaryGradientLightTone,
        ),
        child: Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          height: height,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Text(label,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  )),
              if (icon != null)
                Positioned(
                  right: 5,
                  child: icon!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
