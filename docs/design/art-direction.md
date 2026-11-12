# Art Direction — Piantala
## Cozy Botanical / Retro Editorial

> Documento di riferimento vincolante per qualunque asset grafico e schermata del progetto (vedi `../../AGENT.md`, sezione 8.4).
> Una casa di piante illustrata, con schede stampate come un erbario d'epoca. Palette ridotta, linee sottili, nessuna ombra, nessuna luce proiettata.

> Stato: i **font sono scelti** (sezione 2.2) ma ancora modificabili. **Icone e illustrazioni non sono ancora decise**: quelle presenti nelle schermate sono segnaposto. Il documento va aggiornato quando saranno scelte.

---

## 1. Palette Colori

Otto colori di base, nient'altro. Poca saturazione, nessun neon, nessuna sfumatura.

### Colori di base

| Nome | HEX | Uso |
|------|-----|-----|
| Verde foglia | `#588157` | Riempimenti dei misuratori (luce, acqua); fogliame medio |
| Verde botanico profondo | `#344E41` | Titoli grandi, icone, bordi attivi, pulsante principale pieno |
| Verde germoglio | `#CDE7B0` | Dettagli chiari; variegatura delle foglie |
| Salvia spenta | `#A3B18A` | Rifiniture sottili, toni intermedi del fogliame |
| Terracotta | `#BE6E46` | Unico accento caldo: vasi, segno attivo, marcatori della temperatura |
| Carta antica | `#F4EBD8` | Superficie delle schede |
| Crema calda | `#FAF7EF` | Fondo schermo, griglia, controlli secondari |
| Inchiostro scuro | `#292D25` | Testo primario e bordi sottili (a opacità 40-55%) |

### Colori di servizio (derivati, non aggiungerne altri)

| Nome | HEX | Uso |
|------|-----|-----|
| Inchiostro morbido | `#3A3E34` | Testo secondario, didascalie |
| Pista del misuratore | `#E6DAC0` | Sfondo di barre e anelli |
| Giallo post-it | `#EFD27A` | Solo il post-it dell'origine |

### Regole sui colori

- **Il caldo è raro.** Terracotta e giallo compaiono in piccoli punti (un segno, una barra, un post-it), mai come superfici.
- **Verde = misura, terracotta = confronto.** Un colore non cambia significato tra schermate.
- **Asset pianta:** il fogliame usa solo i verdi della palette (profondo, foglia, salvia, germoglio). Vasi in terracotta o carta. Il vetro dell'idrocoltura è trasparenza su germoglio a bassa opacità, senza un colore dedicato.
- **Eliminati rispetto alla versione precedente:** tutta la sezione muri e mensole, tutta la sezione ombre e luci ambientali, e i colori dedicati a vasi, vetro e fogliame (`#C16B3E`, `#EDE6D8`, `#C9A46A`, `#BFE3E0`, `#2F5233`, `#4C7A3D`, `#8FBF6B`, `#C8D46A`).

---

## 2. Design Rules

### 2.1 Superfici e forme

- **Nessuna ombra morbida, sfumatura o luce proiettata.** La profondità viene da bordi sottili e da strati di carta.
- Eccezione: I pulsanti tondi (ciottolo) e i dischi icona hanno una base scura sfalsata di 2–4 px e un puntino chiaro; nessuna ombra morbida, nessuna sfumatura, nessuna luce proiettata.
- **Nessuna luce.** Niente fasci, riflessi o sorgenti luminose disegnate. Il volume nasce da variazioni di tono (2-3 toni per forma, dalla palette).
- **Linee.** Nessun contorno nero pieno. Dove serve separazione: linea sottile da 1 px in inchiostro `#292D25` a opacità 40-55%.
- **Forme quasi squadrate.** Schede e post-it a spigolo vivo (0), controlli a 2 px. I cerchi solo per l'anello dell'acqua, la spilla del post-it e i marcatori.
- **Schede come fogli di carta:** bordo da 1 px e cornice interna doppia.
- **Vietati:** neumorfismo, sfumature, neon, vetro smerigliato, grafica aziendale piatta, schede troppo arrotondate, uno sfondo tutto pergamena.
- **Prospettiva sempre frontale**, nessun punto di fuga.

### 2.2 Tipografia

Tre font, tutti da Google Fonts (licenza SIL Open Font License; riverificarla sulla pagina di ciascuno prima della pubblicazione). Scelta provata su schede di prova in Figma: se non convince alla prova in Flutter, si cambia.

| Ruolo | Font | Dove |
|-------|------|------|
| H1 | **Sue Ellen Francisco** | Solo nomi di piante e di stanze: 60 px sul fronte della scheda, 30-32 px sul retro, mai sotto 28 px, verde scuro |
| H2 | **Barriecito** | Microcopy breve: 2-4 parole su una riga, minimo 13 px, al massimo 2-3 per schermata; mai su pulsanti, titoli fissi o dati importanti |
| Testo | **Delius** | Tutto il resto: etichette in maiuscolo con spaziatura, testi da 11 a 13 px, pulsanti, misure. Un solo peso |

**Alternativa provata:** Mogra (H1), Caveat (H2), Delius (testo), per un carattere più forte.

**Uso e limiti**
- Tutti e tre i font si usano **in regular**. Per dare enfasi si usa un grassetto leggero o si ispessisce un po' il tratto; non servono corsivi.
- I nomi scientifici sono in regular, come il resto: niente corsivo.
- Le cifre non sono tabulari: l'effetto di "disordine ordinato" è voluto, fa parte del tono giocoso dell'app.
- Sue Ellen Francisco è sottile e alta: solo per scritte grandi, mai per testo corrente.
- Barriecito è decorativo: solo per testi brevi (es. "scheda di cura", "prossima acqua · 3 nov", origine).
- Delius è l'unico font del testo corrente. Caveat non si usa.
- Minimo 11 pt per qualunque testo; niente etichette da 8-9 px.
- Il testo deve scalare con l'impostazione del sistema (sp in Android, Dynamic Type in iOS); le altezze sono minimi, non valori fissi.
- I font vanno inclusi nell'app come file, non scaricati al volo, così funzionano offline.

### 2.3 Scheda pianta (fronte e retro)

Un'unica famiglia di schede, usata in due modi:

- **Mia pianta (pianta già in collezione).** Fronte: nome dato dall'utente in grande, riquadro con griglia da quaderno e ritaglio PNG della pianta, nome scientifico, striscia di tre fatti (luce, temperatura, umidità), post-it dell'origine in alto a destra, badge di coltivazione. Sotto la scheda, appesi al suo bordo: i segnapagina Annaffia e Concima. Retro: blocchi numerati, etichetta appesa "Vedi in enciclopedia".
- **Enciclopedia (specie).** Stessa struttura, ma con il nome comune della specie e **mai il nome dato dall'utente**. L'immagine è quella di OpenPlantBook (`image_url`), con sfondo rimosso. Retro più descrittivo, con "In breve" e "Curiosità" quando i dati esisteranno. Etichetta appesa "Aggiungi alla mia collezione".
- **Retro a blocchi numerati:** 01 Luce, 02 Acqua, 03 Umidità, 04 Temperatura, 05 Terreno, 06 Concime, 07 Potatura (08 Curiosità nell'enciclopedia). La difficoltà si mostra solo se esiste una fonte affidabile (OpenPlantBook non la fornisce).
- **Dato mancante:** riquadro tratteggiato con "Dato non disponibile per questa specie". Mai valori inventati.
- **Dati di specie e dati della pianta restano separati:** le informazioni di specie non cambiano le scadenze di cura.
- **Foto:** la foto scattata dall'utente resta sulla pianta in collezione; l'enciclopedia usa sempre l'immagine di OpenPlantBook.

### 2.4 Home e navigazione

- Una mensola di legno per stanza con le piante come PNG, davanti a parete e pavimento; lo stato di cura si legge **direttamente sulla pianta**, senza pannelli come "Prossime cure".
- Lo stato "da annaffiare" è un **bastoncino segna-nome piantato nel vaso**, con la data sulla targhetta. Non è un badge.
- Intestazione quasi invisibile: solo i nomi delle stanze e l'indicatore delle pagine. **Nessuna freccia indietro e nessun titolo di schermata nella UI**: i titoli restano nel router e per gli screen reader (Semantics header). Solo la Home mostra i nomi delle stanze.
- La finestra è l'indicatore del ciclo della giornata (vedi sezione 5).
- Barra di navigazione con un pulsante centrale a cartellino di carta che esce dal bordo della barra: è parte della barra, non è un "+" tondo e non è mai una sezione selezionabile. Il suo ruolo cambia solo nelle Stanze: "nuova stanza", con martello e assi. Altrove "nuova pianta", con il vaso.
- Ultima voce della barra: "Profilo" (prima Impostazioni).
- **Stanze:** nessun titolo o pulsante di aggiunta in alto. Le stanze sono una lista di targhe su fogli strappati,
  con disco verde e nome grande; la variante della carta è stabile per stanza. Le opzioni si aprono su un foglio
  crema con le righe Modifica ed Elimina; la conferma di eliminazione usa i cartellini appesi.
- Senza stanze, un solo foglio crema centrato invita a usare il cartellino "nuova stanza" della barra in basso.
- **Bussola delle stanze:** il rilevamento è un quadrante disegnato su carta, con Nord fisso, tacche sottili e ago
  terracotta/crema. L'ago segue la direzione con il percorso più breve; la schermata conferma l'esposizione solo dopo
  tre secondi di stabilità. In assenza del sensore mostra un avviso e permette di annullare, senza proporre una direzione manuale.

### 2.5 Interazione e accessibilità

- Area toccabile minima **48 dp** con almeno 8 dp tra i bersagli, sempre un rettangolo dritto anche se il disegno è inclinato.
- Azioni frequenti reversibili: dopo "Annaffia" compare un messaggio breve con "Annulla".
- **Regola 11 — link nei fogli:** i link sottolineati servono a cambiare modalità e ad aprire l'informativa; le azioni vere restano cartellini.
- La scheda si gira toccandola o con swipe. Nessun pulsante "Gira", né sul fronte né sul retro; l'indizio è un'animazione in codice. Azione accessibile personalizzata "Gira la scheda" per TalkBack/VoiceOver.
- Rispettare `MediaQuery.disableAnimations`.

#### Pulsanti: tutto ciò che si preme è attaccato a qualcosa e obbedisce alla gravità
- **Segnapagina a nastro** (azioni sulla scheda pianta): pende dal bordo inferiore della card, coda a V.
- **Etichetta appesa a due fili** (azioni principali a larghezza piena): due puntine sul bordo della card.
- **Cartellino con filo e puntina** (azioni in dialoghi e in Profilo): pende da una puntina e può oscillare di 1-2°.
- **Puntina** (menu, bussola, cancella): infissa nella superficie.
- **Testo con sottolineatura a mano** (azioni secondarie, es. "Annulla").
- Stato premuto: scende di 2 px e si raddrizza. Disabilitato: perde il riempimento e il bordo pieno.
- Inclinazione del testo al massimo 1°. Nessuno spessore o ombra sotto i pulsanti.
- Eccezione: I pulsanti tondi (ciottolo) e i dischi icona hanno una base scura sfalsata di 2–4 px e un puntino chiaro; nessuna ombra morbida, nessuna sfumatura, nessuna luce proiettata.
- Eccezione ancora aperta: il cartellino centrale della barra ha uno spessore scuro sotto; da decidere se toglierlo.

#### Componenti condivisi per fogli e dialoghi
- **TornPaperSheet:** foglio con bordo inferiore strappato, colori carta a token, righe opzionali e nastro o puntina.
- **HangingTag:** cartellino con filo e puntina per le azioni dei dialoghi, con varianti primaria, secondaria e pericolo.
- **HangingTag largo con logo:** ammette un leading in un cerchietto crema bordato; l'unica eccezione cromatica è il logo Google a colori, come richiesto dalle linee guida Google.
- **PaperTextField:** etichetta maiuscola, testo Delius e sottolineatura verde profondo; errori in terracotta e pulsante SVG accessibile per mostrare/nascondere la password.
- **PaperTextLink:** link Delius sottolineato, senza splash, con bersaglio minimo 48 dp e stato premuto che scende di 2 px.
- **PaperDialogScaffold:** contenitore dei dialoghi su foglio crema; `showPaperDialog` gestisce sfondo e transizione.

Nei componenti carta, la variante warm usa Carta antica (`#F4EBD8`) e la variante light usa Crema calda (`#FAF7EF`); i token globali esistenti restano invariati.

I dialoghi sono un foglio crema appeso con nastro verde e bordo inferiore strappato, sopra la schermata oscurata al 68%.

Le azioni dei dialoghi sono cartellini con filo appesi al bordo del foglio: Salva a destra (verde), Annulla a sinistra (carta, specchiato).

### 2.6 Asset pianta

Le regole di formato, isolamento e varianti sono nella sezione 3 e non cambiano: PNG trasparente, solo pianta e vaso, nessun muro, nessuna mensola, nessuna ombra.

### 2.7 Metafore e materiali

Ogni schermata è un oggetto reale, non una pagina generica.

| Schermata | Metafora | Elementi |
|-----------|----------|----------|
| Home | La stanza | parete, pavimento, mensola, bastoncino nel vaso |
| Mia pianta, Enciclopedia | Scheda di erbario | carta, griglia da quaderno, post-it con puntina, segnapagina |
| Risultati di ricerca | Ritagli di carta irregolari | carta crema, kraft, rigata; bordo inferiore strappato; nastro o puntina; inclinazione di circa 1° |
| Profilo | Bacheca di sughero | polaroid, post-it con l'orario, mappa per la lingua |

- L'irregolarità dei ritagli deriva dall'id della specie, non è casuale a ogni render.
- Gli elementi vanno inventati dagli oggetti (carta, nastro, spago, puntina, legno), non da mobili interi.
- **Colori fuori palette ancora da decidere:** sughero `#C9A678`, cornice bacheca `#A67C52`, post-it `#EFD27A`, legno dei bastoncini `#E8DABB`.
- Idee rimandate: leggio con libro animato per la ricerca; schedario a cassetti; stanze a tema (bagno bianco, cucina rustica). Nessuna decisione presa.

---

## 3. Formato Asset e Varianti

- Formato: **PNG**, sfondo trasparente (non SVG — vedi `../../AGENT.md` §8.4 per il motivo).
- Ogni asset pianta è **isolato**: nessun muro, nessuna mensola, nessuna ombra proiettata nella scena — solo la pianta/vaso, pronta per essere composta sopra lo shelf-UI a runtime.
- Ogni specie con più metodi di coltivazione supportati ha almeno 2 varianti: `soil` e `water`.
- Variazione tra istanze della stessa specie sulla stessa mensola: gestita a runtime (flip orizzontale, scala 95–105%, rotazione ±3°), mai con asset fisici duplicati.

---

## 4. Prompt di Generazione (template)

### Midjourney v6

```
A [SPECIE] plant in a [terracotta pot / clear glass jar hydroponic container with visible
roots underwater], cozy flat vector illustration style, matte cel-shaded coloring, warm
diagonal morning sunlight beams from an off-frame window, soft warm cast shadow on a muted
beige wall behind, textured but flat rendering, rounded soft shapes, no thick black outlines,
gentle rim light on leaf edges, clean centered composition, plain wall background suitable
for a mobile app asset --ar 3:4 --style raw --v 6
```

### DALL·E 3 (variante isolata — asset di produzione)

```
A [SPECIE] plant in a [terracotta pot / clear glass jar hydroponic container with visible
roots underwater], cozy flat vector illustration style, matte cel-shaded coloring, gentle
warm rim light on leaf edges as if lit from upper-left, soft naturalistic color palette.
Isolated product illustration: plain flat neutral background (or transparent), no wall, no
shelf, no cast shadow, no environment — centered composition, ready to be placed on a UI as
a standalone icon asset.
```

> Sostituire `[SPECIE]` e la variante di contenitore per ogni nuovo asset. Testare sempre
> il primo output contro la palette (sezione 1) prima di procedere sulle varianti successive.

---

## 5. Tema temporale

Il tema temporale resta, ed è uno degli elementi distintivi di Piantala.

**Giorno**
Carta chiara, luce naturale, legno caldo.

**Sera**
Parete più scura, luce calda, contrasto leggibile.

La cosa fondamentale è che il tema non deve cambiare soltanto il colore dello sfondo: deve influenzare coerentemente muro, illuminazione, superfici e colori del testo.

> Nota: questa sezione è la funzione "ora del giorno / meteo" ed è rimasta com'era. Le parole "muro" e "illuminazione" qui sopra descrivono l'obiettivo della funzione, non la palette di base (che non ha più muri né luci disegnate).

---

## 6. Accento per pianta (funzione futura)

Non implementata ora: serve come riferimento.

L'idea: nella scheda della pianta e nella scheda dell'enciclopedia, l'accento dipende dalla pianta che si sta guardando.

- Un pothos, prevalentemente verde, dà un accento verde.
- Una fittonia, con le foglie rosate, rende la scheda un po' rosata.
- Un'orchidea bianca fa prevalere il bianco.

Regole da rispettare quando si implementa:

- L'accento colora superfici e segni (fondo carta, barre, marcatori); **testo e inchiostro restano fissi**, per mantenere il contrasto (4,5:1 per il testo normale).
- Gli accenti sono tinte desaturate nello stesso spirito della palette; il colore del singolo asset non deve introdurre nuovi colori di base.
- Due strade da valutare: estrarre il colore dominante dal PNG, oppure un catalogo manuale con un accento per specie (più controllo sul contrasto, più lavoro).
- Casi limite da prevedere: piante quasi bianche o quasi nere, specie con più colori, nessun asset disponibile (fallback sulla palette di base).

---

## 7. Animazione e ora del giorno (TEMPORANEA, DA VERIFICARE)

Idea da provare, non una decisione.

Poiché l'app è in Flutter con Dart: si costruisce la mensola e tutta la scena e si mette in background; sopra si aggiunge un livello con un colore che cambia in base all'ora, in modo che tutta l'interfaccia cambi aspetto durante la giornata.

**Come potrebbe funzionare**
- Uno `Stack` con la scena in fondo e un livello di colore sopra, con un metodo di fusione (per esempio moltiplicazione o luce soffusa).
- Una tabella di colori per fascia oraria, con transizione tra una fascia e la successiva (interpolazione del colore) aggiornata ogni minuto o ogni pochi minuti.
- Con "riduci animazioni" attivo, il cambio avviene senza transizione.

**Perché può funzionare**
- Nessun asset da rigenerare: le PNG restano le stesse.
- È economico da implementare e si combina bene con la finestra della Home.

**Rischi da controllare**
- Un colore uniforme sopra tutto non equivale a un tema coerente: la sezione 5 chiede di cambiare anche superfici e testo.
- Se il livello copre anche schede e testo, il contrasto peggiora, soprattutto di sera.
- Costo di ridisegno su telefoni più vecchi.

**Direzione consigliata da provare:** il livello colorato solo sulla scena (mensola, piante, finestra); schede, testi e pulsanti seguono invece i temi temporali già previsti dall'app, con colori semantici che garantiscano il contrasto.

**Verifiche prima di decidere**
1. Prototipo in Flutter su un telefono reale.
2. Contrasto di testo e icone a ogni fascia oraria.
3. Prestazioni su un telefono di fascia bassa (fotogrammi persi, batteria).
4. Aspetto con le PNG reali sulla scena e con la finestra.

Finché non è verificata, nessun'altra parte del documento dipende da questa idea.

---

*Versione: 2.3.0 — collegato a `../../AGENT.md` §8.4*