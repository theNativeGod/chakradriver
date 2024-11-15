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
    apiKey: 'AIzaSyCXOWdiZiRpMifV__GmFt3TEbmHDCFnCdc',
    appId: '1:536327249347:web:2294adac904e2b47737176',
    messagingSenderId: '536327249347',
    projectId: 'cakra-temp',
    authDomain: 'cakra-temp.firebaseapp.com',
    storageBucket: 'cakra-temp.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCQqsp0zYScI67d3-HApA9jrKwCNix3OOA',
    appId: '1:536327249347:android:ec77a622ce006a50737176',
    messagingSenderId: '536327249347',
    projectId: 'cakra-temp',
    storageBucket: 'cakra-temp.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxxzfCmK8cTbTPPH_IzvU9hT58w_dgBpI',
    appId: '1:536327249347:ios:715d0fd2e6831571737176',
    messagingSenderId: '536327249347',
    projectId: 'cakra-temp',
    storageBucket: 'cakra-temp.firebasestorage.app',
    iosBundleId: 'com.example.chakracabsrider',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCxxzfCmK8cTbTPPH_IzvU9hT58w_dgBpI',
    appId: '1:536327249347:ios:715d0fd2e6831571737176',
    messagingSenderId: '536327249347',
    projectId: 'cakra-temp',
    storageBucket: 'cakra-temp.firebasestorage.app',
    iosBundleId: 'com.example.chakracabsrider',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCXOWdiZiRpMifV__GmFt3TEbmHDCFnCdc',
    appId: '1:536327249347:web:929e4e34f87668b1737176',
    messagingSenderId: '536327249347',
    projectId: 'cakra-temp',
    authDomain: 'cakra-temp.firebaseapp.com',
    storageBucket: 'cakra-temp.firebasestorage.app',
  );
}
