import 'package:piantala/core/utils/scheduling_engine.dart';
import 'package:piantala/domain/entities/plant_entity.dart';

enum CareType { watering, fertilizing }

List<CareType> dueCares(PlantEntity plant, DateTime now) {
  final cares = <CareType>[];
  final watering = plant.wateringConfig;
  if (SchedulingEngine.wateringDateIfDue(
        lastWateredAt: watering?.lastWateredAt,
        frequencyDays: watering?.frequencyDays,
        now: now,
      ) !=
      null) {
    cares.add(CareType.watering);
  }

  final fertilizing = plant.fertilizingConfig;
  if (SchedulingEngine.fertilizingDateIfDue(
        lastFertilizedAt: fertilizing?.lastFertilizedAt,
        frequencyDays: fertilizing?.frequencyDays,
        now: now,
      ) !=
      null) {
    cares.add(CareType.fertilizing);
  }
  return cares;
}
