import 'package:burency_demo/_core/app_widget_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/controllers/auth_controller.dart';

import 'package:burency_demo/global_assets.dart';
import 'package:burency_demo/global_styles.dart';
import 'package:burency_demo/features/landing_screen/components/login_form.dart';
import 'package:burency_demo/features/landing_screen/components/register_form.dart';
import 'package:burency_demo/features/home_screen/home_screen.dart';

class LandingScreen extends StatelessWidget {
  static const String moduleName = 'LandingScreen';

  const LandingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final AuthController authController = Get.find();

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        // color: Colors.greenAccent.withOpacity(0.3),
        child: Obx(() {
          if (authController.isAuthenticated) {
            return const HomeScreen();
          }

          if (!authController.isInitialized) {
            return AppWidgetBuilder.progressIndicator(
              color: theme.primaryColor,
            );
          }

          return Stack(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(kBasePadding2),
                  width: 350,
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 64,
                        child: Image(
                          image: AssetImage(GlobalAssets.appLogo),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(height: kBasePadding2),
                      authController.isLoginMode
                          ? LoginForm(
                              onComplete: () {},
                              onCancel: () {},
                            )
                          : RegisterForm(
                              onComplete: () {},
                              onCancel: () {},
                            )
                    ],
                  ),
                ),
              ),
              if (authController.isLoading)
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: theme.scaffoldBackgroundColor.withOpacity(0.3),
                  child: AppWidgetBuilder.progressIndicator(
                    color: theme.primaryColor,
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
