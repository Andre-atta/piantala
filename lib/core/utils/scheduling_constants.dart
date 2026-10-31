abstract class SchedulingConstants {
  static const int soilLowMoistThreshold = 15;
  static const int soilMidMoistThreshold = 30;
  static const int soilDryFreqDays = 14;
  static const int soilMidMoistDays = 7;
  static const int soilWetMoistDays = 4;

  // Fallback values used when OpenPlantBook has no usable care data.
  static const int soilFallbackWateringDays = 7;
  static const int hydroWateringDays = 3;
  static const int soilFertilizingDays = 30;
  static const int hydroFertilizingDays = 15;
}
