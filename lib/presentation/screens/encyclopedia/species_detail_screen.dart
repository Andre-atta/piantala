import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/presentation/providers/species_search_providers.dart';

class SpeciesDetailScreen extends ConsumerWidget {
  const SpeciesDetailScreen({required this.apiId, super.key});
  final String apiId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final detailsAsync = ref.watch(speciesDetailsProvider(apiId));

    return Scaffold(
      body: detailsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Errore: $err')),
        data: (details) {
          final imageUrl = details['imageUrl'] as String?;
          final commonName =
              (details['common_name'] as String?) ?? 'Sconosciuto';
          final scientificName = (details['scientific_name'] as String?) ?? '';
          final wateringFreq =
              details['wateringFrequencyDays']?.toString() ?? '7';
          final lightLabel = _lightLabel(
            details['lightRequirement'] as String?,
            details['lightLuxMin'] as int?,
            details['lightLuxMax'] as int?,
          );
          final humidLabel =
              _humidLabel(details['humidityRequirement'] as String?);
          final soilMoistMin = details['soilMoistMin'] as int?;
          final soilMoistMax = details['soilMoistMax'] as int?;
          final wateringDesc = _wateringDesc(soilMoistMin, soilMoistMax);

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 300,
                backgroundColor: theme.scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    commonName,
                    style: TextStyle(
                      fontFamily: 'DMSerifDisplay',
                      color: imageUrl != null
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                      shadows: imageUrl != null
                          ? const [Shadow(color: Colors.black54, blurRadius: 4)]
                          : null,
                    ),
                  ),
                  background: imageUrl != null
                      ? Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black87,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : ColoredBox(
                          color: theme.colorScheme.primary.withAlpha(20),
                          child: Icon(
                            Icons.eco,
                            size: 100,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                ),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: imageUrl != null
                        ? Colors.white
                        : theme.colorScheme.onSurface,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildSectionHeader(theme, 'Informazioni Scientifiche'),
                    _buildInfoCard(theme, [
                      _InfoRow('Nome Comune', commonName),
                      _InfoRow('Nome Scientifico', scientificName),
                      if ((details['family'] as String?) != null)
                        _InfoRow('Famiglia', details['family'] as String),
                      if ((details['origin'] as String?) != null)
                        _InfoRow('Origine', details['origin'] as String),
                    ]),
                    const SizedBox(height: AppSpacing.lg),
                    _buildSectionHeader(theme, 'Cura e Mantenimento'),
                    _buildInfoCard(theme, [
                      _InfoRow('💧 Innaffiatura',
                          '$wateringFreq giorni\n$wateringDesc'),
                      _InfoRow('☀️ Luce', lightLabel),
                      _InfoRow('💦 Umidità', humidLabel),
                      if (details['temperatureMin'] != null &&
                          details['temperatureMax'] != null)
                        _InfoRow(
                          '🌡️ Temperatura',
                          '${details['temperatureMin']}°C – '
                              '${details['temperatureMax']}°C',
                        ),
                      if (details['careSoil'] != null)
                        _InfoRow('🌱 Terriccio', details['careSoil'] as String),
                      if (details['careFertilization'] != null)
                        _InfoRow('🧪 Concimazione',
                            details['careFertilization'] as String),
                      if (details['carePruning'] != null)
                        _InfoRow(
                            '✂️ Potatura', details['carePruning'] as String),
                    ]),
                    if (details['description'] != null) ...[
                      const SizedBox(height: AppSpacing.lg),
                      _buildSectionHeader(theme, 'Descrizione'),
                      Text(details['description'] as String),
                    ],
                    if (details['funFacts'] != null &&
                        (details['funFacts'] as List).isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.lg),
                      _buildSectionHeader(theme, 'Curiosità'),
                      ...(details['funFacts'] as List).map(
                        (fact) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('💡 ', style: TextStyle(fontSize: 16)),
                              Expanded(child: Text(fact.toString())),
                            ],
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.lg),
                  ]),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Text(
        title,
        style:
            theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoCard(ThemeData theme, List<_InfoRow> rows) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(color: theme.dividerColor.withAlpha(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: rows.map((row) {
            final isLast = row == rows.last;
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        row.label,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        row.value,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                if (!isLast) const Divider(height: 24),
              ],
            );
          }).toList(),
        ),
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

  String _wateringDesc(int? moistMin, int? moistMax) {
    if (moistMin == null) return 'Innaffia quando il terriccio è asciutto.';
    if (moistMax != null && moistMax >= 70) {
      return 'Preferisce terriccio sempre umido; evitare ristagni.';
    }
    if (moistMin <= 15) {
      return "Lascia asciugare bene il terriccio tra un'innaffiatura e l'altra.";
    }
    return 'Innaffia quando il terriccio è parzialmente asciutto '
        '(umidità ideale $moistMin–$moistMax%).';
  }
}

class _InfoRow {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;
}
