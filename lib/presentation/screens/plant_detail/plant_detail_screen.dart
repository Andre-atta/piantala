import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/species_search_providers.dart';
import 'package:piantala/presentation/screens/plant_detail/widgets/edit_plant_dialog.dart';
import 'package:piantala/presentation/screens/plant_detail/widgets/fertilizing_action_card.dart';
import 'package:piantala/presentation/screens/plant_detail/widgets/watering_action_card.dart';
import 'package:piantala/presentation/widgets/opb_contribution_sheet.dart';

class PlantDetailScreen extends ConsumerWidget {
  const PlantDetailScreen({required this.plantId, super.key});
  final String plantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantAsync = ref.watch(plantProvider(plantId));
    final theme = Theme.of(context);

    return Scaffold(
      body: plantAsync.when(
        data: (plant) {
          if (plant == null) {
            return const Center(child: Text('Pianta non trovata'));
          }

          final imageUrl = plant.photoUrl ?? plant.thumbnailUrl;
          final displayName = plant.customName.isNotEmpty
              ? plant.customName
              : plant.speciesCommonName ?? 'Pianta Sconosciuta';

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350,
                pinned: true,
                stretch: true,
                flexibleSpace: FlexibleSpaceBar(
                  stretchModes: const [
                    StretchMode.zoomBackground,
                    StretchMode.blurBackground,
                  ],
                  title: Text(
                    displayName,
                    style: TextStyle(
                      fontFamily: 'DMSerifDisplay',
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withAlpha(150),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (imageUrl != null && imageUrl.isNotEmpty)
                        CachedNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: theme.colorScheme.surfaceContainerHighest,
                          ),
                          errorWidget: (context, url, error) =>
                              _buildPlaceholder(theme),
                        )
                      else
                        _buildPlaceholder(theme),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withAlpha(50),
                              Colors.black.withAlpha(180),
                            ],
                            stops: const [0.4, 0.7, 1],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withAlpha(100),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => context.pop(),
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withAlpha(100),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) => EditPlantDialog(plant: plant),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    WateringActionCard(plant: plant),
                    const SizedBox(height: AppSpacing.md),
                    FertilizingActionCard(plant: plant),
                    const SizedBox(height: AppSpacing.lg),
                    _buildInfoSection(context, theme, plant),
                    if (plant.speciesApiId != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      _PlantCareApiSection(plant: plant),
                    ],
                  ]),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Errore: $err')),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.primary.withAlpha(20),
      child: Center(
        child: Icon(
          Icons.local_florist,
          size: 100,
          color: theme.colorScheme.primary.withAlpha(100),
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    ThemeData theme,
    PlantEntity plant,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        side:
            BorderSide(color: theme.colorScheme.outlineVariant.withAlpha(100)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Informazioni Botaniche',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            if (plant.speciesScientificName != null)
              _buildInfoRow(
                theme,
                'Nome Scientifico',
                plant.speciesScientificName!,
              ),
            if (plant.speciesCommonName != null)
              _buildInfoRow(theme, 'Nome Comune', plant.speciesCommonName!),
            _buildInfoRow(
              theme,
              'Coltivazione',
              plant.cultivationMethod == 'hydro'
                  ? '💧 Idrocoltura'
                  : '🪴 In terra',
            ),
            if (plant.notes != null && plant.notes!.isNotEmpty) ...[
              const Divider(),
              Text(
                'Note',
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(plant.notes!),
            ],
            if (plant.speciesApiId == null) ...[
              const Divider(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    OpbContributionSheet.show(
                      context,
                      userId: plant.userId,
                      plant: plant,
                      prefillPid:
                          plant.speciesScientificName ?? plant.customName,
                    );
                  },
                  icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                  label: const Text('Condividi su OpenPlantBook'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlantCareApiSection extends ConsumerWidget {
  const _PlantCareApiSection({required this.plant});
  final PlantEntity plant;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final apiId = plant.speciesApiId!;
    final asyncDetails = ref.watch(speciesDetailsProvider(apiId));

    return asyncDetails.when(
      data: (details) {
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
            side: BorderSide(
              color: theme.colorScheme.outlineVariant.withAlpha(100),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cura (OpenPlantBook)',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                _buildInfoRow(
                  theme,
                  '☀️ Luce',
                  _lightLabel(
                    details['lightRequirement'] as String?,
                    details['lightLuxMin'] as int?,
                    details['lightLuxMax'] as int?,
                  ),
                ),
                _buildInfoRow(
                  theme,
                  '💦 Umidità',
                  _humidLabel(details['humidityRequirement'] as String?),
                ),
                if (details['temperatureMin'] != null &&
                    details['temperatureMax'] != null)
                  _buildInfoRow(
                    theme,
                    '🌡️ Temperatura',
                    '${details['temperatureMin']}°C – ${details['temperatureMax']}°C',
                  ),
                if (details['careSoil'] != null)
                  _buildInfoRow(
                    theme,
                    '🌱 Terriccio',
                    details['careSoil'] as String,
                  ),
                if (details['careFertilization'] != null)
                  _buildInfoRow(
                    theme,
                    '🧪 Concimazione',
                    details['careFertilization'] as String,
                  ),
                if (details['carePruning'] != null)
                  _buildInfoRow(
                    theme,
                    '✂️ Potatura',
                    details['carePruning'] as String,
                  ),
                const Divider(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () {
                      OpbContributionSheet.show(
                        context,
                        userId: plant.userId,
                        plant: plant,
                        existingPid: apiId,
                        prefillPid: details['scientificName'] as String? ??
                            plant.speciesScientificName,
                      );
                    },
                    icon: const Icon(Icons.edit_note, size: 18),
                    label: const Text('Proponi una correzione'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SizedBox.shrink(),
    );
  }

  Widget _buildInfoRow(ThemeData theme, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _lightLabel(String? category, int? luxMin, int? luxMax) {
    if (luxMin != null && luxMax != null) {
      if (luxMin >= 5000) return 'Luce diretta ($luxMin–$luxMax lux)';
      if (luxMin >= 2000) return 'Luce indiretta intensa ($luxMin–$luxMax lux)';
      if (luxMax < 1000) return "Mezz'ombra ($luxMin–$luxMax lux)";
      return 'Luce indiretta ($luxMin–$luxMax lux)';
    }
    return switch (category) {
      'direct' => 'Luce diretta',
      'bright_indirect' => 'Luce indiretta intensa',
      'low' => "Poca luce / mezz'ombra",
      _ => 'Luce indiretta',
    };
  }

  String _humidLabel(String? category) => switch (category) {
        'high' => 'Alta (>60%) – nebulizzare regolarmente',
        'low' => 'Bassa (<40%) – tollera aria secca',
        _ => 'Media (40–60%)',
      };
}
