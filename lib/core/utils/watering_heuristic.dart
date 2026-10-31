import 'package:piantala/core/utils/scheduling_engine.dart';

/// Euristica per stimare la frequenza di irrigazione in giorni
/// a partire dalla soglia minima di umidità del suolo (%).
///
/// Questo file è mantenuto per retrocompatibilità con le chiamate esistenti
/// in [SpeciesRepositoryImpl]. Tutta la logica è stata spostata in
/// [SchedulingEngine.soilBaseFreqFromMoisture] e [SchedulingConstants].
@Deprecated('Usa SchedulingEngine.soilBaseFreqFromMoisture invece.')
abstract class WateringHeuristic {
  /// Stima la frequenza base di irrigazione in giorni
  /// a partire da [minSoilMoist] (% umidità substrato minima da OpenPlantBook).
  static int estimateFrequencyDays(int minSoilMoist) =>
      SchedulingEngine.soilBaseFreqFromMoisture(minSoilMoist);
}
