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
    apiKey: 'AIzaSyCAv-DSiAImImaC3q2cKG0ViOPQ1aen4rE',
    appId: '1:236951349015:web:41227a3c78d38056baf952',
    messagingSenderId: '236951349015',
    projectId: 'vruksha-de997',
    authDomain: 'vruksha-de997.firebaseapp.com',
    storageBucket: 'vruksha-de997.appspot.com',
    measurementId: 'G-BSLZHP5463',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBkrzRxSJCkZGwVI7AelzhiKrDUqbDQ1a4',
    appId: '1:236951349015:android:27386aa2e5bc118abaf952',
    messagingSenderId: '236951349015',
    projectId: 'vruksha-de997',
    storageBucket: 'vruksha-de997.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAkAEwHDYuJqp2MlX02FBHdqh1TC5loQ-I',
    appId: '1:236951349015:ios:3522af18efaad088baf952',
    messagingSenderId: '236951349015',
    projectId: 'vruksha-de997',
    storageBucket: 'vruksha-de997.appspot.com',
    androidClientId: '236951349015-3rjuq5j7is7o1skda7qohdplgl8gcc7l.apps.googleusercontent.com',
    iosClientId: '236951349015-qa3vcdikhrt2eb8sdkvra9sqf02rdh18.apps.googleusercontent.com',
    iosBundleId: 'com.example.vruksha',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAkAEwHDYuJqp2MlX02FBHdqh1TC5loQ-I',
    appId: '1:236951349015:ios:275f4590ea3e46a8baf952',
    messagingSenderId: '236951349015',
    projectId: 'vruksha-de997',
    storageBucket: 'vruksha-de997.appspot.com',
    androidClientId: '236951349015-3rjuq5j7is7o1skda7qohdplgl8gcc7l.apps.googleusercontent.com',
    iosClientId: '236951349015-nrk69b1gpso9hmac89o48utl9jl7pq1q.apps.googleusercontent.com',
    iosBundleId: 'com.example.vruksha.RunnerTests',
  );
}
