import 'package:piantala/domain/entities/plant_entity.dart';

abstract interface class IPlantRepository {
  /// Osserva la lista di tutte le piante dell'utente corrente
  /// (live dalla cache locale Isar).
  Stream<List<PlantEntity>> watchPlants();

  /// Osserva una singola pianta tramite il suo ID.
  Stream<PlantEntity?> watchPlant(String plantId);

  /// Aggiunge una nuova pianta.
  /// Questa operazione deve salvare in locale con status pendingCreate
  /// e accodare la sincronizzazione a Firebase.
  Future<void> addPlant(PlantEntity plant);

  /// Aggiorna una pianta esistente.
  Future<void> updatePlant(PlantEntity plant);

  /// Elimina una pianta.
  Future<void> deletePlant(String plantId);
}
