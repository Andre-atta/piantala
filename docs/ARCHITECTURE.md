# Piantala — Architettura (come girano i dati)

Documento per gli agenti e per chi studia il progetto. Le regole operative restano in `AGENT.md`; lo schema dei dati in `docs/DATABASE_SCHEMA.md`; i provider in `docs/PROVIDERS.md`. Questo file spiega il quadro e il perché. Se il codice cambia, si aggiorna anche questo file nella stessa PR.

## 1. I livelli (dall'alto in basso)

| Livello | Cartella | Cosa contiene | Può dipendere da |
|---|---|---|---|
| Presentazione | `lib/presentation/` | schermate, widget di carta, provider Riverpod | dominio |
| Dominio | `lib/domain/` | entity `freezed` (immutabili), interfacce dei repository (`i_*_repository.dart`), use case | niente (né Flutter né Firebase) |
| Dati | `lib/data/` | repository concreti, collection Isar, servizi (sync, notifiche, FCM, OpenPlantBook) | dominio |
| Nucleo | `lib/core/` | tema, token, costanti, utilità pure (`scheduling_engine`, `watering_heuristic`) | niente |

Regola: la presentazione non importa mai nulla da `lib/data/`, tranne i file dei provider che costruiscono i repository.

## 2. Gli oggetti dei dati: uno per livello, mai di più

- **Dominio:** `PlantEntity`, `RoomEntity`, `UserEntity` (+ entity di configurazione). Sono quelli che la UI usa.
- **Dati locali:** `PlantCollection`, `RoomCollection`, `SpeciesCacheCollection`, `PendingOperationCollection` (Isar, in `lib/data/local/collections/`). Fanno da «model» e hanno `toEntity()`.
- **Non esiste uno strato `*Model`.** `PlantModel`, `RoomModel` e `UserModel` NON si creano: sarebbero un terzo schema per lo stesso dato. Un agente che sente il bisogno di un nuovo livello deve fermarsi e chiedere.
- **Utente:** nome, email e foto vengono solo da Firebase Auth (`AuthRepositoryImpl._mapFirebaseUser` → `UserEntity`). Su Firestore, in `users/{uid}`, restano impostazioni e token FCM. Il livello `tier` (`free`/`pro`) si aggiunge in futuro con un profilo letto da Firestore (Prompt 9, Blocco A-bis) e si scrive solo dal server.

## 3. Il flusso di una pianta (offline-first)

Lettura:
`Schermata` → `plantsProvider` (`Stream<List<PlantEntity>>`, `presentation/providers/plant_providers.dart`) → `PlantRepositoryImpl.watchPlants()` → query Isar filtrata per `userId` → `PlantCollection.toEntity()` → la UI si ridisegna a ogni cambio di Isar.

Scrittura (aggiungi, modifica, elimina):
1. Il provider chiama il repository (`addPlant`, `updatePlant`, `deletePlant`).
2. In UNA transazione Isar: salva la collection con `syncStatus` (`pendingCreate`, `pendingUpdate`, `pendingDelete`) e crea una `PendingOperationCollection`.
3. `SyncService` (`data/services/sync_service.dart`) vede la nuova operazione (`watchLazy`) e la invia a Firestore (`users/{uid}/plants`, `users/{uid}/rooms`); quando riesce, marca il record come sincronizzato e cancella l'operazione.
4. Nel verso opposto, `SyncService` ascolta Firestore (`snapshots()`) e aggiorna Isar, saltando i documenti con operazioni locali ancora in attesa.

La UI non parla mai con Firestore. Senza rete l'app funziona con Isar e la coda si svuota al ritorno della rete.

Punti deboli noti: due sistemi di sincronizzazione sovrapposti (la cache offline di Firestore e la nostra coda); gestione dei conflitti tra due telefoni da verificare; Isar 3 non è più mantenuto (`docs/ISAR_ALTERNATIVES.md`). Il confine per un futuro cambio di database sono le interfacce in `domain/repositories`.

## 4. Avvio dell'app (`lib/main.dart`, in ordine)

Firebase → App Check (debug in debug, Play Integrity in release) → handler FCM in background → Isar → `NotificationService.initialize()` → `SyncService.startListening()` → `ProviderScope` → `PiantalaApp` (`app.dart`, rotte in `router.dart`).

## 5. Utente e accesso

`authStateProvider` → `currentUserProvider` → UI e router (`router.dart` reindirizza al login). La lettura di Firestore non deve mai bloccare l'accesso: se fallisce, l'utente resta dentro con i valori predefiniti.

## 6. Notifiche locali

`notificationsSyncController` (`providers/notification_providers.dart`) osserva `plantsProvider`, `plantScheduleProvider` e l'orario del promemoria (`ReminderHour`/`ReminderMinute`, salvati in `SharedPreferences`). A ogni cambio chiama `NotificationService.syncAllNotificationsFromSchedule`, che programma:
- un promemoria giornaliero (id 0–13, 14 giorni) alle `hour:minute` scelte;
- una notifica «urgente» per pianta, due giorni dopo la scadenza, alle 10:00 (id = `plantNotifId`).
Programmazione `inexactAllowWhileIdle`: Android può ritardarle di qualche minuto. Il tocco su una notifica di pianta apre la pianta (`onNotificationTap` in `router.dart`).
Da correggere (bug noto, 28 nov): il promemoria giornaliero conta solo le piante con scadenza in QUEL giorno, quindi quelle già scadute non lo fanno partire; inoltre `notificationsSyncController` esce in silenzio se una pianta non ha ancora un calendario.

## 7. Server (Firebase)

Cloud Functions in `functions/src/` (proxy OpenPlantBook con cache e quota: `opb_quota_manager.ts`, `opb_token_manager.ts`); `firestore.rules` e `storage.rules` con test in `tool/rules-test/`. Le chiavi non sono mai nel client. Le rules sono additive (OR tra i `match` che combaciano): ogni scrittura consentita elenca i campi ammessi.

## 8. Come studiare il progetto (percorso consigliato)

1. Parti da `main.dart` e segui l'avvio (§4).
2. Apri `home_screen.dart`, trova dove legge `plantsProvider`, poi apri `plant_providers.dart` e `plant_repository_impl.dart`.
3. Metti un punto di interruzione in `addPlant` e aggiungi una pianta: guarda la transazione Isar e la riga in `PendingOperationCollection`.
4. Apri `sync_service.dart` e segui `_drainQueue` fino a `_processOperation`.
5. Prova la modalità aereo (modifica una pianta senza rete, riaccendi la rete, guarda Firestore).

## 9. Regole per gli agenti (riassunto; il testo completo è in `AGENT.md`)

- Nessun nuovo livello, modello o cartella senza approvazione scritta di Andrea.
- Un solo oggetto per dato per livello (§2).
- La UI legge i dati solo tramite provider Riverpod; scrive solo tramite repository.
- Nessun colore o numero scritto a mano nei widget: token del tema e classi `*Metrics`.
- Se serve un pacchetto nuovo, fermarsi e proporlo.
- Ogni modifica che cambia flusso o schema aggiorna questo file e `docs/DATABASE_SCHEMA.md`.
