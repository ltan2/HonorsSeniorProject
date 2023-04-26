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
    apiKey: 'AIzaSyDJS6px6BBiZqdQ--wzgipNvwhpG4-XjvQ',
    appId: '1:1028345346431:web:79e89a634ac9f98094c24a',
    messagingSenderId: '1028345346431',
    projectId: 'menta-dev',
    authDomain: 'menta-dev.firebaseapp.com',
    storageBucket: 'menta-dev.appspot.com',
    measurementId: 'G-4SLFVM9T32',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAi9zYCwNLJJGJXU0w63-Vi74BQ6BXcqvw',
    appId: '1:1028345346431:android:e7cb52dfb93ee1ef94c24a',
    messagingSenderId: '1028345346431',
    projectId: 'menta-dev',
    storageBucket: 'menta-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCw--JLb053XtfwnNT4v_z2STIsaY5bc8M',
    appId: '1:1028345346431:ios:b16e01cf394c0af094c24a',
    messagingSenderId: '1028345346431',
    projectId: 'menta-dev',
    storageBucket: 'menta-dev.appspot.com',
    androidClientId: '1028345346431-4lkqgiql2gabfv7upnkaf910e6fpdniq.apps.googleusercontent.com',
    iosClientId: '1028345346431-nq9rf96o0u9bt64aoa9v7k8mkh8qgltt.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCw--JLb053XtfwnNT4v_z2STIsaY5bc8M',
    appId: '1:1028345346431:ios:b16e01cf394c0af094c24a',
    messagingSenderId: '1028345346431',
    projectId: 'menta-dev',
    storageBucket: 'menta-dev.appspot.com',
    androidClientId: '1028345346431-4lkqgiql2gabfv7upnkaf910e6fpdniq.apps.googleusercontent.com',
    iosClientId: '1028345346431-nq9rf96o0u9bt64aoa9v7k8mkh8qgltt.apps.googleusercontent.com',
    iosBundleId: 'com.example.mobileApp',
  );
}
