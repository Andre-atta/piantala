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

  static DateTime nextFertilizing({
    required DateTime? lastFertilizedAt,
    required int frequencyDays,
  }) {
    return (lastFertilizedAt ?? DateTime.now())
        .add(Duration(days: frequencyDays));
  }
}
