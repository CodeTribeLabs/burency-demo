import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:burency_demo/_core/models/history_model.dart';
import 'package:burency_demo/global_styles.dart';

class HistoryTile extends StatelessWidget {
  final HistoryModel history;

  const HistoryTile({
    super.key,
    required this.history,
  });

  String _translateType(String type) {
    switch (type) {
      case 'ADD_CONTACT':
        return 'New contact added';
      case 'UPDATE_CONTACT':
        return 'Updated: ';
      case 'DELETE_CONTACT':
        return 'Contact removed';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      // onTap: () {},
      contentPadding: const EdgeInsets.symmetric(
        horizontal: kBasePadding,
        vertical: 0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_translateType(history.type)}${history.changes}',
            style: theme.textTheme.bodyLarge,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            timeago.format(history.timestamp!),
            style: theme.textTheme.bodySmall!.copyWith(
              color: theme.textTheme.bodySmall!.color!.withOpacity(0.5),
            ),
          )
        ],
      ),
    );
  }
}
