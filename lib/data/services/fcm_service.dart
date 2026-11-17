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

  /// Da chiamare dopo il login per registrare/aggiornare il token.
  String? _tokenUid;
  bool _listenersAttached = false;

  Future<void> init() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null || _tokenUid == uid) return;
    _tokenUid = uid;
    try {
      if (!_listenersAttached) {
        _listenersAttached = true;
        await _messaging.requestPermission();
        _messaging.onTokenRefresh.listen(_onTokenRefresh);
        FirebaseMessaging.onMessage.listen(_onForegroundMessage);
        FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
        final initial = await _messaging.getInitialMessage();
        if (initial != null) _handleMessage(initial);
      }
      await _saveToken();
    } catch (e, st) {
      _tokenUid = null; // riprova al prossimo giro
      debugPrint('FcmService: init fallito → $e\n$st');
    }
  }

  Future<void> _saveToken() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    try {
      debugPrint('FcmService: getToken...');
      final token = await _messaging.getToken();
      debugPrint('FcmService: token = ${token == null ? "null" : "ok"}');
      if (token == null) return;

      await _firestore.doc('users/$uid').set(
        {'fcmToken': token, 'fcmTokenUpdatedAt': FieldValue.serverTimestamp()},
        SetOptions(merge: true),
      );
      // FIX A-04: mascherare il token FCM nei log per sicurezza
      debugPrint(
        'FcmService: token salvato → ${token.substring(0, 10)}...[MASKED]',
      );
    } catch (e) {
      debugPrint('FcmService: errore salvataggio token → $e');
    }
  }

  Future<void> _onTokenRefresh(String token) async {
    // FIX A-04: mascherare il token FCM nei log per sicurezza
    debugPrint(
      'FcmService: token aggiornato → ${token.substring(0, 10)}...[MASKED]',
    );
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
