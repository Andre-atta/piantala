import 'package:piantala/data/repositories/room_repository_impl.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/domain/repositories/i_room_repository.dart';
import 'package:piantala/domain/usecases/delete_room_usecase.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'room_providers.g.dart';

@riverpod
IRoomRepository roomRepository(RoomRepositoryRef ref) {
  final user = ref.watch(currentUserProvider);
  return RoomRepositoryImpl(userId: user?.uid);
}

@riverpod
DeleteRoomUseCase deleteRoomUseCase(DeleteRoomUseCaseRef ref) {
  return DeleteRoomUseCase(
    roomRepository: ref.watch(roomRepositoryProvider),
    plantRepository: ref.watch(plantRepositoryProvider),
  );
}

@riverpod
Stream<List<RoomEntity>> rooms(RoomsRef ref) {
  if (ref.watch(currentUserProvider) == null) return Stream.value([]);
  final repository = ref.watch(roomRepositoryProvider);
  return repository.watchRooms();
}

@riverpod
Map<String, int> roomsWithPlantsCount(RoomsWithPlantsCountRef ref) {
  final plants = ref.watch(plantsProvider).valueOrNull ?? [];
  final count = <String, int>{};
  for (final plant in plants) {
    count[plant.roomId] = (count[plant.roomId] ?? 0) + 1;
  }
  return count;
}
