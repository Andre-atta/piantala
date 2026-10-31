import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/providers/species_accent_providers.dart';

/// Card pianta per viste a griglia / lista.
///
/// Il colore d'accento di specie (Feature 2) viene letto da
/// [speciesAccentColorProvider] tramite [ref] — mai dal catalogo
/// direttamente. È applicato SOLO al bordo della card; non tocca
/// bottom nav, bottoni, header o qualsiasi colore globale del tema
/// (.AGENT.md §8.1).
class PlantShelfCard extends ConsumerWidget {
  const PlantShelfCard({
    required this.plant,
    super.key,
    this.onTap,
  });

  final PlantEntity plant;
  final VoidCallback? onTap;

  String get _displayName {
    if (plant.customName.trim().isNotEmpty) {
      return plant.customName;
    }
    if (plant.speciesCommonName != null &&
        plant.speciesCommonName!.trim().isNotEmpty) {
      return plant.speciesCommonName!;
    }
    if (plant.speciesScientificName != null &&
        plant.speciesScientificName!.trim().isNotEmpty) {
      return plant.speciesScientificName!;
    }
    return 'Pianta senza nome';
  }

  bool get _isOverdue {
    final config = plant.wateringConfig;
    final nextWatering =
        config?.lastWateredAt?.add(Duration(days: config.frequencyDays));
    if (nextWatering == null) return false;
    return nextWatering.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final imageUrl = plant.thumbnailUrl ?? plant.photoUrl;

    // Colore d'accento dalla specie (può essere null se non in catalogo).
    // Usato SOLO sul bordo della card.
    final slug = plant.canonicalSpeciesSlug;
    final accentColor =
        slug.isNotEmpty ? ref.watch(speciesAccentColorProvider(slug)) : null;

    // Il bordo usa l'accento se disponibile, altrimenti il bordo neutro del tema.
    final borderColor = accentColor != null
        ? accentColor.withAlpha(160)
        : theme.colorScheme.onSurface.withAlpha(20);
    final borderWidth = accentColor != null ? 1.5 : 1.0;

    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Sfondo immagine o placeholder
            if (imageUrl != null && imageUrl.isNotEmpty)
              CachedNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => ColoredBox(
                  color: theme.colorScheme.surfaceContainerHighest,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => _buildPlaceholder(theme),
              )
            else
              _buildPlaceholder(theme),

            // Sfumatura in basso per leggibilità testo
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withAlpha(50),
                      Colors.black.withAlpha(180),
                    ],
                    stops: const [0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            // Badge in alto a destra
            if (_isOverdue)
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.info.withAlpha(230),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),

            // Testo in basso
            Positioned(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _displayName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontFamily: 'DMSerifDisplay',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return ColoredBox(
      color: theme.colorScheme.primary.withAlpha(20),
      child: Center(
        child: Icon(
          Icons.local_florist,
          size: 48,
          color: theme.colorScheme.primary.withAlpha(100),
        ),
      ),
    );
  }
}
