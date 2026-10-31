import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Gestisce il token FCM e i messaggi in background.
/// Init dopo Firebase.initializeApp() e dopo il login.
class FcmService {
  FcmService._();
  static final FcmService instance = FcmService._();

  final _messaging = FirebaseMessaging.instance;
  final _firestore = FirebaseFirestore.instance;

  bool _isInitialized = false;

  /// Da chiamare dopo il login per registrare/aggiornare il token.
  Future<void> init() async {
    if (_isInitialized) return;
    _isInitialized = true;

    // Richiesta permessi FCM su iOS (su Android API < 33 già garantiti)
    await _messaging.requestPermission();

    // Salva il token corrente
    await _saveToken();

    // Aggiorna il token se viene ruotato da Firebase
    _messaging.onTokenRefresh.listen(_onTokenRefresh);

    // Handler messaggi in foreground (mostriamo la notifica manualmente
    // tramite flutter_local_notifications — FCM in foreground non la mostra)
    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    // Handler per apertura app da notifica FCM in background/terminato
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

    // Controlla se l'app è stata aperta da una notifica terminata
    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      _handleMessage(initial);
    }
  }

  Future<void> _saveToken() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      final token = await _messaging.getToken();
      if (token == null) return;

      await _firestore.doc('users/$uid').set(
        {'fcmToken': token, 'fcmTokenUpdatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
      debugPrint('FcmService: token salvato → $token');
    } catch (e) {
      debugPrint('FcmService: errore salvataggio token → $e');
    }
  }

  Future<void> _onTokenRefresh(String token) async {
    debugPrint('FcmService: token aggiornato → $token');
    await _saveToken();
  }

  void _onForegroundMessage(RemoteMessage message) {
    // In foreground FCM non mostra la notifica di sistema; la gestiamo qui
    // se necessario. Per ora logghiamo solo.
    debugPrint(
      'FcmService foreground message: ${message.notification?.title}',
    );
  }

  void _onMessageOpenedApp(RemoteMessage message) {
    _handleMessage(message);
  }

  void _handleMessage(RemoteMessage message) {
    final plantId = message.data['plantId'] as String?;
    debugPrint('FcmService: apertura da notifica, plantId=$plantId');
    // Il deep link viene gestito dal router al primo build — qui
    // potremmo aggiungere navigazione imperativa se necessario.
  }
}

/// Handler globale per i messaggi FCM in background (top-level, isolate sep.)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM background message: ${message.messageId}');
}
