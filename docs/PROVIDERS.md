# Provider principali

- `plantsProvider`, `plantProvider`: piante dal mirror Isar.
- `roomsProvider`: stanze dal mirror Isar.
- `plantScheduleProvider`: calcolo puro delle prossime irrigazione e
  concimazione.
- `notificationsSyncController`: sincronizza i promemoria locali usando le
  scadenze calcolate.
- `speciesSearchProvider` e `speciesDetailsProvider`: OpenPlantBook e cache
  locale.
- `opbContributionProvider`: contribuzione a OpenPlantBook, indipendente dalla
  semplificazione dell'irrigazione.
- Provider di autenticazione, tema e impostazioni: invariati.

Non sono più presenti provider per meteo, clinica, salute, vivaio, feedback o
log di irrigazione.
