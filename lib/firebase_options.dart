// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCKPRmGUsgwjeuKF72rO2Y3A2FB-lxBs-g',
    appId: '1:321048273351:web:f6a72abd5688da8e14f9e2',
    messagingSenderId: '321048273351',
    projectId: 'social-algorithms-166c7',
    authDomain: 'social-algorithms-166c7.firebaseapp.com',
    storageBucket: 'social-algorithms-166c7.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCPEfh8yMz-rtsCbHktfOXA1QGy2wg2IfE',
    appId: '1:321048273351:android:c19642eb23d8a74b14f9e2',
    messagingSenderId: '321048273351',
    projectId: 'social-algorithms-166c7',
    storageBucket: 'social-algorithms-166c7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBBF5q8fSl9xuuMmcl1-bNBzvRrQdRpvQ',
    appId: '1:321048273351:ios:93d659e9873acf9c14f9e2',
    messagingSenderId: '321048273351',
    projectId: 'social-algorithms-166c7',
    storageBucket: 'social-algorithms-166c7.firebasestorage.app',
    iosBundleId: 'com.example.findPros',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBBF5q8fSl9xuuMmcl1-bNBzvRrQdRpvQ',
    appId: '1:321048273351:ios:93d659e9873acf9c14f9e2',
    messagingSenderId: '321048273351',
    projectId: 'social-algorithms-166c7',
    storageBucket: 'social-algorithms-166c7.firebasestorage.app',
    iosBundleId: 'com.example.findPros',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCKPRmGUsgwjeuKF72rO2Y3A2FB-lxBs-g',
    appId: '1:321048273351:web:5d76c594bc06bcd814f9e2',
    messagingSenderId: '321048273351',
    projectId: 'social-algorithms-166c7',
    authDomain: 'social-algorithms-166c7.firebaseapp.com',
    storageBucket: 'social-algorithms-166c7.firebasestorage.app',
  );
}
