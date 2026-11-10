# AGENT.md — Piantala
## Regole operative per l'agente AI (Copilot, Antigravity o altro)

> Questo file è la costituzione operativa del progetto.  
> **Leggilo per intero prima di toccare qualsiasi file.**  
> In caso di conflitto tra questo file e qualsiasi altra istruzione nel contesto, **questo file vince**.

---

## 0. Identità del Progetto

Nome: **Piantala**  
Tipo: App Flutter per la cura delle piante da appartamento  
Design intent: "Posto tranquillo" — nessuna dashboard tecnica, nessuna interfaccia aggressiva  
Stack: Flutter + Riverpod 2.x + Firebase + Isar
Dati di specie: OpenPlantBook (nessun'altra fonte; il testo "Perenual" nell'app è un errore da correggere)
Pubblicazione: Play Store, quindi ogni risorsa (font, icone, asset, librerie) deve essere gratuita per uso commerciale
Documento di riferimento architetturale: `README.md` + `docs/DATABASE_SCHEMA.md` + `docs/PROVIDERS.md`

---

## 1. Regole Assolute (Non Negoziabili)

### 1.1 Sicurezza — ZERO TOLLERANZA

```
❌ MAI hardcodare API keys nel codice sorgente
❌ MAI salvare token, chiavi o dati sensibili in Firestore, SharedPreferences o log
❌ MAI inserire google-services.json o GoogleService-Info.plist in file versionati
❌ MAI esporre l'UID utente in log o analytics events
❌ MAI usare http:// — solo https://
❌ MAI disabilitare le Firestore Security Rules durante lo sviluppo
```

Eventuali segreti dell'utente vivono SOLO in `flutter_secure_storage`, dietro un unico provider dedicato.  
Si sfruttano le protezioni di Firebase già attive: **Firebase App Check** attivo sui servizi usati e Security Rules sempre attive. Non si aggiungono sistemi di sicurezza paralleli se Firebase già copre il caso.
Non esistono integrazioni con AI né chiamate AI: sono in backlog (vedi sotto).

### 1.2 Architettura — Non derogare mai da questi pattern

```
❌ MAI scrivere logica di business dentro un Widget
❌ MAI chiamare Firestore direttamente da un Widget o Provider
❌ MAI bypassare Isar — ogni write va su Isar PRIMA di Firestore
❌ MAI usare setState() fuori dagli usecase di animazione locale
❌ MAI creare un Provider globale per stato che è per-schermata
❌ MAI usare BuildContext in un Provider/Notifier
```

```
✅ Widget → chiama Provider/Notifier
✅ Provider/Notifier → chiama UseCase o Repository (interfaccia)
✅ Repository Impl → scrive su Isar → SyncService gestisce Firestore
✅ UseCase → contiene TUTTA la logica di business
```

### 1.3 Offline-First — Invariante fondamentale

Ogni operazione di scrittura dell'utente (add, update, delete) DEVE:
1. Scrivere su Isar immediatamente (con `syncStatus: pending_create/update/delete`)
2. Restituire successo all'UI senza aspettare Firestore
3. Accodare l'operazione in `PendingOperation` per la sync background
4. Non lanciare eccezione se non c'è connettività — silenziosamente accodare

### 1.4 Nessun Plugin Android-Only

L'app è Android-first ma la struttura deve essere cross-platform dal giorno 1.  
Ogni plugin aggiunto DEVE avere supporto iOS documentato nel suo README.  
Se un plugin non supporta iOS, usare un'interfaccia con stub implementation iOS.

---

## 2. Struttura dei File

### 2.1 Dove creare nuovi file

| Tipo | Path |
|------|------|
| Modello Freezed (DTO) | `lib/data/models/<nome>_model.dart` |
| Entity (dominio puro) | `lib/domain/entities/<nome>.dart` |
| Isar Collection | `lib/data/local/collections/<nome>_collection.dart` |
| Repository interfaccia | `lib/domain/repositories/i_<nome>_repository.dart` |
| Repository implementazione | `lib/data/repositories/<nome>_repository_impl.dart` |
| Provider/Notifier | `lib/presentation/providers/<dominio>_providers.dart` |
| UseCase | `lib/domain/usecases/<verbo>_<nome>_usecase.dart` |
| Schermata | `lib/presentation/screens/<nome>/<nome>_screen.dart` |
| Widget riusabile (globale) | `lib/presentation/widgets/common/<nome>.dart` |
| Widget specifico di dominio | `lib/presentation/widgets/<dominio>/<nome>.dart` |
| Asset illustrazione (PNG) | `assets/illustrations/<categoria>/<nome>.png` — categoria ∈ `plants`, `rooms`, `icons` |
| Test unit | `test/unit/<dominio>/<nome>_test.dart` |
| Test widget | `test/widget/<schermata>/<nome>_test.dart` |

### 2.2 Naming Conventions

```dart
// File: plant_model.dart
@freezed
class PlantModel with _$PlantModel { ... }   // DTO — ha fromJson/toJson

// File: plant.dart (domain entity)
@freezed
class Plant with _$Plant { ... }              // Entity — nessun JSON

// File: plant_collection.dart (Isar)
@collection
class PlantCollection { ... }                 // Schema locale Isar

// File: plant_providers.dart
@riverpod
class PlantsNotifier extends _$PlantsNotifier { ... }
```

### 2.3 Ordine degli import in ogni file Dart

```dart
// 1. Dart SDK
import 'dart:async';

// 2. Flutter SDK
import 'package:flutter/material.dart';

// 3. Packages esterni (ordine alfabetico)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

// 4. Import interni — core
import 'package:piantala/core/...';

// 5. Import interni — data
import 'package:piantala/data/...';

// 6. Import interni — domain
import 'package:piantala/domain/...';

// 7. Import interni — presentation
import 'package:piantala/presentation/...';
```

---

## 3. Code Generation

Dopo ogni modifica a:
- Un file con annotazioni `@freezed`
- Un file con annotazioni `@riverpod`
- Un file con annotazioni Isar (`@collection`, `@embedded`)
- Un file con annotazioni `@JsonSerializable`

**Eseguire obbligatoriamente:**
```bash
dart run build_runner build --delete-conflicting-outputs
```

I file generati (`*.g.dart`, `*.freezed.dart`) restano nel repo e vanno sempre rigenerati, mai modificati a mano.

---

## 4. Regole per i Provider Riverpod

### 4.1 Quando usare ogni tipo

| Scenario | Provider da usare |
|----------|------------------|
| Stream da Isar/Firestore | `@riverpod` con `Stream<T>` return type |
| Future one-shot (fetch API) | `@riverpod` con `Future<T>` return type |
| Stato mutabile con logica | `@riverpod class XNotifier extends _$XNotifier` |
| Valore derivato/computed | `@riverpod` con return type sincrono |
| Stato locale a una schermata | `.autoDispose` modifier |
| Dati globali persistenti | Nessun `.autoDispose` |

### 4.2 Pattern obbligatorio per i Notifier

```dart
@riverpod
class PlantsNotifier extends _$PlantsNotifier {
  @override
  Stream<List<Plant>> build() {
    // Setup listeners, return stream from Isar
  }

  Future<void> addPlant(Plant plant) async {
    // 1. Scrivi su Isar (ottimistico)
    // 2. Notifica SyncService
    // 3. NON toccare state direttamente — lo stream si aggiorna da solo
  }
}
```

### 4.3 Error handling nei Provider

```dart
// ✅ Corretto
state = AsyncError(AppException.networkUnavailable(), StackTrace.current);

// ❌ Sbagliato — non usare mai Exception generica
state = AsyncError(Exception('network error'), StackTrace.current);
```

Tutti gli errori devono essere istanze di `AppException` (sealed class definita in `core/errors/`).

---

## 5. Regole per il Database

### 5.1 Isar — Schema Constraints

```dart
// ✅ Ogni collection Isar DEVE avere questi campi
@collection
class PlantCollection {
  Id id = Isar.autoIncrement;
  late String firestoreId;       // UID Firestore corrispondente
  late String userId;             // UID utente (partitioning)
  late int syncStatusIndex;       // 0=synced, 1=pending_create, 2=pending_update, 3=pending_delete
  late DateTime localUpdatedAt;   // Timestamp dell'ultima modifica locale
  // ... altri campi specifici
}
```

### 5.2 Firestore — Path Convention

```
users/{uid}/plants/{plantId}
users/{uid}/rooms/{roomId}
users/{uid}/plants/{plantId}/watering_logs/{logId}
users/{uid}/plants/{plantId}/nursery/{nurseryId}
```

**Regola fondamentale**: nessun documento Firestore può esistere senza `userId` come prefisso del path.

### 5.3 Operazioni vietate

```
❌ MAI fare una query Firestore senza limite (usare .limit(n) sempre)
❌ MAI leggere una intera collection senza filtro su userId
❌ MAI salvare dati binari (immagini) in Firestore — usare Firebase Storage
```

---

## 6. Gestione delle Immagini

```
Flusso obbligatorio per le foto delle piante:
1. image_picker → file locale temporaneo
2. Compressione locale (max 1024px, qualità 80%) prima di qualsiasi upload
3. Upload su Firebase Storage → path: users/{uid}/plants/{plantId}/{timestamp}.jpg
4. Salva SOLO l'URL risultante su Firestore/Isar
5. Mai salvare immagini in base64 nel database
```

---


## 7. Localizzazione e Stringhe Centralizzate

> **Sezione da verificare sul codice reale (repo di Mestre).** I nomi dei file qui sotto sono quelli attesi dopo il refactoring con Antigravity; se differiscono, correggere questa sezione e non il codice.

```
❌ MAI scrivere una stringa visibile all'utente dentro un widget
❌ MAI concatenare stringhe tradotte (usare placeholder ICU)
✅ Ogni testo UI vive nel file centrale delle stringhe / nei file ARB della libreria di traduzione
✅ Ogni nuova stringa va aggiunta in tutte le lingue supportate (oggi: italiano, inglese)
✅ Etichette di accessibilità (Semantics, tooltip) sono stringhe come le altre
```

- Lingue supportate: italiano (predefinita) e inglese. L'inglese nel selettore lingua è ancora da confermare.
- I nomi di piante e stanze sono dati dell'utente, non stringhe tradotte.
- I testi dell'enciclopedia arrivano da OpenPlantBook e non si traducono nell'app.
- File centrali attesi (da confermare): stringhe, colori, spaziature. Se un valore manca, si aggiunge lì, mai nel widget.

---

## 8. Tema & UI

### 8.1 Nessun colore, font o misura hardcodati nei widget

```dart
// ❌ Sbagliato
Container(color: Color(0xFF4CAF50))

// ✅ Corretto
Container(color: Theme.of(context).colorScheme.primary)
// oppure
Container(color: AppColors.plantGreen)  // costante da app_colors.dart
```

Vale anche per i font (mai `fontFamily: 'Delius'` in un widget: si usa il tema) e per le misure (8.3).
I valori di palette e tipografia sono quelli di `docs/design/art-direction.md` (v2.3.0): se un colore o un font non è lì, non si introduce.

### 8.2 Il tema temporale è read-only per i widget

I widget non calcolano mai l'ora corrente per determinare il tema.  
Usano solo `ref.watch(currentThemeProvider)`.

### 8.3 Dimensioni e spacing

```dart
// Usare sempre le costanti di spaziatura
// ❌ Sbagliato
SizedBox(height: 16)

// ✅ Corretto
SizedBox(height: AppSpacing.md)  // AppSpacing.xs=4, sm=8, md=16, lg=24, xl=32, xxl=48
```

Area toccabile minima 48 dp, con almeno 8 dp tra bersagli vicini, anche quando il disegno è più piccolo o inclinato.

### 8.4 Asset Grafici — Illustrazioni Piante e Stanze

Documento di riferimento vincolante: `docs/design/art-direction.md` (palette, design rules, prompt di generazione).  
Qualunque asset grafico creato o generato via AI per l'app DEVE rispettarne le regole — nessuna eccezione senza discuterne prima.

```
Formato: PNG con sfondo trasparente (non SVG).
Motivo: gli asset sono generati via AI (raster) con shading complesso (cel-shading,
rim light, vetro/rifrazione) — un SVG richiederebbe ridisegno manuale e perderebbe fedeltà.
L'SVG resta riservato a elementi piatti disegnati a mano (icone, forme mensola).
```

```
Naming e path:
  assets/illustrations/plants/<species_slug>_<substrate>.png   (substrate: soil | water)
  assets/illustrations/rooms/<room_slug>.png
  assets/illustrations/icons/<name>.png                        (notifiche, badge, app icon)
```

```
❌ MAI generare un asset pianta "ambientato" (con muro/mensola/ombra proiettata nella scena)
❌ MAI introdurre un nuovo colore in AppColors ispirato a una specifica pianta senza
   discuterlo esplicitamente — eventuali accenti cromatici legati a una specie restano
   scoped al widget della card, mai promossi a colore globale del tema (vedi 8.1)
```

```
✅ Ogni specie con più metodi di coltivazione supportati DEVE avere entrambe le varianti
   (soil + water) prima di essere aggiunta al catalogo specie
✅ Variazioni visive tra istanze della stessa specie sulla stessa mensola (flip, scala
   95–105%, rotazione ±3°) si gestiscono a runtime nel widget — MAI duplicando l'asset fisico
```

### 8.5 Identificatori Specie (Species Slugs)

In tutto il progetto (cataloghi, resolver, asset, database) esiste **UNO E UN SOLO** formato canonico per identificare le specie botaniche: il nome scientifico normalizzato, minuscolo, con gli spazi sostituiti da underscore.

```dart
// ❌ Sbagliato
"Epipremnum aureum"
"epipremnum aureum"
"pothos"

// ✅ Corretto (Slug Canonico)
"epipremnum_aureum"
```

Questa normalizzazione è esposta dalla property `canonicalSpeciesSlug` in `PlantEntity`. Qualunque widget o logica che deve interagire con asset o cataloghi legati alla specie DEVE usare questo formato canonico.


### 8.6 Stile visivo e componenti (vedi `docs/design/art-direction.md` §2)

```
✅ Tre font, solo regular, inclusi nell'app come file (non scaricati al volo):
   Sue Ellen Francisco = solo nomi di piante e stanze
   Barriecito          = microcopy brevissimo, max 2-3 per schermata, mai su pulsanti
   Delius              = tutto il resto
✅ Tipografia e colori arrivano da un ThemeExtension, non da valori sparsi
✅ Il testo scala con le impostazioni di sistema; le altezze sono minimi, non valori fissi
✅ Rispettare MediaQuery.disableAnimations
❌ Niente ombre, sfumature, vetro, neumorfismo; niente angoli molto arrotondati
❌ Mai un'intera schermata come immagine unica (non scala e blocca il tema temporale)
```

Metafore per schermata: Home = stanza con mensola; schede = erbario; risultati di ricerca = ritagli di carta; Profilo = bacheca di sughero.

**Componenti condivisi** (in `lib/presentation/widgets/common/`, uno per file, ognuno con il suo test; nomi indicativi):

| Componente | Uso |
|------------|-----|
| Cartellino centrale della navbar | Aggiungi pianta; nelle Stanze "nuova stanza" |
| Card carta con cornice doppia | Base di schede e liste |
| Segnapagina a nastro | Azioni sulla scheda pianta (Annaffia, Concima), appeso al bordo della card |
| Etichetta appesa a due fili | Azioni principali a larghezza piena |
| Cartellino con filo e puntina | Azioni in dialoghi e Profilo |
| Puntina | Menu, bussola, cancella testo |
| Testo con sottolineatura a mano | Azioni secondarie (Annulla) |
| Post-it con puntina | Origine, orario notifiche |
| Ritaglio di carta irregolare | Risultati di ricerca |
| Bastoncino segna-nome | Promemoria "da annaffiare" sulla pianta, piantato nel vaso |

Regole dei pulsanti: tutto ciò che si preme è attaccato a qualcosa; stato premuto = scende di 2 px; area toccabile sempre un rettangolo dritto di almeno 48 dp; inclinazione del testo al massimo 1°; nessuna ombra o spessore sotto i pulsanti.

**Navigazione:** niente freccia indietro e niente titolo di schermata nella UI (i titoli restano nel router e come `Semantics(header: true)`). Solo la Home mostra i nomi delle stanze. Nessun pulsante "Gira": la scheda si gira con tap o swipe, con un'animazione che lo suggerisce e un'azione accessibile "Gira la scheda".

**Irregolarità:** inclinazioni e forme dei ritagli derivano dallo `canonicalSpeciesSlug`, mai da valori casuali a ogni build.

**Vettoriale:** per elementi piatti (vasi, finestra, bussola, oggetti di scena) è ammesso `flutter_svg` (licenza MIT); per piante e texture resta il PNG/WebP di 8.4.

**Dati e schede:** le informazioni di specie non cambiano le scadenze di cura; l'enciclopedia non mostra mai il nome dato dall'utente; un dato mancante è un riquadro tratteggiato "Dato non disponibile per questa specie", mai un valore inventato.


### 8.7 Modularità e semplicità

```
✅ Un solo posto per ogni cosa: stringhe, colori, tipografia, spaziature, componenti
✅ Il sistema centrale (tema e token) viene ereditato dai widget e dai componenti; i widget non ridefiniscono
✅ Se qualcosa si ripete due o più volte (widget, funzione, formattazione, query), si estrae in un file dedicato e si riusa
✅ Prima di scrivere un widget o una funzione, cercare se esiste già
✅ Strutture semplici e funzionali: nessuna astrazione, pattern o livello in più senza un bisogno concreto oggi
✅ Widget piccoli e con un solo compito; la logica sta negli usecase (1.2)
❌ Niente codice copiato e incollato tra schermate
❌ Niente classi o livelli "per il futuro" (es. per le funzioni AI, ancora in backlog)
```

### 8.8 Backlog (non implementare, non predisporre)

Salute delle piante e diagnosi, integrazione con AI e chiamate AI. Quando arriveranno si decideranno e si documenteranno qui; fino ad allora non lasciare stub, provider o eccezioni dedicati.

---

## 9. Testing — Requisiti Minimi

### Per ogni UseCase creato
- Test happy path
- Test con repository che lancia eccezione
- Test con input edge case (null, vuoto, valori limite)

### Per ogni Notifier creato
- Test dello stato iniziale
- Test di ogni metodo pubblico
- Test error state propagation

### Per ogni schermata creata
- Widget test che verifica il render senza crash
- Widget test che verifica la navigazione principale

### Per ogni componente visivo condiviso (8.6)
- Golden test (stato normale, premuto, disabilitato dove esiste)
- Test che l'area toccabile sia almeno 48 dp
- Test con testo ingrandito (textScaleFactor 1.5) senza overflow

### Test vietati
```
❌ Non mockare Isar — usare Isar.inMemory() nei test
❌ Non mockare Firestore — usare fake_cloud_firestore
❌ Non usare sleep() nei test — usare fakeAsync/pump
```

---

## 10. Consegna del codice

Le commit e le push le gestisce Andrea: l'agente scrive il codice, Andrea lo prova e lo pubblica. L'agente non esegue operazioni Git e non propone messaggi di commit se non richiesti.

Non va mai scritto in file versionati: `lib/core/constants/env.dart`, `android/app/google-services.json`, `ios/Runner/GoogleService-Info.plist`.

Prima di consegnare, controllare:

```
[ ] dart run build_runner build --delete-conflicting-outputs → nessun errore
[ ] flutter analyze → zero warning, zero error
[ ] flutter test → tutti i test passano
[ ] Nessuna chiave o segreto nel codice
[ ] Nessun print() in produzione (solo debugPrint wrappato in assert)
[ ] Ogni nuovo file ha il corrispondente test
[ ] Isar schema modificato → migration verificata
[ ] Nessun testo, colore, font o misura hardcodato (vedi 7 e 8)
[ ] Nessuna logica duplicata (vedi 8.7)
```

---

## 11. Sicurezza, Privacy e Permessi

> Regola madre: quando una modifica tocca fotocamera, galleria, posizione, foto utente, account,
> notifiche o qualsiasi dato personale, FERMATI. Descrivi cosa raccoglie, dove lo salva e chi può leggerlo,
> aspetta conferma, poi implementa. Nel dubbio: nega per default (§13.4).

### 11.1 Permessi di sistema
- Si chiede un permesso SOLO nel momento in cui l'utente attiva la funzione che lo richiede. Mai all'avvio, mai in blocco.
- Prima del popup nativo mostra una scheda dell'app (testi in l10n) che spiega a cosa serve in una frase.
- Se il permesso è negato l'app NON si blocca: ogni funzione ha un piano B (vedi sotto). Un permesso negato non si richiede in loop;
  si offre un link alle impostazioni di sistema solo se l'utente ripete l'azione.
- Si dichiarano solo i permessi in uso (Info.plist / AndroidManifest). Ogni nuovo permesso va motivato nel commit.
- Ora e fuso orario del dispositivo non richiedono permessi. Si salva sempre `DateTime.now().toUtc()` e si converte in locale solo per mostrarlo.

### 11.2 Fotocamera e foto
- Per scegliere una foto esistente usare il picker di sistema di `image_picker` (nessun accesso all'intera galleria).
- La fotocamera si apre solo da un gesto esplicito. Piano B se negata: scelta dalla galleria.
- Si ridimensiona e comprime sul dispositivo prima di qualsiasi upload (§6). Si eliminano i metadati EXIF (in particolare le coordinate GPS)
  prima dell'upload.
- Le foto dell'utente stanno in `users/{uid}/...` su Firebase Storage. Sono private: leggibili e scrivibili solo dal proprietario.
- Non si salvano foto in chiaro nei log, nella cache pubblica o nei file temporanei oltre il necessario: cancella il file temporaneo dopo l'upload.
- Crittografia: Firebase cifra già i dati in transito (TLS) e a riposo. Non aggiungere cifratura applicativa personalizzata
  senza una decisione esplicita (rompe cache, miniature e regole). La difesa vera sono le Security Rules e App Check.

### 11.3 Posizione
- Per l'esposizione si usa già la bussola (nessun permesso di posizione). Per il meteo serve solo la CITTÀ.
- Se in futuro serve la posizione: solo "approssimativa" (coarse), mai GPS preciso, e solo su richiesta esplicita.
- Piano B obbligatorio: campo "In che città vivi?" a mano (nome del comune, niente via o numero civico).
- Si salva solo il nome del comune (o un codice zona), MAI latitudine e longitudine esatte.

### 11.4 Foto profilo e dati dell'account
- Percorso: `users/{uid}/avatar.jpg`. Lettura e scrittura solo per `request.auth.uid == uid`
  (un avatar condiviso con altri utenti richiede una decisione esplicita).
- Eliminazione account: una Cloud Function (`onDelete` su Auth o funzione richiamabile) cancella documenti Firestore dell'utente,
  tutti i file sotto `users/{uid}/` su Storage, i dati Isar locali e il token FCM. L'app deve poterla avviare dalle impostazioni.
- Esportazione dei dati (diritto di portabilità): predisporre il punto d'ingresso nelle impostazioni, anche se all'inizio manda una email.

### 11.5 Regole Firebase (vincolanti)
- `firestore.rules` e `storage.rules` stanno nel repository, sono in `firebase.json` e hanno test con l'emulatore.
- Default: `allow read, write: if false;` e si apre solo ciò che serve.
- Storage: limite di dimensione (es. 5 MB) e `contentType` ammesso (`image/jpeg`, `image/webp`) nella regola di scrittura.
- App Check attivo per Firestore, Storage e Functions (Play Integrity / App Attest).
- Nessuna chiave o segreto nel codice client; i segreti stanno in Functions (come per OpenPlantBook) o in Secret Manager.

### 11.6 GDPR
- Informativa privacy raggiungibile dalle impostazioni e dalla schermata di registrazione, in italiano e in inglese.
- Dati raccolti documentati in `docs/legal/privacy_data_inventory.md` (cosa, perché, dove, per quanto tempo, chi vi accede).
  Ogni nuova funzione che raccoglie dati aggiorna questo file nello stesso commit.
- Analytics e Crashlytics (se aggiunti) solo dopo consenso, disattivabili dalle impostazioni.
- Minimizzazione: se un dato non serve a una funzione esistente, non si raccoglie.

---

## 12. Gestione degli Errori — Standard

```dart
// AppException — sealed class in core/errors/app_exception.dart
sealed class AppException implements Exception {
  const AppException();
}

class NetworkUnavailableException extends AppException { ... }
class FirestoreException extends AppException { ... }
class EncyclopediaApiException extends AppException { ... }
class WeatherApiException extends AppException { ... }
class PermissionDeniedException extends AppException { ... }
class StorageUploadException extends AppException { ... }
class IsarException extends AppException { ... }
```

Ogni `catch` in repository o service DEVE rilanciare come `AppException`, mai come `Exception` raw.

---

## 13. Quando Sei Bloccato o Incerto

1. **Leggi prima** `README.md`, `docs/DATABASE_SCHEMA.md`, `docs/PROVIDERS.md`
2. Se l'incertezza riguarda l'architettura → **non procedere** e segnala il dubbio
3. Se l'incertezza riguarda una dipendenza → controlla la versione in `pubspec.yaml` e la sua documentazione ufficiale
4. Se hai dubbi sulla sicurezza → **nega per default**, non procedere
5. Mai fare assunzioni silenziose su percorsi Firestore o schemi Isar — sono definiti in `DATABASE_SCHEMA.md` e sono vincolanti

---

*Versione: 1.2.0 (bozza del 7 novembre 2026, scritta senza accesso al codice aggiornato) — da riallineare al repository e da aggiornare a ogni modifica architetturale significativa*