import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/app.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/services/fcm_service.dart';
import 'package:piantala/data/services/notification_service.dart';
import 'package:piantala/data/services/sync_service.dart';
import 'package:piantala/firebase_options.dart'; // generato da flutterfire configure

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  // 1. Inizializza Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 1.b Inizializza Firebase App Check (DebugProvider in debug, PlayIntegrity in release)
  await FirebaseAppCheck.instance.activate(
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );

  // 2. Registra handler FCM in background (deve essere top-level)
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // 3. Inizializza Isar (database locale)
  await IsarService.instance.initialize();

  // 4. Inizializza NotificationService (canali + plugin)
  await NotificationService.instance.initialize();

  // 5. Avvia SyncService
  SyncService.instance.startListening();

  // 6. Avvia l'app con ProviderScope (Riverpod)
  runApp(
    const ProviderScope(
      child: PiantalaApp(),
    ),
  );
}
