import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/_ui/buttons/primary_button.dart';
import 'package:burency_demo/_ui/buttons/secondary_button.dart';

class ConfirmationModal extends StatelessWidget {
  final String title;
  final String prompt;
  final String cancelText;
  final String confirmText;
  final VoidCallback? onCancel;
  final VoidCallback onConfirm;

  const ConfirmationModal({
    Key? key,
    required this.prompt,
    this.title = 'CONFIRMATION',
    this.cancelText = 'CANCEL',
    this.confirmText = 'OK',
    required this.onCancel,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const double fieldWidth = 360;

    return Dialog(
      backgroundColor: theme.cardColor,
      surfaceTintColor: theme.cardColor,
      child: Container(
        height: 240,
        padding: const EdgeInsets.all(kBasePadding2),
        child: Column(
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kBasePadding),
              child: Text(
                prompt,
                style: theme.textTheme.titleSmall,
              ),
            ),
            const Spacer(),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: fieldWidth),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (onCancel != null) ...[
                    Expanded(
                      child: SecondaryButton(
                        onPressed: onCancel!,
                        label: cancelText.tr.toUpperCase(),
                      ),
                    ),
                    AppWidgetBuilder.horizontalSpacer(
                      width: kBasePadding,
                    ),
                  ],
                  Expanded(
                    child: PrimaryButton(
                      onPressed: onConfirm,
                      label: confirmText.tr.toUpperCase(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
