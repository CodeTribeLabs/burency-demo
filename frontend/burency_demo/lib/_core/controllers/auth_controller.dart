import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'api_commons.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  uninitialized,
  signedOut,
  submitted,
  verifyingPhone,
  phoneVerificationTimeout,
  phoneVerificationFailed,
  signedIn,
}

enum AuthLoginType {
  anonymous,
  email,
  google,
  facebook,
  apple,
  phone,
}

class AuthFormModel {
  String email;
  String password;

  AuthFormModel({
    this.email = '',
    this.password = '',
  });

  factory AuthFormModel.fromJson(Map<String, dynamic> parsedJson) {
    return AuthFormModel(
      email: parsedJson['email'],
      password: parsedJson['password'],
    );
  }

  dynamic toJson() => {
        'email': email,
        'password': password,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class AuthResult {
  String code;
  String? message;

  AuthResult({
    this.code = '',
    this.message = '',
  });

  bool get isSuccessful => code == ServerResultCode.ok;
}

class AuthUser {
  final String uid;
  final String userName;
  final String displayName;
  final String email;
  final String photoUrl;
  final String phoneNumber;
  final bool emailVerified;
  final AuthLoginType loginType;

  AuthUser({
    required this.uid,
    required this.userName,
    this.displayName = '',
    this.email = '',
    this.photoUrl = '',
    this.phoneNumber = '',
    this.emailVerified = false,
    this.loginType = AuthLoginType.anonymous,
  });

  bool get isAuthenticated => uid.isNotEmpty;

  factory AuthUser.fromDefault() {
    return AuthUser(
      uid: '',
      userName: '',
    );
  }

  factory AuthUser.fromFirebase(User? firebaseUser) {
    if (firebaseUser == null) {
      return AuthUser.fromDefault();
    }

    String userName = 'Anonymous';
    String displayName = firebaseUser.displayName ?? '';
    AuthLoginType loginType = AuthLoginType.anonymous;

    if (firebaseUser.providerData.isNotEmpty) {
      switch (firebaseUser.providerData[0].providerId.toUpperCase()) {
        case 'PHONE':
          userName = firebaseUser.phoneNumber!;
          loginType = AuthLoginType.phone;
          break;
        case 'EMAIL':
        case 'PASSWORD':
          userName = firebaseUser.email!;
          loginType = AuthLoginType.email;
          break;
        case 'GOOGLE':
        case 'GOOGLE.COM':
          userName = firebaseUser.email!;
          loginType = AuthLoginType.google;
          break;
        case 'FACEBOOK':
        case 'FACEBOOK.COM':
          userName = firebaseUser.email!;
          loginType = AuthLoginType.facebook;
          break;
        default:
          userName = 'Anonymous';
          break;
      }
    }

    if (displayName.isEmpty) {
      if (userName.contains('@')) {
        displayName = userName.split('@').first;
      } else {
        displayName = 'Anonymous';
      }
    }

    //print('>>> AuthUser: ${firebaseUser.toString()}');

    return AuthUser(
      uid: firebaseUser.uid,
      userName: userName,
      displayName: displayName,
      email: firebaseUser.email ?? '',
      phoneNumber: firebaseUser.phoneNumber ?? '',
      photoUrl: firebaseUser.photoURL ?? '',
      emailVerified: firebaseUser.emailVerified,
      loginType: loginType,
    );
  }

  factory AuthUser.fromFacebook(
    Map<String, dynamic>? facebookUserData,
    User? firebaseUser,
  ) {
    if (firebaseUser == null || facebookUserData == null) {
      return AuthUser.fromDefault();
    }

    final facebookUser = FacebookUser.fromJson(facebookUserData);

    //print('>>> FB USER DATA: ' + jsonEncode(facebookUserData));
    //{
    // "name":"Koko Martinez",
    // "email":"kvmxscnmtz_1609173502@tfbnw.net",
    // "picture": {
    //    "data": {
    //        "height":126,
    //        "is_silhouette":true,
    //        "url":"https://scontent.fmnl2-1.fna.fbcdn.net/v/t1.30497-1/s200x200/84628273_176159830277856_972693363922829312_n.jpg?_nc_cat=1&ccb=1-3&_nc_sid=12b3be&_nc_ohc=iYjHboHBvPcAX-bb5jY&_nc_ht=scontent.fmnl2-1.fna&tp=7&oh=aceb2e40d36d6b6c2df93fb73f512457&oe=60924F65",
    //        "width":200
    //    }
    // },
    // "id":"101102565263072"
    //}

    return AuthUser(
      uid: firebaseUser.uid,
      userName: facebookUser.email,
      displayName: facebookUser.name,
      email: facebookUser.email,
      phoneNumber: firebaseUser.phoneNumber ?? '',
      photoUrl: facebookUser.photoUrl,
      emailVerified: facebookUser.email.isNotEmpty,
      loginType: AuthLoginType.facebook,
    );
  }

  dynamic toJson() => {
        'uid': uid,
        'userName': userName,
        'displayName': displayName,
        'email': email,
        'photoUrl': photoUrl,
        'phoneNumber': phoneNumber,
        'emailVerified': emailVerified,
        'loginType': loginType,
      };

  @override
  String toString() {
    return toJson().toString();
  }
}

class FacebookUser {
  final String id;
  final String name;
  final String email;
  final String photoUrl;

  FacebookUser(this.id, this.name, this.email, this.photoUrl);

  FacebookUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        photoUrl = json['picture']['data']['url'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      };
}

class AuthController extends GetxController {
  static const String moduleName = 'AuthController';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observables
  final _isLoginMode = true.obs;
  final _isLoading = false.obs;
  final _isInitialized = false.obs;
  final _authUser = AuthUser.fromDefault().obs;

  AuthController({
    required String emulatorHost,
    required int emulatorPort,
  }) {
    _initEmulator(emulatorHost, emulatorPort);
  }

  void _initEmulator(String emulatorHost, int emulatorPort) async {
    if (emulatorHost.isNotEmpty && emulatorPort > 0) {
      await _auth.useAuthEmulator(
        emulatorHost,
        emulatorPort,
      );
      print(
          '>>> FIREBASE AUTH - Binding to Emulator at $emulatorHost:$emulatorPort...');
    } else {
      print('>>> FIREBASE AUTH - Binding to Live Server...');
    }

    _auth.authStateChanges().listen((firebaseUser) {
      _authUser.value = AuthUser.fromFirebase(firebaseUser);
    });

    _isInitialized.value = true;
  }

  bool get isLoading => _isLoading.value;

  bool get isLoggedOut => !authUser.isAuthenticated;

  bool get isAuthenticated => authUser.isAuthenticated;

  bool get isLoginMode => _isLoginMode.value;

  bool get isInitialized => _isInitialized.value;

  AuthUser get authUser {
    return _authUser.value;
  }

  bool isCurrentUserEmailVerified() {
    if (!authUser.isAuthenticated) return false;

    AuthUser currentUser = authUser;
    if (authUser.loginType == AuthLoginType.email) {
      print(
          '>>> $moduleName | EMAIL PROVIDER FOUND : Verified=${currentUser.emailVerified}');
    }

    return (currentUser.loginType == AuthLoginType.email ||
            currentUser.loginType == AuthLoginType.anonymous)
        ? currentUser.emailVerified
        : true;
  }

  bool isCurrentUserPhoneVerified() {
    final authUser = _auth.currentUser;
    if (authUser == null) return false;

    print('>>> $moduleName | VERIFIED PHONE: ${authUser.phoneNumber}');
    final l = authUser.providerData.length;
    if (l > 0) {
      for (int i = 0; i < l; i++) {
        if (authUser.providerData[i].providerId.isNotEmpty) {
          if (authUser.providerData[i].providerId.toUpperCase() == 'PHONE') {
            print('>>> $moduleName | PHONE PROVIDER FOUND : Idx=$i');
            //print('>>> PHONE PROVIDER FOUND : Idx=$i Provider=${authUser.providerData[i].toString()}');
            return true;
          }
        }
      }
    }

    print('>>> $moduleName | PHONE PROVIDER NOT FOUND');
    return false;
  }

  bool isAnonymousUser() {
    if (_auth.currentUser == null) return false;

    return _auth.currentUser!.isAnonymous;
  }

  void toggleLoginMode() {
    _isLoginMode.value = !_isLoginMode.value;
  }

  Future<AuthResult> signInAnonymously() async {
    try {
      final userCredential = await _auth.signInAnonymously();
      return AuthResult(code: ServerResultCode.ok);
    } on FirebaseAuthException catch (e) {
      print('Firebase SignInAnonymous Error :  ${e.code} - ${e.message}');

      return AuthResult(
        code: e.code,
        message: e.message,
      );
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);

      return AuthResult(
        code: ServerErrorCode.authLoginFailed,
        message: 'Unknown error',
      );
    }
  }

  Future<AuthResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _isLoading.value = true;

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _isLoading.value = false;

      final authUser = AuthUser.fromFirebase(userCredential.user);
      _authUser.value = authUser;

      return AuthResult(code: ServerResultCode.ok);
    } on FirebaseAuthException catch (e) {
      _isLoading.value = false;

      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          return AuthResult(
            code: ServerErrorCode.authLoginFailed,
            message: 'Your email and password combination do not match!',
          );
      }

      return AuthResult(
        code: e.code,
        message: e.message,
      );
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);

      _isLoading.value = false;

      return AuthResult(
        code: ServerErrorCode.authLoginFailed,
        message: 'Unknown error',
      );
    }
  }

  Future<AuthResult> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    _isLoading.value = true;

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      await user?.sendEmailVerification();

      _isLoading.value = false;

      return AuthResult(code: ServerResultCode.ok);
    } on FirebaseAuthException catch (e) {
      _isLoading.value = false;

      String code = '';
      String? message = '';

      switch (e.code) {
        case 'weak-password':
          code = ServerErrorCode.authRegisterFailed;
          message = 'The password provided is too weak';
          break;
        case 'email-already-in-use':
          code = ServerErrorCode.authRegisterFailed;
          message = 'This account already exists';
          break;
        default:
          code = e.code;
          message = e.message;
          break;
      }

      return AuthResult(
        code: code,
        message: message,
      );
    } catch (e, s) {
      // print in the logs the unknown errors
      print(e);
      print(s);

      _isLoading.value = false;

      return AuthResult(
        code: ServerErrorCode.authRegisterFailed,
        message: 'Unknown error',
      );
    }
  }

  Future<void> signOut() async {
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();

    // FacebookAuth.instance.logOut();

    await _auth.signOut();
  }
}
