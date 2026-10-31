# Sistema di irrigazione e concimazione

## Scopo

Il sistema mantiene una gestione essenziale delle cure:

- calcola quando controllare o irrigare una pianta;
- salva soltanto la data dell'ultima azione;
- mostra la prossima scadenza calcolandola al bisogno;
- invia notifiche solo quando almeno una pianta ha una scadenza di irrigazione.

L'app non registra uno storico delle irrigazioni e non distingue tra
rabbocco, cambio totale dell'acqua o altre tecniche operative. La decisione
su come innaffiare una pianta spetta all'utente.

## Dati salvati

La configurazione di una pianta contiene:

```text
wateringConfig
  frequencyDays
  lastWateredAt

fertilizingConfig
  frequencyDays
  lastFertilizedAt
```

Le configurazioni sono salvate:

- nell'entità Freezed `PlantEntity`;
- nel mirror locale Isar (`PlantCollection`);
- nel documento Firestore della pianta;
- nella coda `PendingOperationCollection` quando la modifica è fatta
  offline.

Non vengono più salvati:

- `nextWateringAt`;
- date di rabbocco o cambio totale;
- configurazioni avanzate per l'idrocoltura;
- log di irrigazione;
- correzioni manuali o feedback sulla programmazione.

La prossima data viene sempre calcolata come:

```text
ultima azione + intervallo in giorni
```

Se non esiste ancora una data precedente, il calcolo usa l'istante corrente
come riferimento.

## Intervalli di irrigazione

### Piante in terra

Per una pianta in terra associata a una specie, l'intervallo viene letto dalla
cache locale della specie OpenPlantBook (`wateringFrequencyDays`). Il valore
della cache è prodotto dal repository delle specie a partire dai dati
OpenPlantBook e dall'euristica di fabbisogno idrico.

Se la pianta non ha una specie collegata, oppure non è disponibile un intervallo
utilizzabile, viene usato il fallback:

```text
7 giorni
```

Il vecchio modello basato su meteo, esposizione, correzioni da feedback e
stagionalità non è più attivo. L'esposizione della stanza resta un dato
informativo, ma non modifica il calcolo.

### Piante in acqua

OpenPlantBook non fornisce un intervallo specifico per l'idrocoltura.
Per questo il metodo di coltura `hydro` usa il fallback fisso:

```text
3 giorni
```

Il significato operativo è neutro: l'app invita a controllare l'acqua. Non
indica se eseguire un rabbocco o un cambio totale.

## Azione di irrigazione

Nella card della pianta è disponibile un'azione diretta per segnare la cura
come completata.

Quando l'utente la esegue:

1. viene usata o creata la `wateringConfig`;
2. `lastWateredAt` viene impostato a `DateTime.now()`;
3. la pianta viene aggiornata tramite `PlantRepository`;
4. la modifica viene salvata localmente e accodata per la sincronizzazione;
5. la UI mostra una conferma.

Per una pianta in terra il messaggio conferma che la pianta è stata
innaffiata. Per una pianta in acqua il messaggio è neutro, ad esempio
`Acqua controllata!`.

Non viene più aperto un form per registrare quantità, metodo, condizioni del
terreno, livello dell'acqua, EC o note.

## Notifiche di irrigazione

La sincronizzazione delle notifiche viene attivata dall'app e dalle
impostazioni tramite `notificationsSyncController`. Il provider:

1. legge le piante non archiviate;
2. calcola la prossima irrigazione tramite `plantScheduleProvider`;
3. passa le scadenze a `NotificationService`;
4. aggiorna le notifiche locali esistenti.

Sono presenti due tipi di programmazione:

- **promemoria giornaliero**: vengono preparati fino a 14 giorni in avanti
  all'orario configurato dall'utente, normalmente le 09:00. Per ogni giorno
  viene programmato un promemoria soltanto se la prossima irrigazione di
  almeno una pianta cade esattamente in quel giorno;
- **notifica per pianta**: viene programmata per la singola pianta con il
  relativo identificativo, così l'apertura della notifica può portare al
  dettaglio della pianta.

Le notifiche vengono sincronizzate con il fuso orario locale. Le notifiche
giornaliere senza piante in scadenza vengono cancellate e le notifiche di
piante non più attive vengono rimosse dalla coda locale.

I testi sono:

- terra: messaggio che indica che la pianta ha bisogno di acqua;
- acqua: `È ora di controllare l’acqua di <nome>.`.

Le notifiche di irrigazione non vengono create per le piante archiviate.

## Concimazione

La concimazione usa intervalli fissi indipendenti dal testo descrittivo di
OpenPlantBook:

| Metodo di coltura | Intervallo |
|---|---:|
| Terra | 30 giorni |
| Acqua | 15 giorni |

La card di concimazione:

- mostra l'intervallo;
- calcola la prossima data da `lastFertilizedAt`;
- permette di segnare direttamente la concimazione;
- salva `lastFertilizedAt` e sincronizza la modifica come una normale modifica
  della pianta.

Il testo `careFertilization` può continuare a essere presente nei dati della
cache o nella contribuzione OpenPlantBook, ma non modifica l'intervallo
operativo dell'app.

Attualmente le notifiche locali sono focalizzate sull'irrigazione. La
concimazione viene mostrata e aggiornata nella scheda della pianta, ma non
genera un promemoria locale autonomo.

## Sincronizzazione offline

L'azione di irrigazione o concimazione aggiorna prima Isar, quindi la UI
risponde anche senza rete. La modifica viene inserita nella coda delle
operazioni pendenti e inviata a Firestore quando la sincronizzazione è
disponibile.

La scrittura Firestore usa un aggiornamento con merge. Di conseguenza,
eventuali campi obsoleti già presenti nei documenti remoti non vengono
eliminati automaticamente: la pulizia dei dati remoti deve essere eseguita
separatamente.

## Verifiche manuali

È stato verificato manualmente con l'app aperta che:

- l'azione di irrigazione aggiorna correttamente la pianta;
- l'azione di concimazione aggiorna correttamente la data;
- la configurazione resta coerente con il metodo di coltura;
- le notifiche vengono preparate soltanto quando esiste una scadenza di
  irrigazione.

## Funzionalità escluse

Non fanno parte dell'implementazione attuale:

- irrigazione guidata da meteo o esposizione;
- consigli automatici sulla luce;
- diagnosi AI e stato di salute;
- propagazione;
- storico delle irrigazioni;
- distinzione operativa tra rabbocco e cambio totale;
- misurazioni EC, test del terreno e quantità d'acqua.