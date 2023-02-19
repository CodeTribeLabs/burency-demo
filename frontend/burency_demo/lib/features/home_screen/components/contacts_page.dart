import 'package:burency_demo/_core/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:burency_demo/_core/controllers/contacts_controller.dart';
import 'package:burency_demo/_ui/modals/cool_snackbar.dart';
import 'package:burency_demo/_ui/modals/screen_locker.dart';

import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/features/home_screen/components/update_form.dart';
import 'package:burency_demo/features/history_screen/history_screen.dart';
import 'contact_tile.dart';

class ContactsPage extends StatefulWidget {
  static const String moduleName = 'DashboardScreen';
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final _scrollController = ScrollController();

  final AuthController _authController = Get.find();
  final ContactsController _contactsController = Get.find();
  String _uid = '';

  @override
  void initState() {
    super.initState();

    _uid = _authController.authUser.uid;
    _contactsController.fetch(_uid);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_contactsController.haveMore) {
          _contactsController.fetchMore(_uid);
        }
      }
    });
  }

  void _removeContact(String id) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return const ScreenLocker();
      },
    );

    final resp = await _contactsController.removeContact(id);

    Get.back();

    if (resp.isEmpty) {
      Get.back();
    } else {
      AppWidgetBuilder.showFlashSnackbar(
        context: context,
        snackBarType: SnackBarType.failure,
        title: 'error.error'.tr,
        message: resp.tr,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(kBasePadding),
            child: Obx(() {
              final contacts = _contactsController.contacts;

              if (_contactsController.isLoading) {
                return AppWidgetBuilder.progressIndicator(
                  color: theme.primaryColor,
                );
              }

              if (contacts.isEmpty) {
                return Text(
                  'No contacts found.',
                  style: theme.textTheme.labelMedium,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await _contactsController.fetch(_uid);
                },
                child: ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (_, __) => const SizedBox(),
                  itemBuilder: (_, index) {
                    if (index == contacts.length) {
                      if (_contactsController.haveMore) {
                        return AppWidgetBuilder.miniProgressIndicator();
                      } else {
                        return const SizedBox(height: kBasePadding6);
                      }
                    }

                    final contact = contacts[index];
                    final tileColor = index.isEven
                        ? theme.dividerColor.withOpacity(0.1)
                        : Colors.transparent;

                    return Container(
                      color: tileColor,
                      child: ContactTile(
                        contact: contact,
                        onEditPressed: () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return UpdateForm(contact: contact);
                            },
                          );
                        },
                        onDeletePressed: () => _removeContact(contact.id),
                        onViewPressed: () {
                          Get.toNamed(
                            HistoryScreen.routeId,
                            arguments: [contact.id],
                          );
                        },
                      ),
                    );
                  },
                  primary: false,
                  shrinkWrap: true,
                  itemCount: contacts.length + 1,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
