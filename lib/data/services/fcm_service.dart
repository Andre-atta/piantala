import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

/// Gestisce il token FCM e i messaggi in background.
/// Init dopo Firebase.initializeApp() e dopo il login.
class FcmService {
  FcmService._()
      : _messaging = FirebaseMessaging.instance,
        _firestore = FirebaseFirestore.instance,
        _currentUidProvider = null;

  /// Costruttore per i test: inietta dipendenze false senza Firebase vero.
  @visibleForTesting
  FcmService.forTesting({
    required FirebaseMessaging messaging,
    required FirebaseFirestore firestore,
    String? Function()? currentUidProvider,
  })  : _messaging = messaging,
        _firestore = firestore,
        _currentUidProvider = currentUidProvider;

  static final FcmService instance = FcmService._();

  final FirebaseMessaging _messaging;
  final FirebaseFirestore _firestore;
  final String? Function()? _currentUidProvider;

  String? get _currentUid =>
      _currentUidProvider != null
          ? _currentUidProvider()
          : FirebaseAuth.instance.currentUser?.uid;

  /// Da chiamare dopo il login per registrare/aggiornare il token.
  String? _tokenUid;
  bool _listenersAttached = false;

  @visibleForTesting
  String? get tokenUid => _tokenUid;

  Future<void> init() async {
    final uid = _currentUid;
    if (uid == null || _tokenUid == uid) return;
    _tokenUid = uid;
    try {
      if (!_listenersAttached) {
        _listenersAttached = true;
        await _messaging.requestPermission();
        _messaging.onTokenRefresh.listen(_onTokenRefresh);
        _attachMessageHandlers();
      }
      await _saveToken();
    } catch (e, st) {
      _tokenUid = null; // riprova al prossimo giro
      debugPrint('FcmService: init fallito → $e\n$st');
    }
  }

  void _attachMessageHandlers() {
    try {
      FirebaseMessaging.onMessage.listen(_onForegroundMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
      _messaging.getInitialMessage().then((initial) {
        if (initial != null) _handleMessage(initial);
      }).ignore();
    } catch (e) {
      debugPrint('FcmService: background/foreground handlers not attached: $e');
    }
  }

  Future<void> _saveToken() async {
    final uid = _currentUid;
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

  /// Rimuove il token FCM dal documento Firestore dell'utente corrente
  /// e lo invalida localmente. Va chiamato PRIMA del logout mentre l'utente
  /// è ancora autenticato. Qualunque errore viene solo loggato: il logout
  /// non deve mai fallire per questa pulizia.
  Future<void> clearForSignOut() async {
    final uid = _currentUid;
    _tokenUid = null; // azzera subito così il prossimo init() non salta
    if (uid == null) {
      try {
        await _messaging.deleteToken();
      } catch (e) {
        debugPrint('FcmService: errore deleteToken → $e');
      }
      return;
    }
    try {
      await _firestore.doc('users/$uid').set(
        {
          'fcmToken': FieldValue.delete(),
          'fcmTokenUpdatedAt': FieldValue.delete(),
        },
        SetOptions(merge: true),
      );
    } catch (e) {
      debugPrint('FcmService: errore rimozione token Firestore → $e');
    }
    try {
      await _messaging.deleteToken();
    } catch (e) {
      debugPrint('FcmService: errore deleteToken → $e');
    }
  }
}

/// Handler globale per i messaggi FCM in background (top-level, isolate sep.)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('FCM background message: ${message.messageId}');
}
