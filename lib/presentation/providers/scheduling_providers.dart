import 'package:piantala/core/utils/scheduling_constants.dart';
import 'package:piantala/core/utils/scheduling_engine.dart';
import 'package:piantala/data/local/collections/species_cache_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'scheduling_providers.g.dart';

class SchedulingResult {
  const SchedulingResult({
    required this.plantId,
    required this.plantName,
    required this.cultivationMethod,
    required this.nextWateringAt,
    required this.nextFertilizingAt,
  });

  final String plantId;
  final String plantName;
  final String cultivationMethod;
  final DateTime nextWateringAt;
  final DateTime nextFertilizingAt;
}

class PlantSchedulingInfo {
  const PlantSchedulingInfo({
    required this.plantId,
    required this.plantName,
    required this.cultivationMethod,
    required this.nextWateringAt,
    required this.nextFertilizingAt,
  });

  final String plantId;
  final String plantName;
  final String cultivationMethod;
  final DateTime nextWateringAt;
  final DateTime nextFertilizingAt;
}

@riverpod
SchedulingResult? plantSchedule(PlantScheduleRef ref, String plantId) {
  final plant = ref.watch(plantProvider(plantId)).valueOrNull;
  if (plant == null) return null;

  SpeciesCacheCollection? speciesCache;
  if (plant.speciesApiId != null) {
    speciesCache =
        IsarService.instance.db.speciesCacheCollections.getByApiIdSync(
      plant.speciesApiId!,
    );
  }

  final isHydro = plant.cultivationMethod == 'hydro';
  final wateringDays = isHydro
      ? SchedulingConstants.hydroWateringDays
      : speciesCache?.wateringFrequencyDays == null
          ? SchedulingConstants.soilFallbackWateringDays
          : speciesCache!.wateringFrequencyDays;
  final fertilizingDays = isHydro
      ? SchedulingConstants.hydroFertilizingDays
      : SchedulingConstants.soilFertilizingDays;

  return SchedulingResult(
    plantId: plant.id,
    plantName: plant.customName.isNotEmpty ? plant.customName : 'Pianta',
    cultivationMethod: plant.cultivationMethod,
    nextWateringAt: SchedulingEngine.nextWatering(
      lastWateredAt: plant.wateringConfig?.lastWateredAt,
      frequencyDays: wateringDays,
    ),
    nextFertilizingAt: SchedulingEngine.nextFertilizing(
      lastFertilizedAt: plant.fertilizingConfig?.lastFertilizedAt,
      frequencyDays: fertilizingDays,
    ),
  );
}
