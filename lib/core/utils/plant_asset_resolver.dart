/// Resolver per gli asset illustrativi delle piante e delle stanze.
///
/// Centralizza la logica di risoluzione del path — i widget non conoscono
/// mai direttamente il path dell'asset (.AGENT.md §1.2).
///
/// Naming convention asset (.AGENT.md §8.4):
///   plants/  → `<species_slug>_<substrate>.png|jpg`  (substrate: soil | water)
///   rooms/   → `<room_slug>.png`
abstract class PlantAssetResolver {
  // ── Prefissi ──────────────────────────────────────────────────────────────

  static const _plantsBase = 'assets/illustrations/plants/';
  static const _roomsBase = 'assets/illustrations/rooms/';

  // ── Sfondo parete / stanza ────────────────────────────────────────────────

  /// Restituisce l'asset dello sfondo parete generico (placeholder).
  static String wallBackground() => '${_roomsBase}wall_background.png';

  // ── Immagine pianta ───────────────────────────────────────────────────────

  /// Restituisce il path dell'asset pianta dato lo slug della specie e
  /// il substrato (`soil` oppure `water`).
  ///
  /// Prova prima .png, poi .jpg. Se nessuno dei due è nel catalogo noto,
  /// restituisce `null` — il widget dovrà mostrare il proprio placeholder.
  static String? plantAsset(String speciesSlug, {bool water = false}) {
    final substrate = water ? 'water' : 'soil';
    final candidatePng = '$_plantsBase${speciesSlug}_$substrate.png';
    final candidateJpg = '$_plantsBase${speciesSlug}_$substrate.jpg';
    if (_knownPlantAssets.contains(candidatePng)) return candidatePng;
    if (_knownPlantAssets.contains(candidateJpg)) return candidateJpg;
    return null;
  }

  // ── Catalogo asset noti ───────────────────────────────────────────────────
  //
  // Aggiornare questa lista ogni volta che si aggiunge un asset reale.
  // Il resolver non fa I/O — tutto è risolto a compile-time da questa lista.

  static const _knownPlantAssets = <String>{
    // ── Epipremnum aureum (Pothos) ──
    '${_plantsBase}epipremnum_aureum_water.png',

    // ── Chlorophytum comosum (Spider Plant) ──
    '${_plantsBase}chlorophytum_comosum_water.png',
    '${_plantsBase}chlorophytum_comosum_soil.png',

    // ── Pilea peperomioides ──
    '${_plantsBase}pilea_peperomioides_water.png',
    '${_plantsBase}pilea_peperomioides_soil.png',
  };
}
