import 'package:piantala/core/utils/scheduling_constants.dart';

abstract class SchedulingEngine {
  static int soilBaseFreqFromMoisture(int minSoilMoist) {
    if (minSoilMoist < SchedulingConstants.soilLowMoistThreshold) {
      return SchedulingConstants.soilDryFreqDays;
    }
    if (minSoilMoist <= SchedulingConstants.soilMidMoistThreshold) {
      return SchedulingConstants.soilMidMoistDays;
    }
    return SchedulingConstants.soilWetMoistDays;
  }

  static DateTime nextWatering({
    required DateTime? lastWateredAt,
    required int frequencyDays,
  }) {
    return (lastWateredAt ?? DateTime.now()).add(Duration(days: frequencyDays));
  }

  static DateTime? wateringDateIfDue({
    required DateTime? lastWateredAt,
    required int? frequencyDays,
    required DateTime now,
  }) {
    if (lastWateredAt == null || frequencyDays == null) return null;

    final nextWateringAt = nextWatering(
      lastWateredAt: lastWateredAt,
      frequencyDays: frequencyDays,
    );
    final dueDate = DateTime(
      nextWateringAt.year,
      nextWateringAt.month,
      nextWateringAt.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    return dueDate.isAfter(today) ? null : nextWateringAt;
  }

  static DateTime nextFertilizing({
    required DateTime? lastFertilizedAt,
    required int frequencyDays,
  }) {
    return (lastFertilizedAt ?? DateTime.now())
        .add(Duration(days: frequencyDays));
  }

  static DateTime? fertilizingDateIfDue({
    required DateTime? lastFertilizedAt,
    required int? frequencyDays,
    required DateTime now,
  }) {
    if (lastFertilizedAt == null || frequencyDays == null) return null;

    final nextFertilizingAt = nextFertilizing(
      lastFertilizedAt: lastFertilizedAt,
      frequencyDays: frequencyDays,
    );
    final dueDate = DateTime(
      nextFertilizingAt.year,
      nextFertilizingAt.month,
      nextFertilizingAt.day,
    );
    final today = DateTime(now.year, now.month, now.day);
    return dueDate.isAfter(today) ? null : nextFertilizingAt;
  }
}
