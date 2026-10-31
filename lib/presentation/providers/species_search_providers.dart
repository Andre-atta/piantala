import 'dart:async';
import 'package:piantala/data/repositories/species_repository_impl.dart';
import 'package:piantala/data/services/local_catalog_service.dart';
import 'package:piantala/data/services/plantbook_cloud_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'species_search_providers.g.dart';

@riverpod
PlantbookCloudService plantbookCloudService(PlantbookCloudServiceRef ref) {
  return PlantbookCloudService();
}

@riverpod
LocalCatalogService localCatalogService(LocalCatalogServiceRef ref) {
  return LocalCatalogService();
}

@riverpod
SpeciesRepositoryImpl speciesRepository(SpeciesRepositoryRef ref) {
  return SpeciesRepositoryImpl(
    cloudService: ref.watch(plantbookCloudServiceProvider),
    localCatalogService: ref.watch(localCatalogServiceProvider),
  );
}

@riverpod
Future<Map<String, dynamic>> speciesDetails(
  SpeciesDetailsRef ref,
  String apiId,
) async {
  final repo = ref.watch(speciesRepositoryProvider);
  final cache = await repo.getSpeciesDetails(apiId);
  return {
    'common_name': cache.commonName,
    'scientific_name': cache.scientificName,
    'imageUrl': cache.imageUrl,
    'wateringFrequencyDays': cache.wateringFrequencyDays,
    'family': cache.family,
    'origin': cache.origin,
    'description': cache.description,
    'lightRequirement': cache.lightRequirement,
    'lightLuxMin': cache.lightLuxMin,
    'lightLuxMax': cache.lightLuxMax,
    'soilMoistMin': cache.soilMoistMin,
    'soilMoistMax': cache.soilMoistMax,
    'humidityRequirement': cache.humidityRequirement,
    'temperatureMin': cache.temperatureMin,
    'temperatureMax': cache.temperatureMax,
    'careSoil': cache.careSoil,
    'careFertilization': cache.careFertilization,
    'carePruning': cache.carePruning,
    'funFacts': cache.funFacts,
  };
}

@Riverpod(keepAlive: true)
class SpeciesSearch extends _$SpeciesSearch {
  Timer? _debounceTimer;

  @override
  AsyncValue<List<Map<String, dynamic>>> build() {
    return const AsyncValue.data([]);
  }

  void search(String query) {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      state = const AsyncValue.data([]);
      return;
    }
    // Non inviare query troppo corte alla Cloud Function (evita 400 Bad Request)
    if (trimmed.length < 3) {
      return;
    }

    state = const AsyncValue.loading();

    // Debounce 300ms
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () async {
      try {
        final repo = ref.read(speciesRepositoryProvider);
        final results = await repo.searchSpecies(query.trim());
        state = AsyncValue.data(results);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    });
  }
}
