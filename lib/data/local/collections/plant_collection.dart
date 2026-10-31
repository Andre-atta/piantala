import 'package:isar/isar.dart';

part 'plant_collection.g.dart';

@collection
class PlantCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String firestoreId;
  @Index()
  late String userId;
  late int syncStatusIndex;
  late DateTime localUpdatedAt;

  @Index()
  late String roomId;
  String? speciesApiId;
  late String customName;
  String? speciesCommonName;
  String? speciesScientificName;
  String? photoUrl;
  String? thumbnailUrl;
  late int shelfPosition;
  WateringConfigIsar? wateringConfig;
  CareConfigIsar? careConfig;
  FertilizingConfigIsar? fertilizingConfig;
  String? cultivationMethod;
  DateTime? acquisitionDate;
  String? notes;
  late List<String> tags;
  late bool isArchived;
  late DateTime createdAt;
}

@embedded
class WateringConfigIsar {
  late int frequencyDays;
  DateTime? lastWateredAt;
}

@embedded
class CareConfigIsar {
  int? fertilizingFrequencyDays;
  DateTime? lastFertilizedAt;
  DateTime? lastRepottedAt;
}

@embedded
class FertilizingConfigIsar {
  late int frequencyDays;
  DateTime? lastFertilizedAt;
}
