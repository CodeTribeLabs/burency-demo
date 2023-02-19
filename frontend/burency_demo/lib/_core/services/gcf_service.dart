import 'package:cloud_functions/cloud_functions.dart';

class GcfService {
  // Define Singleton
  GcfService._();
  static final instance = GcfService._();

  late FirebaseFunctions _apiRef;

  void initialize({
    required String region,
    required String emulatorHost,
    int emulatorPort = 5001,
  }) {
    if (region.isNotEmpty) {
      _apiRef = FirebaseFunctions.instanceFor(region: region);
      print('>>> API SERVICE INITIALIZED - Region=$region');
    } else {
      _apiRef = FirebaseFunctions.instance;
      print('>>> API SERVICE INITIALIZED - Region=default');
    }

    if (emulatorHost.isNotEmpty && emulatorPort > 0) {
      print(
          '>>> FIREBASE FUNCTIONS - Binding to Emulator at $emulatorHost:$emulatorPort...');
      _apiRef.useFunctionsEmulator(
        emulatorHost,
        emulatorPort,
      );
    } else {
      print('>>> FIREBASE FUNCTIONS - Binding to Live Server...');
    }
  }

  Future<dynamic> sendRequest({
    required String route,
    required dynamic payload,
  }) async {
    HttpsCallable callable = _apiRef.httpsCallable(route);

    // print('REQUEST: Route=$route Payload=$payload');

    final resp = await callable.call(payload);

    // print('RESPONSE: ${resp.data}');
    return resp.data;
  }
}
