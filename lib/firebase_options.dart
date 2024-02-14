// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB4CE3s6GptDbZw_2Obl2DxII-cjHIYCRM',
    appId: '1:639741405112:web:eaaa87ff0bcfab9d45914d',
    messagingSenderId: '639741405112',
    projectId: 'edutech-7f5be',
    authDomain: 'edutech-7f5be.firebaseapp.com',
    storageBucket: 'edutech-7f5be.appspot.com',
    measurementId: 'G-MMB3657BWC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWk432lc1qbkNGf54FfpAZE2Ig_WVtXK4',
    appId: '1:639741405112:android:5e157d8185f2e02445914d',
    messagingSenderId: '639741405112',
    projectId: 'edutech-7f5be',
    storageBucket: 'edutech-7f5be.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8xxgQbjmijSbu1YMJiZeJRfHF5nXVwKM',
    appId: '1:639741405112:ios:1b023b68ba031cbf45914d',
    messagingSenderId: '639741405112',
    projectId: 'edutech-7f5be',
    storageBucket: 'edutech-7f5be.appspot.com',
    iosBundleId: 'com.example.edutech',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8xxgQbjmijSbu1YMJiZeJRfHF5nXVwKM',
    appId: '1:639741405112:ios:affc4556b526ec6645914d',
    messagingSenderId: '639741405112',
    projectId: 'edutech-7f5be',
    storageBucket: 'edutech-7f5be.appspot.com',
    iosBundleId: 'com.example.edutech.RunnerTests',
  );
}
