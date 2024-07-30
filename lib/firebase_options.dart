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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDD6lFQa7i59PxmR59dhvpxp7mTBYB1d4w',
    appId: '1:847652994345:web:2f507e891b8ba110c58b38',
    messagingSenderId: '847652994345',
    projectId: 'pocket-of-peace',
    authDomain: 'pocket-of-peace.firebaseapp.com',
    storageBucket: 'pocket-of-peace.appspot.com',
    measurementId: 'G-JSV7BQBXHR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCLUVUZ2FGc4HcAiXN9ZZ2P8hc7YcBGDyU',
    appId: '1:847652994345:android:499106094898bf2ec58b38',
    messagingSenderId: '847652994345',
    projectId: 'pocket-of-peace',
    storageBucket: 'pocket-of-peace.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4bao2qhyQW0bZ8C5TZUzXc353k04SZrE',
    appId: '1:847652994345:ios:73bab13fb277fc57c58b38',
    messagingSenderId: '847652994345',
    projectId: 'pocket-of-peace',
    storageBucket: 'pocket-of-peace.appspot.com',
    iosBundleId: 'com.example.pocketOfPeace',
  );
}
