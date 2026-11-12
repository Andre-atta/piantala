import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/screens/home/care_type.dart';

void main() {
  final now = DateTime(2026, 11, 9, 12);

  PlantEntity plant({
    WateringConfigEntity? wateringConfig,
    FertilizingConfigEntity? fertilizingConfig,
  }) =>
      PlantEntity(
        id: 'plant-1',
        userId: 'user-1',
        roomId: 'room-1',
        customName: 'Pianta',
        shelfPosition: 0,
        createdAt: DateTime(2026),
        wateringConfig: wateringConfig,
        fertilizingConfig: fertilizingConfig,
      );

  test('returns due care types in watering-then-fertilizing order', () {
    expect(
      dueCares(
        plant(
          wateringConfig: WateringConfigEntity(
            frequencyDays: 7,
            lastWateredAt: DateTime(2026, 11),
          ),
          fertilizingConfig: FertilizingConfigEntity(
            frequencyDays: 30,
            lastFertilizedAt: DateTime(2026, 10),
          ),
        ),
        now,
      ),
      [CareType.watering, CareType.fertilizing],
    );
  });

  test('returns an empty list when no care is due', () {
    expect(dueCares(plant(), now), isEmpty);
    expect(
      dueCares(
        plant(
          wateringConfig: WateringConfigEntity(
            frequencyDays: 7,
            lastWateredAt: DateTime(2026, 11, 3),
          ),
          fertilizingConfig: FertilizingConfigEntity(
            frequencyDays: 30,
            lastFertilizedAt: DateTime(2026, 11),
          ),
        ),
        now,
      ),
      isEmpty,
    );
  });

  test('returns only each independently due care type', () {
    expect(
      dueCares(
        plant(
          wateringConfig: WateringConfigEntity(
            frequencyDays: 1,
            lastWateredAt: DateTime(2026, 11),
          ),
          fertilizingConfig: FertilizingConfigEntity(
            frequencyDays: 30,
            lastFertilizedAt: DateTime(2026, 11),
          ),
        ),
        now,
      ),
      [CareType.watering],
    );
    expect(
      dueCares(
        plant(
          wateringConfig: WateringConfigEntity(
            frequencyDays: 7,
            lastWateredAt: DateTime(2026, 11, 3),
          ),
          fertilizingConfig: FertilizingConfigEntity(
            frequencyDays: 7,
            lastFertilizedAt: DateTime(2026, 11),
          ),
        ),
        now,
      ),
      [CareType.fertilizing],
    );
  });
}
