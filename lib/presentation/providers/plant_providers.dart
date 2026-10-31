import 'package:piantala/data/repositories/plant_repository_impl.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/repositories/i_plant_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plant_providers.g.dart';

@riverpod
IPlantRepository plantRepository(PlantRepositoryRef ref) {
  return PlantRepositoryImpl();
}

@riverpod
Stream<List<PlantEntity>> plants(PlantsRef ref) {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.watchPlants().map((plants) {
    final sortedPlants = List<PlantEntity>.from(plants)
      ..sort((a, b) => a.shelfPosition.compareTo(b.shelfPosition));
    return sortedPlants;
  });
}

@riverpod
Stream<PlantEntity?> plant(PlantRef ref, String plantId) {
  final repository = ref.watch(plantRepositoryProvider);
  return repository.watchPlant(plantId);
}

@riverpod
List<PlantEntity> overduePlants(OverduePlantsRef ref) {
  // Guardiamo le piante e filtriamo in modo sincrono se il provider ha dei dati
  final plants = ref.watch(plantsProvider).valueOrNull ?? [];
  final now = DateTime.now();

  return plants.where((plant) {
    final config = plant.wateringConfig;
    final nextWatering =
        config?.lastWateredAt?.add(Duration(days: config.frequencyDays));
    if (nextWatering == null) return false;

    // Consideriamo overdue se nextWateringAt è nel passato o lo stesso
    // giorno (ignoriamo l'ora precisa per ora, o contiamo strict)
    // Per strict: nextWatering è passato
    return nextWatering.isBefore(now);
  }).toList();
}
