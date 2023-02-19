import 'package:get/get.dart';

import 'features/landing_screen/landing_screen.dart';
import 'features/home_screen/home_screen.dart';
import 'features/history_screen/history_screen.dart';

class AppRoutes {
  static var list = [
    GetPage(
      name: '/',
      page: () => const LandingScreen(),
    ),
    GetPage(
      name: HomeScreen.routeId,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: HistoryScreen.routeId,
      page: () => const HistoryScreen(),
    ),
  ];
}
