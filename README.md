# 🌿 Piantala

> ⚠️ **Nota:** Questa è una repository di showcase per scopi di portfolio. Il codice sorgente completo è mantenuto in una repository privata per tutelare la proprietà intellettuale. Questa pagina illustra l'architettura, lo stack tecnologico e le sfide ingegneristiche affrontate durante lo sviluppo.

## Panoramica del Progetto
**Piantala** è un'applicazione mobile nativa sviluppata in Flutter che si discosta dal concetto di semplice dashboard tecnica. L'obiettivo è fornire un'interfaccia visivamente ispirata a una mensola reale e connessa ai ritmi naturali della giornata, definita "Temporal Mood", che varia colori e luminosità in base al momento (alba, giorno, tramonto, notte)[cite: 20].

## Interfaccia e User Experience (WIP)
L'applicazione è attualmente in fase di revisione UI/UX per maturare l'esperienza visiva, ma l'impostazione logica delle schermate è già definita:

*   **La Mensola Dinamica (Home):** L'interfaccia principale organizza le piante su mensole virtuali, distinguendo visivamente le piante coltivate in vaso (es. "spider plant") da quelle in idrocoltura (es. "Rocco", "pothos" nei barattoli con radici a vista)[cite: 21].
*   **Gestione Cure:** Ogni pianta ha una scheda dettaglio che traccia i parametri botanici (es. "Epipremnum aureum 'Neon'") e gestisce le scadenze critiche, come il prossimo cambio/rabbocco dell'acqua o l'aggiunta della soluzione nutritiva[cite: 22].
*   **Mappatura Stanze:** Le piante sono assegnate a stanze fisiche (es. "camera", "Bagno") di cui viene tracciata l'esposizione solare (es. Sud, Nord-Est) e il numero totale di piante contenute[cite: 23].

*(Inserire qui gli screenshot caricando i file nella cartella `/assets` della repo)*

## Architettura Core: Offline-First
Per garantire che l'app sia sempre reattiva e utilizzabile anche senza connessione, è stata implementata un'architettura rigorosamente Offline-First[cite: 20]:
1.  **Write Path:** Qualsiasi azione dell'utente (es. aggiungere una pianta, registrare un rabbocco) scrive immediatamente i dati sul database locale Isar, aggiornando la UI in tempo reale senza latenza[cite: 20].
2.  **Sync Coda:** L'operazione viene inserita in una coda in background (tramite un `SyncService`) e sincronizzata con Firebase Firestore non appena la connettività torna disponibile[cite: 20].

## Sfide Ingegneristiche e Roadmap Attuale
Il progetto sta affrontando due grandi sfide tecniche per raggiungere la versione stabile:

### 1. Refactoring del Modulo "Enciclopedia" (Migrazione Dati)
Inizialmente, i dati delle specie botaniche venivano forniti tramite la Perenual API[cite: 26]. Attualmente, il servizio è inattivo e impedisce la ricerca delle piante (restituendo "Nessuna specie trovata" per ricerche comuni come "orchidea")[cite: 25].
La roadmap prevede la sostituzione completa del provider con **OpenPlantBook**[cite: 24]. Questo richiede lo sviluppo di un layer di normalizzazione per gestire dati multilingua e mappare correttamente i parametri di cura.

### 2. Dualità Logica: Terra vs. Idrocoltura
Una delle complessità architettoniche principali è la gestione separata dei log di cura. Il sistema deve tradurre i dati standard (generalmente pensati per piante in vaso) e adattare le scadenze e le metriche per le piante coltivate in idrocoltura, che richiedono logiche di rabbocco e fertilizzazione liquida specifiche.

---

## Licenza
Copyright (c) 2026 Andrea. All Rights Reserved.
This repository is for showcase and portfolio purposes only. The architecture descriptions, UI designs, and conceptual workflows presented here may not be copied, distributed, modified, or reused without explicit written permission.

 ---
## Idee future

Funzionalità accantonate:

- irrigazione guidata da meteo ed esposizione, con consigli sulla luce (ad
  esempio “sposta l'orchidea”);
- diagnosi con AI;
- stato di salute;
- propagazione;
- storico delle irrigazioni;
- idrocultura con rabbocco e cambio distinti.