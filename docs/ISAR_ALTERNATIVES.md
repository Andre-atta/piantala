# Valutazione alternative a Isar 3 (`isar_community` vs `Drift`)

> Documento di analisi — **nessuna modifica al codice**.
> Stato attuale in Piantala: `isar: ^3.1.0+1`, `isar_flutter_libs: ^3.1.0+1`, `isar_generator: ^3.1.0+1`.

## Perché serve una decisione

1. **Pacchetto fermo**: `isar` / `isar_generator` `3.1.0+1` non ricevono aggiornamenti; `isar_generator` vincola `analyzer >=4.6.0 <6.0.0`, `build ^2.3.0` e `source_gen ^1.2.2`.
2. **Blocco della generazione del codice (passo 5)**: questo vincolo su `analyzer <6.0.0` impedisce di aggiornare `flutter_riverpod` 3, `riverpod_generator` 4, `freezed` 4, `json_serializable` e `build_runner` 2.17.1 (oggi fermi su `analyzer 5.13.0` con i transitivi abbandonati `js`, `build_resolvers`, `build_runner_core`).
3. **Toolchain Android (AGP 9 / compileSdk 36–37)**: `isar_flutter_libs 3.1.0+1` richiede già il workaround in `android/build.gradle.kts` per forzare `compileSdk`, `Java 17` e `namespace`.

## Impronta Isar attuale in Piantala

Le collection in `lib/data/local/collections/` sono 4:
- `PlantCollection` (con oggetti `@embedded`: `WateringConfigIsar`, `CareConfigIsar`, `FertilizingConfigIsar`)
- `RoomCollection`
- `PendingOperationCollection` (coda offline FIFO per `SyncService`)
- `SpeciesCacheCollection` (cache locale OpenPlantBook con TTL)

Accesso centralizzato in `lib/data/local/isar_service.dart`, `SyncService`, `PlantRepositoryImpl`, `RoomRepositoryImpl`, `SpeciesRepositoryImpl`, `OpbContributionRepository`, `AuthRepositoryImpl` (`_db.clear()` al logout/eliminazione) e nei test unitari (`Isar.inMemory()`).

---

## Opzione A — `isar_community` (`^3.4.1`)

Fork comunitario mantenuto di Isar 3 (`isar_community`, `isar_community_flutter_libs`, `isar_community_generator`).

### Pro / Costi
- **Migrazione quasi drop-in**: mantiene `@collection`, `@embedded`, query fluent, `Isar.open` e lo stesso formato su disco delle collection Isar 3 (nessuna migrazione dati SQL necessaria per gli utenti esistenti).
- **Costo stimato**: **basso** (cambio dipendenze e import da `package:isar/isar.dart` a `package:isar_community/isar.dart` + rigenerazione `*.g.dart` e verifica dei vincoli `analyzer` / `build_runner` con il blocco di generazione codice).

### Rischi
- **Manutenzione**: progetto comunitario (non ufficiale), con rischio di ritardi su futuri aggiornamenti di Dart/AGP o `analyzer`.
- **Binari nativi Rust**: `isar_community_flutter_libs` continua a distribuire `.so` / librerie native custom; possibili attriti su AGP 9/10 o nuove policy Play Store (es. 16 KB page size / NDK).
- **Vincoli generatore**: prima di adottarlo va verificato con `fvm flutter pub get` che `isar_community_generator` compatibilizzi `analyzer` e `build_runner` con `riverpod_generator 4` e `freezed 4`.

---

## Opzione B — `Drift` (`drift` + `drift_dev` + `sqlite3_flutter_libs`)

ORM/query builder SQLite fortemente tipizzato per Dart/Flutter, attivamente mantenuto.

### Pro / Costi
- **Stabilità a lungo termine**: manutenzione molto attiva, ottimo supporto a `analyzer`/`build_runner` recenti, niente dipendenze abbandonate, zero attriti noti con AGP 9 e Android moderni.
- **Query e test**: SQLite standard, migrazioni di schema esplicite (`MigrationStrategy`), test in memoria (`NativeDatabase.memory()`).
- **Costo stimato**: **medio-alto**
  - Riscrittura delle 4 collection in tabelle Drift (appiattimento o JSON type converter per i 3 `@embedded` di `PlantCollection` e liste `tags`/`propagationMethods`).
  - Adattamento dei `watch` reattivi, di `SyncService`, dei repository e dei test unitari.
  - **Migrazione dati utenti esistenti**: se esistono installazioni con dati solo locali (offline pending) in Isar 3, serve un passaggio one-shot Isar → Drift oppure un resync completo da Firestore (possibile solo se tutti i dati locali sono già sincronizzati).

### Rischi
- **Regressioni su sync offline**: `SyncService` e la coda `PendingOperation` oggi sfruttano transazioni e `watchLazy()` di Isar; vanno replicati fedelmente con gli stream Drift.
- **Dati non sincronizzati al momento dell'aggiornamento app**: una sostituzione secca senza migrazione locale perderebbe eventuali `PendingOperation` mai inviate a Firestore.

---

## Confronto sintetico

| Criterio | `isar_community` (`3.4.x`) | `Drift` (SQLite) |
|---|---|---|
| Impatto sul codice | Minimo (cambio package/import) | Medio-alto (nuovo layer locale + test) |
| Migrazione dati utenti | Nessuna (compatibile Isar 3) | Richiede migrazione o resync da Firestore |
| Manutenibilità lungo periodo | Media (fork community) | Alta (ecosistema maturo e attivo) |
| Rischio toolchain Android / AGP | Medio (binari Rust custom) | Basso (SQLite standard) |
| Compatibilità `build_runner` / `analyzer` | Da verificare sulle versioni target | Alta (`drift_dev` sempre allineato) |

## Raccomandazione operativa

1. **Breve termine (per sbloccare il passo 5 — Riverpod 3 / Freezed 4 / `build_runner`)**: provare prima **`isar_community`** in un branch dedicato verificando solo la risoluzione di `pub get` insieme a `riverpod_generator 4` + `freezed 4` + `build_runner 2.17.1` e il build su Android (AGP 9 / 16 KB page size).
2. **Medio/lungo termine (o se `isar_community_generator` continuasse a bloccare `analyzer`)**: pianificare la migrazione a **Drift**, preceduta da una verifica che non esistano dati offline non sincronizzati (o includendo un import one-shot prima di rimuovere Isar).
