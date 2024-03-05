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
    apiKey: 'AIzaSyBLqwzqO-HtjVltDhsrgmfwr-mdAf6Fy38',
    appId: '1:512768135510:web:24e057229406d62fe486f7',
    messagingSenderId: '512768135510',
    projectId: 'test1-a2b27',
    authDomain: 'test1-a2b27.firebaseapp.com',
    storageBucket: 'test1-a2b27.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3NPYV2BxcG-Qixgzsfw4SbvFbl34ahmU',
    appId: '1:512768135510:android:74bb3705e4df4281e486f7',
    messagingSenderId: '512768135510',
    projectId: 'test1-a2b27',
    storageBucket: 'test1-a2b27.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmRCQz5YQvrfBGcwfc1dMeIlQZ_UIohIM',
    appId: '1:512768135510:ios:5dc06ad2dfeb5a4de486f7',
    messagingSenderId: '512768135510',
    projectId: 'test1-a2b27',
    storageBucket: 'test1-a2b27.appspot.com',
    iosBundleId: 'com.example.firebasePractise',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmRCQz5YQvrfBGcwfc1dMeIlQZ_UIohIM',
    appId: '1:512768135510:ios:6040f2331da6ded4e486f7',
    messagingSenderId: '512768135510',
    projectId: 'test1-a2b27',
    storageBucket: 'test1-a2b27.appspot.com',
    iosBundleId: 'com.example.firebasePractise.RunnerTests',
  );
}
