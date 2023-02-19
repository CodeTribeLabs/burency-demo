import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/device_settings.dart';
import 'package:burency_demo/_core/controllers/burency_core.dart';
import 'firebase_options.dart';
import 'app_routes.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await BurencyCore.initialize(
    options: DefaultFirebaseOptions.currentPlatform,
    region: 'us-central1',
    // emulatorHost: 'localhost',
    emulatorHost: '',
    authEmulatorPort: 9099,
    firestoreEmulatorPort: 8080,
    functionsEmulatorPort: 5001,
  );

  runApp(const AppLauncher(
    appName: 'Burency Demo',
    initialLanguageCode: 'en',
    initialCountryCode: 'US',
    useDarkMode: true,
  ));
}

class AppLauncher extends StatelessWidget {
  static const String moduleName = 'AppLauncher';

  final String appName;
  final String initialLanguageCode;
  final String initialCountryCode;
  final bool useDarkMode;

  const AppLauncher({
    Key? key,
    required this.appName,
    required this.initialLanguageCode,
    required this.initialCountryCode,
    required this.useDarkMode,
  }) : super(key: key);

  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    final themeManager = ThemeManager.getInstance();
    themeManager.initThemeData();

    // Use GetMaterialApp instead of normal MaterialApp
    // to take advantage of the GetX framework for state management and routing
    // return Obx(() {
    return GetMaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      // translations: localeTranslations,
      locale: Locale(initialLanguageCode, initialCountryCode),
      fallbackLocale: const Locale('en', 'US'),
      scrollBehavior: DeviceScrollBehavior(),
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        // print('PIXEL RATIO: ${data.devicePixelRatio}');

        return MediaQuery(
          data: data.copyWith(
            textScaleFactor: 1.0,
            // devicePixelRatio: 1.0,
          ),
          child: child!,
        );
      },
      initialRoute: '/',
      getPages: AppRoutes.list,
      theme: themeManager.loadThemeData(context: context, darkMode: false),
      darkTheme: themeManager.loadThemeData(context: context, darkMode: true),
      themeMode: useDarkMode ? ThemeMode.dark : ThemeMode.light,
    );
    // });
  }
}
