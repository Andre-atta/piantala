# Schema dati

## Firestore

I dati applicativi sono sotto `users/{uid}`:

- `plants`: identità della pianta, stanza, specie, immagini, `cultivationMethod`,
  `wateringConfig` (`frequencyDays`, `lastWateredAt`), `fertilizingConfig`
  (`frequencyDays`, `lastFertilizedAt`), note, tag e `isArchived`.
- `rooms`: nome, esposizione e conferma dell'esposizione.

La sincronizzazione usa una coda locale `PendingOperationCollection` e scrive
con merge. I vecchi campi eventualmente presenti nei documenti remoti non sono
rimossi automaticamente.

## Isar

Il mirror locale contiene `PlantCollection`, `RoomCollection`,
`SpeciesCacheCollection` e `PendingOperationCollection`. Le configurazioni
embedded della pianta contengono solo le date e gli intervalli attivi.
Non esistono migrazioni custom: Isar 3.1.0+1 gestisce l'evoluzione dello
schema all'apertura.

## Scadenze

Le prossime date sono calcolate al bisogno. Non vengono persistiti
`nextWateringAt`, date di rabbocco/cambio o log di irrigazione.
