import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/domain/repositories/i_plant_repository.dart';
import 'package:piantala/domain/repositories/i_room_repository.dart';
import 'package:piantala/domain/usecases/delete_room_usecase.dart';

class _RoomRepository implements IRoomRepository {
  _RoomRepository(this.events);

  final List<String> events;
  StateError? deleteError;

  @override
  Future<void> addRoom(RoomEntity room) async {}

  @override
  Future<void> deleteRoom(String roomId) async {
    events.add('delete:$roomId');
    if (deleteError case final error?) throw error;
  }

  @override
  Future<void> updateRoom(RoomEntity room) async {}

  @override
  Stream<List<RoomEntity>> watchRooms() => const Stream.empty();
}

class _PlantRepository implements IPlantRepository {
  _PlantRepository(this.events);

  final List<String> events;
  final updatedPlants = <PlantEntity>[];
  StateError? updateError;

  @override
  Future<void> addPlant(PlantEntity plant) async {}

  @override
  Future<void> deletePlant(String plantId) async {}

  @override
  Future<void> updatePlant(PlantEntity plant) async {
    if (updateError case final error?) throw error;
    updatedPlants.add(plant);
    events.add('update:${plant.id}');
  }

  @override
  Stream<PlantEntity?> watchPlant(String plantId) => const Stream.empty();

  @override
  Stream<List<PlantEntity>> watchPlants() => const Stream.empty();
}

PlantEntity _plant(String id, String roomId) => PlantEntity(
      id: id,
      userId: 'user-1',
      roomId: roomId,
      customName: id,
      shelfPosition: 0,
      createdAt: DateTime(2026),
    );

void main() {
  late List<String> events;
  late _RoomRepository roomRepository;
  late _PlantRepository plantRepository;
  late DeleteRoomUseCase useCase;

  setUp(() {
    events = [];
    roomRepository = _RoomRepository(events);
    plantRepository = _PlantRepository(events);
    useCase = DeleteRoomUseCase(
      roomRepository: roomRepository,
      plantRepository: plantRepository,
    );
  });

  test('unassigns matching plants before deleting the room', () async {
    await useCase(
      roomId: 'room-1',
      plants: [
        _plant('in-room-1', 'room-1'),
        _plant('in-room-2', 'room-1'),
        _plant('elsewhere', 'room-2'),
      ],
    );

    expect(plantRepository.updatedPlants, hasLength(2));
    expect(
      plantRepository.updatedPlants.map((plant) => plant.roomId),
      everyElement('unassigned'),
    );
    expect(events, ['update:in-room-1', 'update:in-room-2', 'delete:room-1']);
  });

  test('does not delete the room when unassigning a plant fails', () async {
    plantRepository.updateError = StateError('update failed');

    await expectLater(
      useCase(roomId: 'room-1', plants: [_plant('plant-1', 'room-1')]),
      throwsA(isA<StateError>()),
    );

    expect(events, isEmpty);
  });

  test('propagates a room deletion failure', () async {
    roomRepository.deleteError = StateError('delete failed');

    await expectLater(
      useCase(roomId: 'room-1', plants: const []),
      throwsA(isA<StateError>()),
    );

    expect(events, ['delete:room-1']);
  });

  test('deletes the room when the plant list is empty', () async {
    await useCase(roomId: 'room-1', plants: const []);

    expect(events, ['delete:room-1']);
  });
}
