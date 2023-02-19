import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:burency_demo/_core/controllers/history_controller.dart';
import 'package:burency_demo/_core/services/gcf_service.dart';

import 'auth_controller.dart';
import 'contacts_controller.dart';

class BurencyCore {
  static Future<void> initialize({
    required FirebaseOptions options,
    String region = '',
    String emulatorHost = '',
    int authEmulatorPort = 0,
    int firestoreEmulatorPort = 0,
    int functionsEmulatorPort = 0,
  }) async {
    await Firebase.initializeApp(
      options: options,
    );

    // Firebase Emulator:
    // https://firebase.google.com/codelabs/get-started-firebase-emulators-and-flutter#6

    if (emulatorHost.isNotEmpty) {
      if (firestoreEmulatorPort > 0) {
        FirebaseFirestore.instance.useFirestoreEmulator(
          emulatorHost,
          firestoreEmulatorPort,
        );
        print(
            '>>> FIREBASE FIRESTORE - Binding to Emulator at $emulatorHost:$firestoreEmulatorPort...');
      }
    }

    GcfService.instance.initialize(
      region: region,
      emulatorHost: emulatorHost,
      emulatorPort: functionsEmulatorPort,
    );

    // Initialize the app state controllers
    Get.put(AuthController(
      emulatorHost: emulatorHost,
      emulatorPort: authEmulatorPort,
    ));
    Get.put(ContactsController());
    Get.put(HistoryController());
  }
}
