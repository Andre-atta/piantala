import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/data/services/fcm_service.dart';

class _FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {
  Map<String, dynamic>? lastData;
  SetOptions? lastOptions;

  @override
  Future<void> set(Map<String, dynamic> data, [SetOptions? options]) async {
    lastData = data;
    lastOptions = options;
  }
}

class _FakeFirestore extends Fake implements FirebaseFirestore {
  final Map<String, _FakeDocumentReference> docs = {};

  _FakeDocumentReference docRef(String path) =>
      docs.putIfAbsent(path, _FakeDocumentReference.new);

  @override
  DocumentReference<Map<String, dynamic>> doc(String path) => docRef(path);
}

class _FakeNotificationSettings extends Fake implements NotificationSettings {}

class _FakeMessaging extends Fake implements FirebaseMessaging {
  bool deleteTokenCalled = false;
  String? tokenToReturn = 'fake-token-1234567890';
  bool permissionRequested = false;

  @override
  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carBadge = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
    bool providesAppNotificationSettings = false,
    bool carPlay = false,
  }) async {
    permissionRequested = true;
    return _FakeNotificationSettings();
  }

  @override
  Future<String?> getToken({String? vapidKey}) async => tokenToReturn;

  @override
  Future<void> deleteToken() async {
    deleteTokenCalled = true;
  }

  @override
  Stream<String> get onTokenRefresh => const Stream.empty();
}

class _BadFirestore extends Fake implements FirebaseFirestore {
  @override
  DocumentReference<Map<String, dynamic>> doc(String path) => _BadDocRef();
}

class _BadDocRef extends Fake
    implements DocumentReference<Map<String, dynamic>> {
  @override
  Future<void> set(Object data, [SetOptions? options]) async {
    throw Exception('Firestore error simulato');
  }
}

void main() {
  group('FcmService user token management', () {
    test(
        'utente A accede, token salvato in users/A; clearForSignOut rimuove fcmToken e azzera tokenUid; utente B accede e token salvato in users/B',
        () async {
      String? currentUid = 'user_A';
      final fakeFirestore = _FakeFirestore();
      final fakeMessaging = _FakeMessaging();

      final service = FcmService.forTesting(
        messaging: fakeMessaging,
        firestore: fakeFirestore,
        currentUidProvider: () => currentUid,
      );

      // 1. Utente A accede: token salvato in users/user_A
      await service.init();
      expect(service.tokenUid, 'user_A');
      final docA = fakeFirestore.docs['users/user_A'];
      expect(docA, isNotNull);
      expect(docA!.lastData?['fcmToken'], 'fake-token-1234567890');
      expect(docA.lastData?['fcmTokenUpdatedAt'], isNotNull);

      // 2. clearForSignOut(): fcmToken rimosso da users/A, deleteToken chiamato, _tokenUid azzerato
      await service.clearForSignOut();
      expect(service.tokenUid, isNull);
      expect(fakeMessaging.deleteTokenCalled, isTrue);
      expect(docA.lastData?['fcmToken'], FieldValue.delete());
      expect(docA.lastData?['fcmTokenUpdatedAt'], FieldValue.delete());

      // 3. Utente B accede nella stessa sessione: init() salva un token in users/B (non viene saltato)
      currentUid = 'user_B';
      fakeMessaging.tokenToReturn = 'fake-token-user-b';
      fakeMessaging.deleteTokenCalled = false;

      await service.init();
      expect(service.tokenUid, 'user_B');
      final docB = fakeFirestore.docs['users/user_B'];
      expect(docB, isNotNull);
      expect(docB!.lastData?['fcmToken'], 'fake-token-user-b');
      expect(docB.lastData?['fcmTokenUpdatedAt'], isNotNull);
    });

    test('se Firestore lancia un errore, clearForSignOut non lancia', () async {
      final fakeMessaging = _FakeMessaging();
      final badFirestore = _BadFirestore();

      final service = FcmService.forTesting(
        messaging: fakeMessaging,
        firestore: badFirestore,
        currentUidProvider: () => 'user_error',
      );

      await expectLater(service.clearForSignOut(), completes);
      expect(service.tokenUid, isNull);
      expect(fakeMessaging.deleteTokenCalled, isTrue);
    });
  });
}
