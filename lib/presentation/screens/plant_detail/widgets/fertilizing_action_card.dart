import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';

class FertilizingActionCard extends ConsumerWidget {
  const FertilizingActionCard({required this.plant, super.key});
  final PlantEntity plant;

  Future<void> _fertilize(BuildContext context, WidgetRef ref) async {
    final days = plant.cultivationMethod == 'hydro' ? 15 : 30;
    final config =
        plant.fertilizingConfig ?? FertilizingConfigEntity(frequencyDays: days);
    await ref.read(plantRepositoryProvider).updatePlant(
          plant.copyWith(
            fertilizingConfig:
                config.copyWith(lastFertilizedAt: DateTime.now()),
          ),
        );
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Concimazione segnata!'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final days = plant.cultivationMethod == 'hydro' ? 15 : 30;
    final config = plant.fertilizingConfig;
    final next =
        config?.lastFertilizedAt?.add(Duration(days: config.frequencyDays));
    return Card(
      color: AppColors.success.withAlpha(15),
      child: ListTile(
        leading: const Icon(Icons.compost),
        title: const Text('Concimazione'),
        subtitle: Text(next == null
            ? 'Ogni ${config?.frequencyDays ?? days} giorni'
            : 'Prossima: ${DateFormat('dd MMM yyyy').format(next)}'),
        trailing: IconButton(
          onPressed: () => _fertilize(context, ref),
          icon: const Icon(Icons.check),
          tooltip: 'Segna come fatto',
        ),
      ),
    );
  }
}
