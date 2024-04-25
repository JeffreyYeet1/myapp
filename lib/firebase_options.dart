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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYDO7IdPjsoWpT-c_LNaBsbq1qNMVomUc',
    appId: '1:80377537058:android:59316e77a8038c947c607b',
    messagingSenderId: '80377537058',
    projectId: 'quizapp-19bb3',
    storageBucket: 'quizapp-19bb3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAvWKKGr6YatgWa0U2FlmTnx6K4zRkxDnM',
    appId: '1:80377537058:ios:334ab43c1bb855f07c607b',
    messagingSenderId: '80377537058',
    projectId: 'quizapp-19bb3',
    storageBucket: 'quizapp-19bb3.appspot.com',
    iosBundleId: 'io.fireship.quizapp.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAvWKKGr6YatgWa0U2FlmTnx6K4zRkxDnM',
    appId: '1:80377537058:ios:9f30dc3729d5cff47c607b',
    messagingSenderId: '80377537058',
    projectId: 'quizapp-19bb3',
    storageBucket: 'quizapp-19bb3.appspot.com',
    iosBundleId: 'io.fireship.quizapp.myapp.RunnerTests',
  );
}
