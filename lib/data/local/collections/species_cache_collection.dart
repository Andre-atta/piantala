import 'package:isar/isar.dart';

part 'species_cache_collection.g.dart';

/// Cache locale per i dati delle specie da OpenPlantBook API.
/// Non ha campi di sync — è una cache globale read-only.
@collection
class SpeciesCacheCollection {
  Id id = Isar.autoIncrement; // ID locale interno

  @Index(unique: true)
  late String apiId; // Corrisponde al pid di OpenPlantBook

  late String commonName;
  late String scientificName;
  String? family;
  String? origin;

  // Care data
  late int wateringFrequencyDays;

  /// low | medium | bright_indirect | direct
  late String lightRequirement;

  // Valori numerici per descrizione dettagliata
  int? lightLuxMin;
  int? lightLuxMax;
  int? soilMoistMin;
  int? soilMoistMax;

  /// low | medium | high
  late String humidityRequirement;

  int? temperatureMin;
  int? temperatureMax;
  late bool needsMisting;
  late bool directSunTolerance;
  late bool droughtTolerant;

  // Info aggiuntive di cura testuali
  String? careSoil;
  String? careFertilization;
  String? carePruning;

  late List<String> propagationMethods;
  String? description;
  late List<String> funFacts;

  // Media
  String? imageUrl;
  String? thumbnailUrl;

  // Valori numerici luce (mmol) — usati dallo SchedulingEngine per idrocultura
  int? lightMmolMin;
  int? lightMmolMax;

  // EC substrato (µS/cm) — usati dallo SchedulingEngine per accumulo sali idro
  int? soilEcMin;
  int? soilEcMax;

  // Cache management
  late DateTime cachedAt;
  late int ttlDays;
}
