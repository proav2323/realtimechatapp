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
    apiKey: 'AIzaSyAHtwLOet0wscGXSMFu87m7PTBexyKxxjA',
    appId: '1:915369937393:web:025888165193142a14dc50',
    messagingSenderId: '915369937393',
    projectId: 'realtimechatapp-57160',
    authDomain: 'realtimechatapp-57160.firebaseapp.com',
    storageBucket: 'realtimechatapp-57160.appspot.com',
    measurementId: 'G-MMCL00LR9L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDcznUH1M7VLUllXWh1KS9pqnenQmIvC_M',
    appId: '1:915369937393:android:fa93db1b8587e89614dc50',
    messagingSenderId: '915369937393',
    projectId: 'realtimechatapp-57160',
    storageBucket: 'realtimechatapp-57160.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBPHZT1vjUIijvlUliWFcuD9Hn_v9DJWEM',
    appId: '1:915369937393:ios:29d66eb6b07af02e14dc50',
    messagingSenderId: '915369937393',
    projectId: 'realtimechatapp-57160',
    storageBucket: 'realtimechatapp-57160.appspot.com',
    iosBundleId: 'com.example.realtimechatapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBPHZT1vjUIijvlUliWFcuD9Hn_v9DJWEM',
    appId: '1:915369937393:ios:e83d4dec81b59d1a14dc50',
    messagingSenderId: '915369937393',
    projectId: 'realtimechatapp-57160',
    storageBucket: 'realtimechatapp-57160.appspot.com',
    iosBundleId: 'com.example.realtimechatapp.RunnerTests',
  );
}
