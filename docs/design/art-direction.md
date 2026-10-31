# Art Direction — Piantala
## Cozy Shelf-UI Style

> Documento di riferimento vincolante per qualunque asset grafico del progetto (vedi `../../.AGENT.md`, sezione 8.4).  
> Vettoriale materico, luce diagonale calda, ombre nette ma morbide.

---

## 1. Palette Colori

### Backgrounds — muri e mensole

| Nome | HEX |
|------|-----|
| Muro, zona in luce | `#EFE9DD` |
| Muro, zona d'ombra | `#C9C4BC` |
| Mensola legno (bordo) | `#A67C52` |
| Mensola legno (piano) | `#C89B6E` |
| Mensola metallo | `#3C3D3F` |

### Ombre e luci ambientali

| Nome | HEX |
|------|-----|
| Highlight solare caldo | `#FDDDA0` |
| Fascio di luce (core) | `#F6C67A` |
| Ombra proiettata (fredda) | `#8C93A0` |
| Ombra ambientale (calda) | `#B7B2A8` |

### Accenti — vasi e fogliame

| Nome | HEX |
|------|-----|
| Terracotta | `#C16B3E` |
| Ceramica chiara | `#EDE6D8` |
| Vaso intrecciato | `#C9A46A` |
| Vetro idrocoltura | `#BFE3E0` |
| Verde profondo | `#2F5233` |
| Verde base | `#4C7A3D` |
| Verde highlight | `#8FBF6B` |
| Variegatura chiara | `#C8D46A` |

> Nota: il layer "ombre e luci ambientali" è pensato per essere separato dagli asset pianta,
> in modo da poter variare in base al tema dinamico ora/meteo senza dover rigenerare gli asset.

---

## 2. Design Rules

**Linee** — Nessun contorno nero pieno. Il volume nasce da variazioni di valore/colore (2–3 toni per forma). Dove serve separazione, linea sottile 1–1.5px marrone scuro desaturato, opacità ~15–20%, mai nero puro.

**Ombre e volumi** — Cel-shading a blocchi netti: colore base + un tono "core shadow" più scuro, bordo dell'ombra leggermente ammorbidito (2–4px). Niente gradienti fotorealistici.

**Illuminazione** — Sorgente sempre diagonale, in alto a sinistra o destra (finestra fuori campo, coerente in tutta l'app), ~30–45°. Fasci caldi su foglie/vasi, ombra proiettata morbida sul muro dietro l'oggetto.

**Vasi terracotta / ceramica** — Fill piatto opaco, fascia d'ombra più scura al bordo superiore, highlight verticale sulla pancia. Texture materiche (intreccio, righe, pois) come pattern vettoriale piatto.

**Vasi idrocoltura** — Contenitore in vetro semi-trasparente; radici semplificate come linee sott'acqua. Linea dell'acqua marcata con streak orizzontale chiaro; leggero shift cromatico dove lo stelo attraversa la superficie.

**Fogliame** — 3–4 gruppi di valore per foglia: ombra propria, base, highlight, rim-light sul bordo controluce. Leggera sovrapposizione tra foglie per dare profondità senza prospettiva 3D reale.

**Architettura shelf-UI** — Prospettiva sempre frontale, nessun punto di fuga. Mensole come bande orizzontali modulari (legno chiaro, metallo, mobile minimal). Pannello muro/luce come livello separato e riutilizzabile.

---

## 3. Formato Asset e Varianti

- Formato: **PNG**, sfondo trasparente (non SVG — vedi `../../.AGENT.md` §8.4 per il motivo).
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

*Versione: 1.0.0 — collegato a `../../.AGENT.md` §8.4*
