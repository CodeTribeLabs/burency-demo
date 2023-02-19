import 'package:flutter/material.dart';

import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/_core/app_widget_builder.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final Widget? icon;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const SecondaryButton({
    Key? key,
    this.width = 100,
    this.height = 48,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBaseBorderRadius),
        ),
      ),
      onPressed: onPressed,
      child: Ink(
        decoration: AppWidgetBuilder.secondaryGradientBoxDecoration(),
        child: Container(
          padding: EdgeInsets.zero,
          width: double.infinity,
          height: height,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Text(label,
                  style: theme.textTheme.labelLarge!.copyWith(
                    color: Colors.white,
                    fontSize: 16,
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
