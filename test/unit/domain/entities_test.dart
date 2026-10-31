import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';

void main() {
  test('PlantEntity serializza e deserializza', () {
    final plant = PlantEntity(
      id: 'plant1',
      userId: 'user1',
      roomId: 'room1',
      customName: 'Ficus',
      shelfPosition: 0,
      createdAt: DateTime(2023),
      tags: ['green'],
      wateringConfig: const WateringConfigEntity(frequencyDays: 7),
    );
    expect(PlantEntity.fromJson(plant.toJson()), plant);
  });

  test('canonicalSpeciesSlug rimuove la cultivar', () {
    final plant = PlantEntity(
      id: 'x',
      userId: 'u',
      roomId: 'r',
      customName: 'test',
      shelfPosition: 0,
      createdAt: DateTime(2024),
      speciesScientificName: "Epipremnum aureum 'Neon'",
    );
    expect(plant.canonicalSpeciesSlug, 'epipremnum_aureum');
  });

  test('RoomEntity serializza e deserializza', () {
    final room = RoomEntity(
      id: 'room1',
      userId: 'user1',
      name: 'Salotto',
      exposure: 'S',
      createdAt: DateTime(2023),
    );
    expect(RoomEntity.fromJson(room.toJson()), room);
  });
}
