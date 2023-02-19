import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/controllers/auth_controller.dart';
import 'package:burency_demo/_ui/buttons/primary_mini_button.dart';

import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/global_assets.dart';

import 'components/contacts_page.dart';
import 'components/search_form.dart';
import 'components/update_form.dart';

class HomeScreen extends StatelessWidget {
  static const String routeId = '/home';
  static const String moduleName = 'HomeScreen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  void _showSearch(
    BuildContext context,
    ThemeData theme,
    String uid, {
    bool searchNearby = false,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: theme.cardColor,
      barrierColor: Colors.black.withOpacity(0.5),
      enableDrag: false,
      elevation: 1,
      builder: (BuildContext context) {
        return SearchForm(
          searchNearby: searchNearby,
          uid: uid,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final AuthController authController = Get.find();
    final uid = authController.authUser.uid;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        flexibleSpace: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              left: kBasePadding,
              right: kButtonIconSize + kBasePadding2,
            ),
            child: Row(
              children: [
                const SizedBox(
                  height: 64,
                  child: Image(
                    image: AssetImage(GlobalAssets.appLogo),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const Spacer(),
                Obx(() {
                  if (authController.isAuthenticated) {
                    return Row(
                      children: [
                        const Icon(
                          Icons.account_circle,
                          size: kBaseIconSize,
                        ),
                        const SizedBox(width: kBasePadding),
                        Text(
                          '${authController.authUser.displayName} ',
                          style: theme.textTheme.bodySmall!.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  }

                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),
        actions: [
          Obx(() {
            if (authController.isAuthenticated) {
              return IconButton(
                onPressed: () => authController.signOut(),
                icon: Icon(
                  Icons.logout,
                  size: kButtonIconSize,
                  color: theme.primaryColor,
                ),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.greenAccent.withOpacity(0.3),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(kBasePadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'My Contacts',
                      style: theme.textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 180),
                    child: Row(
                      children: [
                        Expanded(
                          child: PrimaryMiniButton(
                            label: 'Search'.tr.toUpperCase(),
                            onPressed: () => _showSearch(context, theme, uid),
                          ),
                        ),
                        const SizedBox(width: kBasePadding),
                        Expanded(
                          child: PrimaryMiniButton(
                            label: 'Nearby'.tr.toUpperCase(),
                            onPressed: () => _showSearch(
                              context,
                              theme,
                              uid,
                              searchNearby: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: kBasePadding,
              thickness: 1.0,
            ),
            const Expanded(child: ContactsPage())
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            barrierDismissible: false,
            barrierColor: Colors.black.withOpacity(0.5),
            context: context,
            builder: (context) {
              return const UpdateForm();
            },
          );
        },
      ),
    );
  }
}
