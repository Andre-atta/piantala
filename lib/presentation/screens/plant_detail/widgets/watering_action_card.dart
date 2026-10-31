import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';

class WateringActionCard extends ConsumerWidget {
  const WateringActionCard({required this.plant, super.key});
  final PlantEntity plant;

  Future<void> _water(BuildContext context, WidgetRef ref) async {
    final config = plant.wateringConfig ??
        WateringConfigEntity(
          frequencyDays: plant.cultivationMethod == 'hydro' ? 3 : 7,
        );
    await ref.read(plantRepositoryProvider).updatePlant(
          plant.copyWith(
            wateringConfig: config.copyWith(lastWateredAt: DateTime.now()),
          ),
        );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(plant.cultivationMethod == 'hydro'
              ? 'Acqua controllata!'
              : 'Pianta innaffiata!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHydro = plant.cultivationMethod == 'hydro';
    final config = plant.wateringConfig;
    final next =
        config?.lastWateredAt?.add(Duration(days: config.frequencyDays));
    final overdue = next != null && next.isBefore(DateTime.now());
    return Card(
      color: (overdue ? AppColors.warning : AppColors.info).withAlpha(20),
      child: ListTile(
        leading: Icon(isHydro ? Icons.science_outlined : Icons.water_drop),
        title: Text(overdue
            ? (isHydro ? 'Controlla l’acqua' : 'Richiede acqua')
            : (isHydro ? 'Prossimo controllo acqua' : 'Prossima innaffiatura')),
        subtitle: Text(next == null
            ? 'Ogni ${config?.frequencyDays ?? (isHydro ? 3 : 7)} giorni'
            : 'Prossima: ${DateFormat('dd MMM yyyy').format(next)}'),
        trailing: IconButton(
          onPressed: () => _water(context, ref),
          icon: const Icon(Icons.check),
          tooltip: 'Segna come fatto',
        ),
      ),
    );
  }
}
