import 'package:isar/isar.dart';
import 'package:piantala/core/utils/watering_heuristic.dart';
import 'package:piantala/data/local/collections/species_cache_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/services/local_catalog_service.dart';
import 'package:piantala/data/services/plantbook_cloud_service.dart';

class SpeciesRepositoryImpl {
  SpeciesRepositoryImpl({
    required PlantbookCloudService cloudService,
    required LocalCatalogService localCatalogService,
    Isar? isar,
  })  : _cloudService = cloudService,
        _localCatalogService = localCatalogService,
        _isar = isar ?? IsarService.instance.db;

  final PlantbookCloudService _cloudService;
  final LocalCatalogService _localCatalogService;
  final Isar _isar;

  Future<List<Map<String, dynamic>>> searchSpecies(String query) async {
    const locale = 'it'; // TODO: iniettare tramite LocaleUtils se disponibile

    // 1. Cerca nel catalogo locale (immediato)
    final localResults =
        await _localCatalogService.searchSpecies(query, locale);

    // 2. Cerca nell'API
    final apiResults = await _cloudService.searchSpecies(query);

    // 3. Unione: deduplicazione tramite 'pid'
    final merged = <String, Map<String, dynamic>>{};

    // Inseriamo prima l'API per mappare correttamente al formato atteso
    for (final apiRes in apiResults) {
      final pid = apiRes['pid'] as String? ?? '';
      if (pid.isNotEmpty) {
        // La Cloud Function normalizza già i campi (common_name, scientific_name, default_image)
        merged[pid] = apiRes;
      }
    }

    // Sovrascriviamo con i risultati locali che sono più ricchi
    for (final locRes in localResults) {
      final pid = locRes['pid'] as String? ?? '';
      if (pid.isNotEmpty) {
        merged[pid] = {
          'pid': pid,
          'common_name': locRes['commonName']?[locale] ??
              locRes['commonName']?['en'] ??
              pid,
          'scientific_name': locRes['scientificName'] ?? pid,
          'default_image':
              (locRes['imageUrl'] != null || locRes['imageAsset'] != null)
                  ? {'thumbnail': locRes['imageUrl'] ?? locRes['imageAsset']}
                  : null,
        };
      }
    }

    return merged.values.toList();
  }

  Future<SpeciesCacheCollection> getSpeciesDetails(String pid) async {
    // 1. Check in cache
    final cached = await _isar.speciesCacheCollections
        .filter()
        .apiIdEqualTo(pid)
        .findFirst();

    // Cache valida solo se il commonName è stato effettivamente risolto
    // (non è più il pid grezzo come "pilea peperomioides")
    final cacheIsValid = cached != null &&
        cached.commonName != cached.apiId &&
        cached.commonName != 'Sconosciuto';

    if (cacheIsValid) {
      final now = DateTime.now();
      final age = now.difference(cached.cachedAt).inDays;
      if (age < cached.ttlDays) {
        return cached;
      }
    }

    // 2. Cerca nel catalogo locale
    final localData = await _localCatalogService.getSpeciesDetail(pid);

    // Chiama sempre l'API per avere i dati di cura (min/max lux, temp, ecc.)
    // anche se abbiamo dati locali — così la scheda è sempre completa.
    final apiData = await _cloudService.getSpeciesDetail(pid);

    if (localData == null && apiData == null) {
      // Se fallisce anche l'API (es. 429, no network) usa cache scaduta se esiste
      if (cached != null) return cached;

      // Fallback estremo: record fittizio
      return _createFallbackCache(pid);
    }

    // 3. Costruisci il nuovo oggetto SpeciesCacheCollection unendo le fonti
    const locale = 'it';

    final newCache = SpeciesCacheCollection()
      ..apiId = pid
      // La Cloud Function normalizza già common_name e scientific_name
      ..commonName = (localData?['commonName']?[locale] as String?) ??
          (localData?['commonName']?['en'] as String?) ??
          (apiData?['common_name'] as String?) ??
          pid
      ..scientificName = (localData?['scientificName'] as String?) ??
          (apiData?['scientific_name'] as String?) ??
          pid
      ..family =
          localData?['family'] as String? ?? (apiData?['category'] as String?)
      ..origin =
          apiData?['origin'] as String? ?? localData?['origin'] as String?

      // Irrigazione: usa l'euristica se dai dati API, altrimenti il valore locale
      ..wateringFrequencyDays = localData?['wateringFrequencyDays'] != null
          ? (localData!['wateringFrequencyDays'] as num).toInt()
          : (apiData?['min_soil_moist'] != null
              ? WateringHeuristic.estimateFrequencyDays(
                  (apiData!['min_soil_moist'] as num).toInt(),
                )
              : 7)

      // Valori numerici raw per descrizioni dettagliate nell'UI
      ..lightLuxMin = (apiData?['min_light_lux'] as num?)?.toInt()
      ..lightLuxMax = (apiData?['max_light_lux'] as num?)?.toInt()
      ..lightMmolMin = (apiData?['min_light_mmol'] as num?)?.toInt()
      ..lightMmolMax = (apiData?['max_light_mmol'] as num?)?.toInt()
      ..soilMoistMin = (apiData?['min_soil_moist'] as num?)?.toInt()
      ..soilMoistMax = (apiData?['max_soil_moist'] as num?)?.toInt()
      ..soilEcMin = (apiData?['min_soil_ec'] as num?)?.toInt()
      ..soilEcMax = (apiData?['max_soil_ec'] as num?)?.toInt()

      // Luce: categoria per icona/badge
      ..lightRequirement = _parseLightLux(
        (apiData?['min_light_lux'] as num?)?.toInt(),
        (apiData?['max_light_lux'] as num?)?.toInt(),
      )

      // Umidità: mappatura dalla percentuale ambientale
      ..humidityRequirement = _parseHumidity(
        (apiData?['min_env_humid'] as num?)?.toInt() ??
            (localData?['humidityMin'] as num?)?.toInt(),
      )
      ..temperatureMin = (apiData?['min_temp'] as num?)?.toInt() ??
          (localData?['temperatureMin'] as num?)?.toInt()
      ..temperatureMax = (apiData?['max_temp'] as num?)?.toInt() ??
          (localData?['temperatureMax'] as num?)?.toInt()
      ..needsMisting = false
      ..directSunTolerance = false
      ..droughtTolerant = false
      ..careSoil = apiData?['care_soil'] as String?
      ..careFertilization = apiData?['care_fertilization'] as String?
      ..carePruning = apiData?['care_pruning'] as String?
      ..propagationMethods = []
      ..description = (localData?['description']?[locale] as String?) ??
          (localData?['description']?['en'] as String?)
      ..funFacts = (localData?['careNotes']?[locale] != null)
          ? [localData!['careNotes'][locale] as String]
          : ((localData?['careNotes']?['en'] != null)
              ? [localData!['careNotes']['en'] as String]
              : [])
      // image_url è già normalizzato dalla Cloud Function
      ..imageUrl =
          localData?['imageUrl'] as String? ?? apiData?['image_url'] as String?
      ..thumbnailUrl = localData?['imageAsset'] as String? ??
          localData?['imageUrl'] as String? ??
          apiData?['image_url'] as String?
      ..cachedAt = DateTime.now()
      ..ttlDays = 30;

    if (cached != null) {
      newCache.id = cached.id; // Aggiorniamo l'id per sovrascrivere
    }

    // 4. Salva in Isar
    await _isar.writeTxn(() async {
      await _isar.speciesCacheCollections.put(newCache);
    });

    return newCache;
  }

  SpeciesCacheCollection _createFallbackCache(String pid) {
    return SpeciesCacheCollection()
      ..apiId = pid
      ..commonName = pid
      ..scientificName = pid
      ..wateringFrequencyDays = 7
      ..lightRequirement = 'medium'
      ..humidityRequirement = 'medium'
      ..needsMisting = false
      ..directSunTolerance = false
      ..droughtTolerant = false
      ..cachedAt = DateTime.now()
      ..ttlDays = 1; // Riprova presto
  }

  String _parseLightLux(int? minLux, int? maxLux) {
    if (minLux == null) return 'medium';
    if (minLux >= 5000) return 'direct';
    if (minLux >= 2000) return 'bright_indirect';
    if (maxLux != null && maxLux < 2000) return 'low';
    return 'medium';
  }

  String _parseHumidity(int? minHumid) {
    if (minHumid == null) return 'medium';
    if (minHumid >= 60) return 'high';
    if (minHumid <= 30) return 'low';
    return 'medium';
  }
}
