import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';
import 'package:piantala/domain/entities/plant_entity.dart';

// ── Costanti di layout ─────────────────────────────────────────────────────
const _kShelfHeight = 22.0;
const _kPlantImageHeight = 160.0;
const _kPlantWidth = 100.0;
const _kRowHeight = _kPlantImageHeight + _kShelfHeight + 28.0; // label
const _kPlantsPerRow = 3;

/// Vista a mensola che mostra le piante come oggetti fisici posizionati
/// su una scaffalatura a muro. Le piante "svaligano" fuori dalla mensola
/// grazie a [Clip.none] sullo [Stack] di riga.
///
/// Architettura shelf-UI (art-direction.md §2): prospettiva frontale,
/// mensole come bande orizzontali — nessuna prospettiva 3D.
/// Il path dello sfondo è risolto da [PlantAssetResolver], mai hardcodato
/// nel widget (.AGENT.md §1.2).
class PlantShelfView extends StatelessWidget {
  const PlantShelfView({
    required this.plants,
    super.key,
  });

  final List<PlantEntity> plants;

  @override
  Widget build(BuildContext context) {
    // Partiziona la lista in righe da _kPlantsPerRow
    final rows = <List<PlantEntity>>[];
    for (var i = 0; i < plants.length; i += _kPlantsPerRow) {
      rows.add(
        plants.sublist(i, math.min(i + _kPlantsPerRow, plants.length)),
      );
    }

    final wallBg = PlantAssetResolver.wallBackground();

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Layer base: sfondo parete ──────────────────────────────────
        Image.asset(
          wallBg,
          fit: BoxFit.cover,
          // Se l'asset non fosse caricato (dovrebbe sempre esserlo perché
          // locale), non crasha — mostra un colore piatto dalla palette.
          errorBuilder: (_, __, ___) => const ColoredBox(
            color: Color(0xFFEFE9DD), // Muro, zona in luce — art-direction.md
          ),
        ),

        // ── Layer superiore: righe di mensole ─────────────────────────
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: rows.length,
          padding: const EdgeInsets.only(
            top: AppSpacing.md,
            bottom: AppSpacing.xxl,
          ),
          itemBuilder: (context, index) {
            return _ShelfRow(
              plants: rows[index],
              rowIndex: index,
            );
          },
        ),
      ],
    );
  }
}

// ── _ShelfRow ──────────────────────────────────────────────────────────────

class _ShelfRow extends StatelessWidget {
  const _ShelfRow({
    required this.plants,
    required this.rowIndex,
  });

  final List<PlantEntity> plants;
  final int rowIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Colori mensola che si adattano al tema chiaro/scuro
    final shelfTop = isDark ? const Color(0xFF4A4540) : const Color(0xFFE8E0D4);
    final shelfBottom =
        isDark ? const Color(0xFF2C2822) : const Color(0xFFC8BEB0);

    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.md,
        right: AppSpacing.md,
        bottom: AppSpacing.xl,
      ),
      child: SizedBox(
        // Altezza totale: spazio sopra per le piante che "sporgono" + mensola
        height: _kRowHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            // ── La mensola ──────────────────────────────────────────────
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _ShelfBoard(
                topColor: shelfTop,
                bottomColor: shelfBottom,
                isDark: isDark,
              ),
            ),

            // ── Le piante distribuite sulla mensola ─────────────────────
            Positioned(
              left: 0,
              right: 0,
              bottom: _kShelfHeight - 4, // ancorate sulla faccia superiore
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: plants.map((plant) {
                  return _PlantOnShelf(
                    plant: plant,
                    key: ValueKey(plant.id),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── _ShelfBoard ────────────────────────────────────────────────────────────

class _ShelfBoard extends StatelessWidget {
  const _ShelfBoard({
    required this.topColor,
    required this.bottomColor,
    required this.isDark,
  });

  final Color topColor;
  final Color bottomColor;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _kShelfHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [topColor, bottomColor],
          stops: const [0.0, 1.0],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
        ),
        boxShadow: [
          // Ombra principale proiettata sotto la mensola
          BoxShadow(
            color: Colors.black.withAlpha(isDark ? 100 : 60),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
          // Alone di luce sul bordo superiore
          BoxShadow(
            color: Colors.white.withAlpha(80),
            offset: const Offset(0, -1),
          ),
        ],
      ),
    );
  }
}

// ── _PlantOnShelf ──────────────────────────────────────────────────────────

class _PlantOnShelf extends StatelessWidget {
  const _PlantOnShelf({required this.plant, super.key});

  final PlantEntity plant;

  String get _displayName {
    if (plant.customName.trim().isNotEmpty) return plant.customName;
    if (plant.speciesCommonName?.trim().isNotEmpty ?? false) {
      return plant.speciesCommonName!;
    }
    return 'Pianta';
  }

  bool get _isOverdue {
    final config = plant.wateringConfig;
    final next =
        config?.lastWateredAt?.add(Duration(days: config.frequencyDays));
    return next != null && next.isBefore(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/plants/${plant.id}'),
      child: SizedBox(
        width: _kPlantWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // ── Immagine scontornata ──────────────────────────────────
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topRight,
              children: [
                _PlantImage(
                  speciesSlug: plant.canonicalSpeciesSlug,
                  isHydro: plant.cultivationMethod == 'hydro',
                  height: _kPlantImageHeight,
                  width: _kPlantWidth,
                ),
                // Badge acqua se in ritardo
                if (_isOverdue)
                  Positioned(
                    top: -4,
                    right: -4,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.info,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(60),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.water_drop,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            // ── Etichetta nome ────────────────────────────────────────
            Container(
              width: _kPlantWidth,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(130),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Text(
                _displayName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── _PlantImage ────────────────────────────────────────────────────────────
//
// Ordine di priorità per SHELF VIEW:
//   1. PlantAssetResolver.plantAsset() — illustrazione locale per specie
//   2. _Placeholder — widget geometrico generico
// NOTA: La shelf view non usa MAI le foto reali dell'utente (photoUrl).

class _PlantImage extends StatelessWidget {
  const _PlantImage({
    required this.speciesSlug,
    required this.isHydro,
    required this.height,
    required this.width,
  });

  final String speciesSlug;
  final bool isHydro;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 1. Illustrazione placeholder locale (se presente nel catalogo asset)
    final localAsset =
        PlantAssetResolver.plantAsset(speciesSlug, water: isHydro);
    if (localAsset != null) {
      return Image.asset(
        localAsset,
        height: height,
        width: width,
        fit: BoxFit.contain,
        alignment: Alignment.bottomCenter,
        // errorBuilder per sicurezza — non deve mai crahsare offline
        errorBuilder: (_, __, ___) => _Placeholder(
          height: height,
          width: width,
          theme: theme,
        ),
      );
    }

    // 2. Placeholder generico
    return _Placeholder(height: height, width: width, theme: theme);
  }
}

// ── _Placeholder ───────────────────────────────────────────────────────────

class _Placeholder extends StatelessWidget {
  const _Placeholder({
    required this.height,
    required this.width,
    required this.theme,
  });

  final double height;
  final double width;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width * 0.7,
            height: height * 0.85,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(18),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(
              Icons.local_florist_outlined,
              size: 40,
              color: theme.colorScheme.primary.withAlpha(80),
            ),
          ),
        ],
      ),
    );
  }
}
