// Generato da firebase_options.dart — valori da google-services.json
// Questo file VA committato. google-services.json NON va committato.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions non configurate per web.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions non configurate per questa piattaforma.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCmEdOcXZDR32ad7wnXZ10FvzRBRGwk6kI',
    appId: '1:242621480843:android:4dc5b9a81e5ff38934f98e',
    messagingSenderId: '242621480843',
    projectId: 'piantala-3e61e',
    storageBucket: 'piantala-3e61e.firebasestorage.app',
  );
}
