import 'package:flutter/material.dart';

/// Catalogo degli accenti cromatici per specie — curato manualmente.
///
/// REGOLE (.AGENT.md §8.1 + §8.4):
///   ✅ I colori vivono QUI, non in AppColors (sono scoped alla specie).
///   ✅ Il catalogo è esposto tramite SpeciesAccentProvider — mai letto
///      direttamente nel widget.
///   ❌ MAI promuovere questi colori a colori globali del tema.
///   ❌ MAI applicarli a bottom nav, bottoni, header o colori globali.
///   ✅ Si usano SOLO su dettagli locali della card (bordo, tag, sfondo
///      sfumato leggero).
abstract class SpeciesAccentCatalog {
  /// Restituisce il colore d'accento associato allo slug della specie.
  /// Se la specie non è nel catalogo, restituisce `null` — il widget
  /// usa il fallback dal tema.
  static Color? forSlug(String speciesSlug) =>
      _catalog[speciesSlug.toLowerCase().trim()];

  // ── Catalogo ──────────────────────────────────────────────────────────────
  //
  // Aggiungere una voce per ogni nuova specie con asset dedicato.
  // I colori sono scelti manualmente dalla palette art-direction.md
  // per essere coerenti con il fogliame / vaso della specie.

  static const Map<String, Color> _catalog = {
    // Pothos: variegatura chiara (#C8D46A)
    'epipremnum_aureum': Color(0xFFC8D46A),

    // Fittonia: rosa/rosso (#E2909F)
    'fittonia_albivenis': Color(0xFFE2909F),

    // Pilea: verde base (#4C7A3D)
    'pilea_peperomioides': Color(0xFF4C7A3D),

    // Monstera: verde profondo art-direction.md (#2F5233)
    'monstera_deliciosa': Color(0xFF2F5233),

    // Sansevieria / Snake Plant: verde highlight (#8FBF6B)
    'sansevieria_trifasciata': Color(0xFF8FBF6B),
    'dracaena_trifasciata': Color(0xFF8FBF6B),

    // ZZ Plant: variegatura chiara (#C8D46A)
    'zamioculcas_zamiifolia': Color(0xFFC8D46A),

    // Calathea ornata: strisce rosa (#C16B3E)
    // TODO: ATTENZIONE! #C16B3E è lo stesso colore "Terracotta" riservato ai vasi
    // in art-direction.md. Valutare un colore d'accento diverso (es. un rosa freddo
    // o un verde scuro) per evitare confusione visiva quando gli asset vaso saranno reali.
    'calathea_ornata': Color(0xFFC16B3E),
    'goeppertia_ornata': Color(0xFFC16B3E),
  };
}
