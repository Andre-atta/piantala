Procedo con un audit read-only completo: inventario delle definizioni e dei flussi, verifica della raggiungibilità dal router/UI, persistenza/sync e dipendenze/configurazione. Non eseguirò comandi che generano o modificano file.

# Report di audit read-only

## Sintesi esecutiva

L’ipotesi iniziale va corretta:

- **Idrocoltura non è codice morto**: è raggiungibile dalla UI di aggiunta/modifica pianta e modifica concretamente scheduling, card di dettaglio, notifiche e salvataggio.
- **`nextTopUpAt` e `nextFullChangeAt` sono invece residui**: vengono serializzati, copiati e sincronizzati, ma lo scheduler non li legge.
- **Irrigazione “ragionata” è ancora attiva**, soprattutto per il terreno: meteo, esposizione, frequenza da OpenPlantBook, correzione EMA e override manuale.
- **I log di irrigazione avanzati sono parzialmente implementati**: il modello e il form esistono, ma il form attuale aggiorna solo la pianta; non salva effettivamente un `WateringLogCollection`.
- **Diagnosi AI, salute e vivaio non sono raggiungibili dalla UI presente**. Esistono però collection Isar, schema generato, eccezioni e documentazione residue.
- **Non sono presenti repository/provider/schermate operative per diagnosi, salute o vivaio** nel codice Dart verificato.
- Le documentazioni `README.md`, `DATABASE_SCHEMA.md` e `PROVIDERS.md` descrivono molte funzionalità che il codice attuale non implementa più o non implementa completamente.

---

## 1. Inventario ordinato per rischio di rimozione

| Elemento | Layer | Definito in | Scritto da | Letto da | Raggiungibile dalla UI? | Verdetto | Note |
|---|---|---|---|---|---|---|---|
| `HydroConfigEntity` | Domain / Freezed | `lib/domain/entities/plant_entity.dart:145-185` | `AddPlantScreen`, `LogWateringBottomSheet`, mapper repository | `scheduling_providers.dart`, dettaglio pianta, notifiche indirette | **Sì** | **DECISIONE MIA** | Rappresenta ancora il ramo idro completo. |
| `HydroConfigIsar` | Isar embedded | `lib/data/local/collections/plant_collection.dart:112-128` | Mapper `plant_repository_impl.dart:306-319` | Mapper `plant_repository_impl.dart:322-335`, `SyncService` | **Sì**, tramite pianta hydro | **DECISIONE MIA** | Incluso nello schema generato `plant_collection.g.dart`. |
| `cultivationMethod` | Domain / Isar / Firestore | `plant_entity.dart:34`, `plant_collection.dart`, mapper | `AddPlantScreen`, `EditPlantDialog` | Shelf asset, dettaglio, form irrigazione, scheduling, notifiche | **Sì** | **DECISIONE MIA** | Serve attualmente anche per scegliere asset soil/water: `plant_shelf_view.dart:235,326`. |
| `hydroSubtype` | Domain / Isar / Firestore | `plant_entity.dart:149`, collection e mapper | Default in `AddPlantScreen` | `SchedulingEngine.nextHydroFullChange()` | **Sì**, quando si crea una pianta hydro | **RIMUOVERE se si elimina hydro** | Oggi distingue `passive` e `water_only`. |
| `reservoirVolumeMl` | Domain / Isar / Firestore | `plant_entity.dart:154` | Nessuna UI effettiva individuata | `SchedulingEngine.nextHydroFullChange()` | **Parzialmente** | **RIMUOVERE se si elimina hydro** | Persistito e usato dal calcolo, ma non emerge un controllo UI nel form corrente. |
| `containerTransparency` | Domain / Isar / Firestore | `plant_entity.dart:158-164` | Default e fallback in `AddPlantScreen`, `LogWateringBottomSheet` | `SchedulingEngine.nextHydroFullChange()` | **Sì**, ma senza scelta completa visibile | **RIMUOVERE se si elimina hydro** | Modifica la frequenza in caso di rischio alghe. |
| `topUpCountSinceLastChange` | Domain / Isar / Firestore | `plant_entity.dart:166`, collection | `LogWateringBottomSheet:371,381` | `SchedulingEngine:232-235` | **Sì**, attraverso il form hydro | **RIMUOVERE se si elimina hydro** | Dopo quattro rabbocchi forza il cambio completo. |
| `lastTopUpAt` / `lastFullChangeAt` | Domain / Isar / Firestore | `plant_entity.dart:169-172` | `LogWateringBottomSheet:369,379` | `scheduling_providers.dart:219,234` | **Sì** | **RIMUOVERE se si elimina hydro** | Sono le date realmente usate per ricalcolare le scadenze hydro. |
| `manualTopUpOverrideAt` / `manualChangeOverrideAt` | Domain / Isar / Firestore | `plant_entity.dart:178-181` | Vengono cancellati nel form; non è stata trovata UI che li imposti | `scheduling_providers.dart:215,229` | **Non pienamente** | **RIMUOVERE** oppure **DECISIONE MIA** | Il lettore esiste, ma il flusso di scrittura manuale non è stato trovato. |
| `nextTopUpAt` / `nextFullChangeAt` | Domain / Isar / Firestore | `plant_entity.dart:175-176`, collection | Form hydro li imposta a `null`; mapper li copia; sync li legge/scrive | Nessun calcolo li usa | **No, come comportamento** | **RIMUOVERE** | Residui della vecchia strategia di persistenza della prossima scadenza. |
| `SchedulingEngine` soil | Core | `lib/core/utils/scheduling_engine.dart:1-120` | Non scrive direttamente | `scheduling_providers.dart` | **Sì**, ogni schedule pianta | **TENERE / semplificare** | Calcola intervallo da frequenza, meteo ed esposizione. |
| `SchedulingEngine` feedback EMA | Core / Domain config | `scheduling_engine.dart:70-150` | Il controller feedback è commentato | Nessun chiamante attivo verificato | **No** | **RIMUOVERE** | `applyFeedback()` esiste, ma `WateringFeedbackController` è commentato. |
| `schedulingCorrectionFactor` | Domain / Isar / Freezed | `plant_entity.dart:85-93`, collection | Migrazione custom e mapper | `SchedulingEngine.nextSoilWatering()` | **Indirettamente** | **RIMUOVERE** se si elimina EMA | Il default viene normalizzato da `_migrateV1toV2`, ma non è più aggiornato dal controller commentato. |
| `pendingFeedbackCount` / `pendingFeedbackSign` | Domain / Isar | `plant_entity.dart:95-105`, collection | Migrazione custom | Solo `applyFeedback()` e mapper | **No** | **RIMUOVERE** | Stato senza flusso attivo che lo aggiorni. |
| `manualOverrideAt` / `manualOverrideDays` del watering config | Domain / Isar | `plant_entity.dart:108-115`, collection | `LogWateringBottomSheet` cancella l’override | `scheduling_providers.dart:189-191` | **Parzialmente** | **RIMUOVERE** oppure **DECISIONE MIA** | Il calcolo lo supporta, ma non è stata trovata UI attiva per impostarlo. |
| `methodPreference` | Domain / Isar / Firestore | `plant_entity.dart:78-83` | Add plant e fallback | Persistito; usato soprattutto come dato configurativo | **Sì**, ma non nel calcolo | **DECISIONE MIA** | Nel design target non serve per decidere quando notificare. |
| `watering_heuristic.dart` | Core | `lib/core/utils/watering_heuristic.dart:1-15` | Nessuno | Solo wrapper/compatibilità; il codice reale è in `SchedulingEngine` | No | **RIMUOVERE** dopo verifica chiamanti | È marcato `@Deprecated`. |
| `SchedulingConstants` soil | Core | `lib/core/utils/scheduling_constants.dart:1-100` | — | `SchedulingEngine` | **Sì** | **TENERE / semplificare** | Contiene la logica utile al design target. |
| `SchedulingConstants` hydro | Core | `scheduling_constants.dart:105-180` | — | `SchedulingEngine` hydro | **Sì** tramite pianta hydro | **RIMUOVERE se si elimina hydro** | Include frequenze, temperatura, volume, alghe e rabbocchi. |
| `PlantSchedulingInfo` | Presentation/service DTO | `scheduling_providers.dart:47-69` | `notification_providers.dart:91-103` | `NotificationService` | **Sì** via `PiantalaApp` | **Semplificare** | Il DTO espone due eventi hydro distinti. |
| Deduplicazione notifiche hydro | Notification service | `notification_service.dart:329-368` | — | Durante sincronizzazione notifiche | **Sì** se esiste una pianta hydro | **RIMUOVERE** | Distingue cambio completo, rabbocco e concimazione nello stesso giorno. |
| Testi “rabbocco/cambio acqua” | UI / notifiche | `watering_action_card.dart:117-129`, `notification_service.dart:330-368` | — | UI e notifiche | **Sì** | **RIMUOVERE se si unifica irrigazione** | Contraddicono il design target “decide l’utente”. |
| Form irrigazione hydro | Presentation | `log_watering_bottom_sheet.dart:212-304` | Stato locale; il salvataggio completo non è persistito come log | `_buildUpdatedPlant()` aggiorna `hydroConfig` | **Sì**, tramite WateringActionCard | **RIMUOVERE** | Include rabbocco/cambio, livello, EC, concime. |
| `WateringLogEntity` avanzato | Domain / Freezed | `watering_log_entity.dart:1-75` | Nessun flusso attivo individuato | Nessun provider/repository attivo individuato | **No** come persistenza | **RIMUOVERE o ridurre** | Il form aggiorna la pianta ma non crea un’entità log. |
| `WateringLogCollection` | Isar | `watering_log_collection.dart:1-70` | Nessun writer attivo trovato | `SyncService` contiene solo gestione generica per eventuali pending op | **No** | **RIMUOVERE o ridurre** | È registrata in Isar e ha schema generato. |
| `logType` | Watering log | `watering_log_entity.dart:22-31`, collection | Nessun writer attivo individuato | Nessun reader applicativo individuato | No | **RIMUOVERE** se si mantiene solo `lastWateredAt` | La documentazione lo presenta come discriminante soil/hydro. |
| `dayAdjustment` | Watering log / feedback | `watering_log_entity.dart:33-43` | Nessun writer attivo individuato | Solo logica feedback, non collegata | No | **RIMUOVERE** | Dipende dal controller feedback commentato. |
| `waterLevelPercent`, `ecMeasured`, `fertilizerAdded` | Watering log hydro | `watering_log_entity.dart:61-73`, collection | Stato UI; `_ecMeasuredText` non viene usato nel salvataggio | Nessun reader attivo | **UI sì, dati no** | **RIMUOVERE** | L’analisi segnala `_ecMeasuredText` come campo inutilizzato. |
| `method`, `amountMl`, `soilConditionBefore` | Watering log soil | `watering_log_entity.dart:47-59` | Il form raccoglie metodo, ma non lo salva in un log | Nessun reader attivo | **UI parziale** | **RIMUOVERE o ridurre** | Non servono al design minimo. |
| `soilConditionQuality` | Watering log / feedback | `watering_log_entity.dart:39-46`, collection | Form soil | Solo `applyFeedback()` | **Sì come input, no come effetto attivo** | **RIMUOVERE** | Il valore viene scelto ma non alimenta un controller attivo. |
| `DiagnosisCollection` | Isar | `diagnosis_collection.dart:1-39` | Nessun writer trovato | Nessun reader trovato | No | **RIMUOVERE** | Solo collection + `.g.dart`; nessun entity/repository/provider/schermata attiva. |
| `HealthLogCollection` | Isar | `health_log_collection.dart:1-40` | Nessun writer trovato | Nessun reader trovato | No | **RIMUOVERE** | Solo collection + `.g.dart`. |
| `NurseryCollection` | Isar | `nursery_collection.dart:1-55` | Nessun writer trovato | Nessun reader trovato | No | **RIMUOVERE** | Solo collection + `.g.dart`. |
| Route `clinic` / `nursery` | Router | `lib/router.dart:23-25` | — | Nessuna route registrata effettivamente | No | **RIMUOVERE** | Sono soltanto costanti; non esistono `GoRoute` corrispondenti. |
| `isInNursery` | Domain / Isar / notifiche | `plant_entity.dart:31`, mapper, `notification_providers.dart:82` | Nessun flusso nursery trovato | Esclusione da scheduling/notifiche | **No come gestione nursery** | **DECISIONE MIA** | Non è completamente morto: influenza la sincronizzazione delle notifiche. |
| `status` `propagating` | Domain/UI | `plant_entity.dart:17`, dettaglio | Default `healthy`; non trovato writer specifico | Visualizzato in `plant_detail_screen.dart:190` | **Sì come visualizzazione** | **DECISIONE MIA** | `status` è una decisione di prodotto, non va rimosso automaticamente. |
| Diagnosi Gemini / payload / chiave | Documentazione e residue dipendenze | `docs/PROVIDERS.md`, `app_exception.dart:36-52`, `pubspec.yaml:40` | Nessun codice operativo trovato | Nessun reader operativo trovato | No | **RIMUOVERE** | `flutter_secure_storage` non è importato nel Dart verificato. |
| Health/nursery/diagnosis Storage | Storage | Schema/documentazione | Nessun percorso operativo trovato | Nessun reader operativo trovato | No | **RIMUOVERE / pulire dati** | L’unico Storage attivo verificato riguarda foto delle piante in `AddPlantScreen` e cancellazione foto in `PlantRepositoryImpl`. |

---

## 2. Raggiungibilità reale dell’idrocoltura

L’idrocoltura è effettivamente attiva e raggiungibile:

1. `AddPlantScreen` espone la scelta `soil` / `hydro` (`add_plant_screen.dart:35,324-331`).
2. Quando si seleziona `hydro`, crea:
    - `cultivationMethod: 'hydro'`;
    - `HydroConfigEntity`;
    - una configurazione watering dedicata (`add_plant_screen.dart:109-184`).
3. `PlantDetailScreen` visualizza l’idrocoltura (`plant_detail_screen.dart:193-194`).
4. `WateringActionCard` cambia titolo, icona, frequenza e messaggio per hydro (`watering_action_card.dart:46-129`).
5. Il tap apre `LogWateringBottomSheet`, che mostra:
    - rabbocco;
    - cambio completo;
    - livello acqua;
    - EC;
    - concime (`log_watering_bottom_sheet.dart:212-304`).
6. Il salvataggio modifica `hydroConfig.lastTopUpAt`, `lastFullChangeAt`, `topUpCountSinceLastChange` e override (`log_watering_bottom_sheet.dart:357-385`).
7. `notificationsSyncController` osserva le piante e `plantScheduleProvider` (`notification_providers.dart:68-104`).
8. `plantScheduleProvider` calcola le due scadenze hydro con `SchedulingEngine` (`scheduling_providers.dart:212-256`).
9. `NotificationService` programma promemoria e notifiche urgenti separando rabbocco e cambio (`notification_service.dart:273-368`).

**Conclusione:** non è solo codice compilato ma morto. È un percorso UI completo, anche se la parte di log avanzato è incompleta.

---

## 3. Cosa è realmente morto nei blocchi A e B

### Blocco A

#### Attivo

- `cultivationMethod`
- `HydroConfigEntity` / `HydroConfigIsar`
- calcolo hydro in `SchedulingEngine`
- form hydro
- card e testi hydro
- notifiche hydro
- parte soil dello scheduling con meteo ed esposizione
- frequenza da OpenPlantBook tramite cache

#### Parzialmente attivo

- `manualOverrideAt` e override hydro: letti dal calcolo, ma non è stata trovata una UI attiva che li imposti.
- `WateringLogEntity` e `WateringLogCollection`: schema e modello esistono, ma il flusso utente non persiste il log.
- `soilConditionQuality`, `dayAdjustment`, `schedulingCorrectionFactor`: collegati a una logica di feedback, ma il controller è commentato.

#### Residuo

- `nextTopUpAt`
- `nextFullChangeAt`
- `watering_heuristic.dart`
- parti della migrazione che inizializzano il feedback EMA
- testi e documentazione che descrivono stick test e log completi ma non corrispondono al form attuale

### Blocco B

Nel codice Dart applicativo non risultano:

- repository diagnosi;
- entity diagnosi;
- provider diagnosi;
- schermate Clinic;
- servizio Gemini;
- payload builder operativo;
- repository health log;
- provider health log;
- schermate salute;
- repository nursery;
- provider nursery;
- schermate vivaio;
- gestione operativa delle fasi di propagazione.

Esistono però:

- tre collection Isar residue;
- relativi file generati;
- import e registrazione in `IsarService`;
- `isInNursery` nella pianta;
- eccezioni Gemini/nursery;
- documentazione obsoleta;
- costanti di route mai registrate.

---

## 4. Persistenza e sync

### Isar

`IsarService` registra ancora tutte le collection:

```text
isar_service.dart:44-49
isar_service.dart:67-72
```

Sono incluse:

- `DiagnosisCollectionSchema`
- `HealthLogCollectionSchema`
- `NurseryCollectionSchema`
- `WateringLogCollectionSchema`
- `PlantCollectionSchema`
- `PendingOperationCollectionSchema`

Nel codice:

- **non esiste `schemaVersion`**;
- **non esiste una `MigrationCallback`**;
- esiste soltanto una migrazione custom `_migrateV1toV2()` (`isar_service.dart:78-125`);
- tale migrazione aggiorna solo `logType` e i default del feedback EMA;
- non migra né rimuove `HydroConfig`, campi hydro o collection B.

La versione verificata è:

```text
isar 3.1.0+1
isar_flutter_libs 3.1.0+1
isar_generator 3.1.0+1
```

rispettivamente in `pubspec.yaml:26-28,72` e `pubspec.lock:952-974`.

**Non verificato:** il comportamento esatto di Isar 3.1.0+1 in caso di rimozione di proprietà embedded e collection senza aprire un database reale e senza consultare la documentazione/versione del core nativo. Il codice attuale non offre una migration callback configurata; la rimozione andrà quindi verificata con un database di test e, se necessario, con una strategia di reset/rebuild del database locale.

### Firestore

Il sync standard gestisce soltanto:

- `users/{uid}/plants`
- `users/{uid}/rooms`

come enum `_CollectionType` (`sync_service.dart` in corrispondenza di `_upsertFromFirestore`).

Non risultano listener o mapper attivi per:

- `watering_logs`
- `health_logs`
- `diagnoses`
- `nursery`

Le operazioni pending standard usano `set(..., merge: true)` (`sync_service.dart:363-377`). Questo significa:

- eliminare un campo dal payload futuro **non elimina il vecchio campo** già presente su Firestore;
- i campi legacy restano nei documenti finché non vengono rimossi esplicitamente;
- `merge: true` preserva i campi non inclusi nel nuovo payload.

Il sync gestisce invece alcuni percorsi `watering_logs` soltanto nella pulizia di una pending operation (`sync_service.dart:497-537`), ma non esiste nel codice verificato un repository che accodi realmente log di irrigazione.

### Pending operations

La coda contiene:

```text
operationId
userId
collectionPath
documentId
operation
payloadJson
attemptCount
```

`SyncService` gestisce:

- `create`
- `update`
- `delete`
- `opb_contribute`
- `opb_update`

Non contiene handler specifici per diagnosi, salute o vivaio.

Una pending operation già accodata con payload hydro o con vecchi campi:

- continuerà a essere processata;
- verrà inviata con `merge: true`;
- non verrà automaticamente ripulita dal semplice aggiornamento dell’app.

Per questo prima della rimozione va stabilito se la coda locale può essere azzerata.

### Firestore rules e indici

`firestore.rules` applica una regola generica a tutto ciò che sta sotto:

```text
/users/{userId}/{document=**}
```

Non esiste un `firestore.indexes.json` nel progetto verificato.

**Nota:** la regola Firestore non costituisce un inventario delle subcollection realmente usate; consente anche documenti legacy o subcollection che l’app non legge più.

---

## 5. Migrazione dati: opzioni

### Isar

| Strategia | Costi | Rischi |
|---|---|---|
| Migrazione conservativa | Rimuovere i campi dal modello, rigenerare schema e lasciare il database esistente evolvere | Rischio di dati residui, incompatibilità embedded e comportamento non verificato per Isar 3.1 |
| Migrazione esplicita | Aggiungere una versione applicativa e una trasformazione dei record prima di eliminare i campi | Più lavoro, ma consente di preservare `lastWateredAt` e dati utili |
| Azzeramento dati locali di test | Eliminare/reinizializzare il database locale | Semplice e adatto al contesto dichiarato; distrugge dati e pending operation locali |

**Raccomandazione per il contesto attuale:** azzeramento dei dati Isar di test, dopo avere verificato che non esistano pending operation importanti. Se si vuole mantenere la compatibilità futura, serve invece una migrazione esplicita testata su una copia del database.

### Firestore: campi dentro le piante

I documenti esistenti possono conservare:

- `hydroConfig`;
- `wateringConfig.schedulingCorrectionFactor`;
- `wateringConfig.pendingFeedbackCount`;
- `wateringConfig.pendingFeedbackSign`;
- `wateringConfig.manualOverrideAt`;
- `wateringConfig.manualOverrideDays`;
- `wateringConfig.methodPreference`;
- `wateringConfig.nextWateringAt`;
- `cultivationMethod`;
- `isInNursery`.

Rimuovere i campi dal modello Flutter non li elimina da Firestore.

Alternative:

1. **Pulizia mirata Admin SDK**
    - leggere `users/{uid}/plants`;
    - usare `FieldValue.delete()` sui campi rimossi;
    - preservare `lastWateredAt`, `frequencyDays` e `nextWateringAt` se ancora necessari;
    - eliminare solo `hydroConfig` per le piante convertite a soil;
    - eseguire prima su emulator/copia.

2. **Azzeramento dei dati di test**
    - eliminare i documenti delle piante e ricrearli;
    - attenzione: eliminare un documento Firestore **non elimina automaticamente le subcollection**.

Nel contesto dichiarato, azzerare i dati di test è più sicuro e meno costoso di uno script di migrazione complesso.

### Subcollection

Da ripulire esplicitamente, se presenti:

```text
users/{uid}/plants/{plantId}/watering_logs
users/{uid}/plants/{plantId}/health_logs
users/{uid}/plants/{plantId}/diagnoses
users/{uid}/plants/{plantId}/nursery
```

`DATABASE_SCHEMA.md` le documenta alle righe `25-32`, `128-245`, ma non sono lette da repository attivi verificati.

### Firebase Storage

Percorsi operativi verificati:

- foto pianta in `AddPlantScreen`;
- cancellazione della precedente foto in `PlantRepositoryImpl`.

Non sono stati verificati percorsi attivi per:

- foto diagnosi;
- foto salute;
- foto vivaio.

Quindi:

- i file presenti in Storage non possono essere attribuiti automaticamente al codice attuale;
- per pulirli serve uno script basato sui path reali o una cancellazione completa dei dati di test;
- **non verificato** se nel bucket esistano davvero file orfani.

---

## 6. Ordine consigliato per layer

### Fase 1 — decisioni di prodotto

Prima di modificare codice:

1. decidere se `cultivationMethod` resta;
2. decidere se l’app supporta ancora piante hydro;
3. decidere se i log storici di irrigazione devono restare;
4. decidere se `status` e `isInNursery` restano come campi informativi;
5. decidere se il meteo e l’esposizione restano nel calcolo.

### Fase 2 — dominio

Se hydro viene rimosso:

1. ridurre `PlantEntity`;
2. rimuovere `HydroConfigEntity`;
3. ridurre `WateringConfigEntity`;
4. rimuovere override e feedback EMA;
5. ridurre `WateringLogEntity` al minimo o eliminarlo;
6. mantenere `lastWateredAt`, `nextWateringAt`, `frequencyDays`.

### Fase 3 — scheduling

1. mantenere solo la parte soil di `SchedulingEngine`;
2. mantenere la conversione OpenPlantBook → frequenza;
3. decidere se meteo/esposizione modificano ancora l’intervallo;
4. eliminare `PlantSchedulingInfo` se la notifica può ricevere direttamente una lista di prossime date;
5. eliminare deduplicazione e testi hydro.

### Fase 4 — presentation

Rimuovere o semplificare:

- scelta hydro in add/edit;
- form hydro;
- titoli e messaggi hydro;
- icona hydro;
- asset water, solo se non servono più;
- controlli log avanzati non persistiti.

### Fase 5 — data/Isar/sync

1. rimuovere i campi dai modelli sorgente;
2. aggiornare collection Isar;
3. aggiornare mapper entity ↔ Isar;
4. aggiornare payload Firestore;
5. aggiornare `_plantFromFirestore`;
6. aggiornare `_migrateV1toV2`;
7. decidere cosa fare delle pending operation già presenti;
8. rigenerare i file generati.

### Fase 6 — collection B

Dopo aver verificato che non esista alcun dato da conservare:

- togliere le collection da `IsarService`;
- rimuovere i file sorgente e generati;
- rimuovere eccezioni dedicate;
- rimuovere route costanti inutilizzate;
- aggiornare documentazione;
- pulire Firestore subcollection e Storage separatamente.

### Rischi principali

- perdita di `lastWateredAt`;
- perdita di notifiche già programmate;
- pending operation con payload vecchi;
- documenti Firestore che conservano campi rimossi;
- dati nelle subcollection non eliminati insieme al documento padre;
- schema Isar locale incompatibile;
- asset water ancora referenziati da `PlantAssetResolver`;
- documentazione non allineata al codice.

---

## 7. Dipendenze, permessi e asset

### Probabilmente eliminabili dopo il refactoring

| Elemento | Stato verificato |
|---|---|
| `flutter_secure_storage` | Presente in `pubspec.yaml:40`, ma nessun import operativo trovato nel Dart verificato. Probabilmente eliminabile se Gemini viene rimosso. |
| `cloud_functions` | Usato da OpenPlantBook/contribuzione, quindi **non eliminare** insieme a Gemini. |
| `image_picker` | Usato per foto delle piante in `AddPlantScreen`, quindi **tenere**. |
| `firebase_storage` | Usato per le foto delle piante, quindi **tenere**. |
| `flutter_device_compass` | Usato dal dialogo di scansione esposizione, quindi **tenere** se resta esposizione. |
| `geolocator` | Usato dal servizio meteo, quindi **tenere** se resta il meteo. |
| `firebase_messaging` | Usato da `FcmService`; distinto dalle notifiche locali, quindi non rimuovere senza decidere il modello notifiche. |
| `flutter_local_notifications` | Necessario alla pipeline attuale delle notifiche locali. |
| `timezone` / `flutter_timezone` | Necessari per la programmazione locale delle notifiche. |
| `permission_handler` | Usato per il permesso notifiche; da tenere finché restano notifiche locali. |

### Asset

`PlantAssetResolver` usa:

```text
assets/illustrations/plants/
assets/illustrations/rooms/
```

`plant_shelf_view.dart:235,326` seleziona il parametro `water` in base a `cultivationMethod`.

Quindi gli asset della variante water sono eliminabili **solo dopo** aver deciso di rimuovere `cultivationMethod` come distinzione visiva.

---

## 8. Pipeline notifiche attuale

La catena attiva è:

```text
main.dart
  -> NotificationService.initialize()
  -> PiantalaApp
  -> notificationsSyncControllerProvider
  -> plantsProvider
  -> plantScheduleProvider per ogni pianta
  -> SchedulingEngine
  -> NotificationService.syncAllNotificationsFromSchedule()
  -> flutter_local_notifications.zonedSchedule()
```

Il promemoria giornaliero viene ora filtrato per la data esatta dell’evento (`notification_service.dart:273-299`), mentre la notifica urgente viene programmata separatamente.

Per il design target servono realmente:

- `PlantEntity`;
- `wateringConfig.frequencyDays`;
- `lastWateredAt`;
- prossima data calcolata;
- meteo/esposizione se confermati;
- `notificationsSyncController`;
- `NotificationService`;
- permission handling;
- timezone;
- card UI.

Non servono al target minimo:

- separazione rabbocco/cambio;
- `PlantSchedulingInfo` con due eventi hydro;
- deduplicazione hydro;
- notifiche con testo “rabbocca” o “cambia acqua”;
- feedback EMA non attivo;
- log avanzati non persistiti.

---

## 9. File generati coinvolti

Dopo la rimozione o modifica dei sorgenti annotati sarà necessario rigenerare:

- `lib/domain/entities/plant_entity.freezed.dart`
- `lib/domain/entities/plant_entity.g.dart`
- `lib/domain/entities/watering_log_entity.freezed.dart`
- `lib/domain/entities/watering_log_entity.g.dart`
- `lib/data/local/collections/plant_collection.g.dart`
- `lib/data/local/collections/watering_log_collection.g.dart`
- `lib/data/local/collections/diagnosis_collection.g.dart`
- `lib/data/local/collections/health_log_collection.g.dart`
- `lib/data/local/collections/nursery_collection.g.dart`
- `lib/presentation/providers/scheduling_providers.g.dart`
- eventuali altri `*.g.dart` prodotti da provider modificati.

Comando previsto dalla configurazione del progetto:

```text
dart run build_runner build --delete-conflicting-outputs
```

Non l’ho eseguito, in conformità alla modalità sola lettura.

---

## 10. Decisioni che spettano a te

### Decisione 1 — L’idrocoltura resta?

**Domanda:** l’app deve continuare a supportare piante in idrocoltura?

- **Sì:** mantenere `cultivationMethod`, `HydroConfigEntity`, ramo hydro dello scheduling e asset water; eventualmente semplificare hydro a una sola prossima cura.
- **No:** rimuovere tutto il ramo hydro, compresi form, notifiche, campi, mapper e asset dedicati.

### Decisione 2 — `cultivationMethod` serve solo alla grafica?

**Domanda:** vuoi conservare `cultivationMethod` esclusivamente per scegliere l’illustrazione vaso/acqua?

- **Sì:** mantenerlo, ma scollegarlo dal calcolo e dai log hydro.
- **No:** eliminare il campo e normalizzare tutti gli asset su una sola variante.

### Decisione 3 — Il meteo modifica la frequenza?

**Domanda:** temperatura e umidità devono continuare a modificare il numero di giorni?

- **Sì:** mantenere `SchedulingEngine` soil e parte di `SchedulingConstants`.
- **No:** ridurre il calcolo a `lastWateredAt + frequencyDays`, semplificando notevolmente il sistema.

### Decisione 4 — L’esposizione modifica la frequenza?

**Domanda:** l’esposizione della stanza deve continuare a influenzare la prossima irrigazione?

- **Sì:** mantenere rooms, bussola e `exposureMultiplier`.
- **No:** mantenere eventualmente l’esposizione solo come informazione UI.

### Decisione 5 — I watering log devono esistere?

**Domanda:** vuoi conservare uno storico delle innaffiature o basta `lastWateredAt` sulla pianta?

- **Solo `lastWateredAt`:** rimuovere `WateringLogEntity`, `WateringLogCollection`, campi avanzati e relativo sync.
- **Storico:** ridurre il log a `id`, `plantId`, `loggedAt`, eventualmente `notes`; eliminare tutto il resto.

### Decisione 6 — `status` resta?

**Domanda:** `healthy`, `warning`, `critical`, `propagating`, `archived` devono rimanere?

- **Sì:** conservarli come stato descrittivo, eliminando soltanto i valori non più utilizzati se vuoi.
- **No o solo stato minimo:** ridurre a uno stato più semplice, ma aggiornare UI, mapper e documenti Firestore.

### Decisione 7 — Dati remoti di test

**Domanda:** vuoi migrare i dati Firestore/Isar esistenti o azzerare tutto?

- **Migrare:** serve script Admin SDK, pulizia dei campi e verifica di pending operation/subcollection.
- **Azzerare:** soluzione più sicura e semplice per il contesto attuale, ma elimina piante, log, documenti e dati locali di test.

---

## 11. Discrepanze rilevate

### Ti aspettavi già rimosso, ma ancora attivo

1. **Idrocoltura**
    - È ancora selezionabile in aggiunta e modifica pianta.
    - Ha scheduling, UI, persistenza e notifiche attive.

2. **Irrigazione ragionata**
    - Non è stata rimossa.
    - Il calcolo soil usa ancora scheduling avanzato, meteo, esposizione e OpenPlantBook.

3. **Feedback e override**
    - Il supporto è ancora nei modelli e nel motore.
    - Il controller feedback è però commentato, quindi parte del sistema è strutturalmente presente ma non operativa.

4. **Watering log avanzato**
    - Il modello e la collection esistono.
    - Il flusso UI non completa la persistenza del log.

### Hai dato per esistente, ma non è stato trovato come codice operativo

1. **Clinic/diagnosi AI**
    - Nessuna schermata registrata nel router.
    - Nessun provider, repository o servizio Gemini operativo trovato.

2. **Health log**
    - Solo collection Isar e documentazione residua.

3. **Nursery/propagazione**
    - Solo collection Isar, campo `isInNursery`, route costante non registrata e documentazione residua.

4. **MigrationCallback Isar**
    - Non esiste nel codice.
    - Esiste soltanto una funzione custom `_migrateV1toV2()`.

5. **`firestore.indexes.json`**
    - Non presente nel progetto verificato.

6. **Percorsi Storage per diagnosi, salute e vivaio**
    - Non trovati nel codice operativo; l’esistenza di file orfani nel bucket è **non verificata**.

### Documentazione non allineata

`README.md`, `docs/DATABASE_SCHEMA.md` e `docs/PROVIDERS.md` continuano a descrivere:

- Clinic;
- health logs;
- nursery;
- stick test obbligatorio;
- provider non presenti;
- repository e subcollection non implementate;
- logiche hydro più complete di quelle effettivamente salvate.

---

## 12. Validazione eseguita

Ho eseguito soltanto comandi read-only:

```text
flutter analyze --no-fatal-infos
```

Risultato:

- nessuna modifica ai file;
- non sono stati eseguiti `build_runner`, test con scrittura o migrazioni;
- l’analisi ha riportato 288 issue complessive, principalmente `info`/warning;
- tra gli avvisi rilevanti ci sono `_notes` e `_ecMeasuredText` non utilizzati in `log_watering_bottom_sheet.dart`;
- non sono stati rilevati errori Dart bloccanti nell’output filtrato.