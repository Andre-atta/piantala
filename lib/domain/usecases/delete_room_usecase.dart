import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/repositories/i_plant_repository.dart';
import 'package:piantala/domain/repositories/i_room_repository.dart';

class DeleteRoomUseCase {
  const DeleteRoomUseCase({
    required IRoomRepository roomRepository,
    required IPlantRepository plantRepository,
  })  : _roomRepository = roomRepository,
        _plantRepository = plantRepository;

  final IRoomRepository _roomRepository;
  final IPlantRepository _plantRepository;

  Future<void> call({
    required String roomId,
    required Iterable<PlantEntity> plants,
  }) async {
    for (final plant in plants) {
      if (plant.roomId == roomId) {
        await _plantRepository.updatePlant(
          plant.copyWith(roomId: 'unassigned'),
        );
      }
    }

    await _roomRepository.deleteRoom(roomId);
  }
}
