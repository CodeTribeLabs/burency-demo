import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/models/contact_model.dart';
import 'package:burency_demo/_ui/modals/confirmation_modal.dart';
import 'package:burency_demo/global_styles.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;
  final VoidCallback onViewPressed;

  const ContactTile({
    super.key,
    required this.contact,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onViewPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      // onTap: () {},
      contentPadding: const EdgeInsets.symmetric(horizontal: kBasePadding),
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: kBaseSpacing),
              child: Text(
                '${contact.firstName} ${contact.middleName} ${contact.lastName}',
                style: theme.textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: kBaseSpacing),
              child: Text(
                contact.phone,
                style: theme.textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kBaseSpacing),
                  child: Text(
                    contact.address,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: kBaseSpacing),
                  child: Text(
                    'Lat.: ${contact.latitude.toString()}',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: kBaseSpacing),
                  child: Text(
                    contact.note,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: kBaseSpacing),
                  child: Text(
                    'Lng.: ${contact.longitude.toString()}',
                    style: theme.textTheme.bodySmall,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: SizedBox(
        width: 120,
        child: Row(
          children: [
            IconButton(
              onPressed: onEditPressed,
              icon: Icon(
                Icons.edit,
                size: kMiniIconSize,
                color: theme.primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  barrierDismissible: false,
                  barrierColor: Colors.black.withOpacity(0.5),
                  context: context,
                  builder: (context) {
                    return ConfirmationModal(
                      prompt: 'Are you sure you want to delete this contact?',
                      onConfirm: () {
                        Get.back();
                        onDeletePressed();
                      },
                      onCancel: () => Get.back(),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.delete,
                size: kMiniIconSize,
                color: theme.primaryColor,
              ),
            ),
            IconButton(
              onPressed: () => onViewPressed(),
              icon: Icon(
                Icons.history_edu,
                size: kMiniIconSize,
                color: theme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
