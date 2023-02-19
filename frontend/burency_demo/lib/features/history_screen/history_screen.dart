import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/_core/controllers/contacts_controller.dart';
import 'package:burency_demo/_core/controllers/history_controller.dart';
import 'package:burency_demo/_core/models/contact_model.dart';
import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/theme.dart';

import 'components/history_tile.dart';

class HistoryScreen extends StatefulWidget {
  static const String routeId = '/history';
  static const String moduleName = 'HistoryScreen';

  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final _scrollController = ScrollController();

  final ContactsController _contactsController = Get.find();
  final HistoryController _historyController = Get.find();

  late ContactModel _contact;

  @override
  void initState() {
    super.initState();

    _contact = _contactsController.getContact(Get.arguments[0]);
    _historyController.fetch(_contact.id);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_historyController.haveMore) {
          _historyController.fetchMore(_contact.id);
        }
      }
    });
  }

  List<Widget> _buildContactField({
    required ThemeData theme,
    required double iconSize,
    required IconData icon,
    required Color iconColor,
    required String fieldValue,
  }) {
    return [
      Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: kBasePadding),
          child: Text(
            fieldValue,
            style: theme.textTheme.bodyLarge,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeManager = ThemeManager.getInstance();

    const vSpacer = SizedBox(height: kBasePadding);
    const vPadding = EdgeInsets.symmetric(horizontal: kBasePadding);
    const double iconSize = kMiniIconSize;
    final Color iconColor = themeManager.accentColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            FontAwesomeIcons.chevronLeft,
            size: kButtonIconSize,
            color: theme.primaryColor,
          ),
        ),
        title: Text(
          _contact.fullName,
          style: theme.textTheme.headlineSmall!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.greenAccent.withOpacity(0.3),
        child: Column(
          children: [
            vSpacer,
            Padding(
              padding: vPadding,
              child: Row(
                children: [
                  ..._buildContactField(
                    theme: theme,
                    iconSize: iconSize,
                    icon: Icons.phone,
                    iconColor: iconColor,
                    fieldValue: _contact.phone,
                  ),
                  ..._buildContactField(
                    theme: theme,
                    iconSize: iconSize,
                    icon: Icons.place,
                    iconColor: iconColor,
                    fieldValue: 'Latitude: ${_contact.latitude.toString()}',
                  ),
                ],
              ),
            ),
            vSpacer,
            Padding(
              padding: vPadding,
              child: Row(
                children: [
                  ..._buildContactField(
                    theme: theme,
                    iconSize: iconSize,
                    icon: Icons.home,
                    iconColor: iconColor,
                    fieldValue: _contact.address,
                  ),
                  ..._buildContactField(
                    theme: theme,
                    iconSize: iconSize,
                    icon: Icons.place,
                    iconColor: iconColor,
                    fieldValue: 'Longitude: ${_contact.longitude.toString()}',
                  ),
                ],
              ),
            ),
            vSpacer,
            Padding(
              padding: vPadding,
              child: Row(
                children: [
                  ..._buildContactField(
                    theme: theme,
                    iconSize: iconSize,
                    icon: Icons.note,
                    iconColor: iconColor,
                    fieldValue: _contact.note,
                  ),
                ],
              ),
            ),
            vSpacer,
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(kBasePadding),
              child: Text(
                'Update History'.tr,
                style: theme.textTheme.titleMedium!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(kBasePadding),
                child: Obx(() {
                  final historyList = _historyController.historyList;

                  if (_historyController.isLoading) {
                    return AppWidgetBuilder.progressIndicator(
                      color: theme.primaryColor,
                    );
                  }

                  if (historyList.isEmpty) {
                    return Text(
                      'Update history is empty.',
                      style: theme.textTheme.labelMedium,
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await _historyController.fetch(_contact.id);
                    },
                    child: ListView.separated(
                      controller: _scrollController,
                      separatorBuilder: (_, __) => const SizedBox(),
                      itemBuilder: (_, index) {
                        if (index == historyList.length) {
                          if (_historyController.haveMore) {
                            return AppWidgetBuilder.miniProgressIndicator();
                          } else {
                            return const SizedBox(height: kBasePadding6);
                          }
                        }

                        final history = historyList[index];
                        final tileColor = index.isEven
                            ? theme.dividerColor.withOpacity(0.1)
                            : Colors.transparent;

                        return Container(
                          color: tileColor,
                          child: HistoryTile(history: history),
                        );
                      },
                      primary: false,
                      shrinkWrap: true,
                      itemCount: historyList.length + 1,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
