import 'package:piantala/domain/entities/room_entity.dart';

abstract interface class IRoomRepository {
  /// Osserva la lista di tutte le stanze dell'utente corrente.
  Stream<List<RoomEntity>> watchRooms();

  /// Aggiunge una nuova stanza.
  Future<void> addRoom(RoomEntity room);

  /// Aggiorna una stanza esistente.
  Future<void> updateRoom(RoomEntity room);

  /// Elimina una stanza.
  Future<void> deleteRoom(String roomId);
}
