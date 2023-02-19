import 'package:flutter/material.dart';

import 'package:burency_demo/_core/app_widget_builder.dart';

class ScreenLocker extends StatelessWidget {
  final double backdropOpacity;

  const ScreenLocker({
    Key? key,
    this.backdropOpacity = 0.1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black.withOpacity(backdropOpacity),
      child: Center(
        child: AppWidgetBuilder.progressIndicator(
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
