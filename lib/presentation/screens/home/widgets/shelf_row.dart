import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/home/care_type.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';
import 'package:piantala/presentation/screens/home/widgets/care_signals.dart';
import 'package:piantala/presentation/screens/home/widgets/plant_name_tag.dart';

class ShelfRow extends StatelessWidget {
  const ShelfRow({
    required this.plants,
    required this.now,
    required this.onPlantTap,
    this.rowHeight = HomeMetrics.shelfRowHeight,
    super.key,
  });

  final List<PlantEntity> plants;
  final DateTime now;
  final ValueChanged<PlantEntity> onPlantTap;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final hasContent = plants.isNotEmpty;

    return SizedBox(
      height: rowHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // — Tavola principale della mensola (spessore verde salvia) —
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: HomeMetrics.shelfBoardHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.sage,
                border: Border(
                  top: BorderSide(
                    color: theme.ink,
                    width: HomeMetrics.shelfBoardBorderWidth,
                  ),
                  bottom: BorderSide(
                    color: theme.ink,
                    width: HomeMetrics.shelfBoardBorderWidth,
                  ),
                ),
              ),
            ),
          ),
          // — Bordo frontale più scuro (faccia anteriore della mensola) —
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: HomeMetrics.shelfFrontEdgeHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.ink.withValues(alpha: 0.12),
              ),
            ),
          ),
          // — Piano superiore verde salvia chiaro —
          Positioned(
            left: 0,
            right: 0,
            bottom: HomeMetrics.shelfBoardHeight,
            height: HomeMetrics.shelfTopHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.shelfTop,
                border: Border(
                  top: BorderSide(
                    color: theme.ink.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          ),
          if (hasContent) ...[
            // — Ombre ellittiche sotto piante/vasi/libri —
            Positioned(
              left: 0,
              right: 0,
              bottom: HomeMetrics.shelfBoardHeight +
                  HomeMetrics.shelfTopHeight -
                  HomeMetrics.shelfOverlap -
                  HomeMetrics.plantShadowHeight / 2,
              height: HomeMetrics.plantShadowHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var index = 0; index < HomeMetrics.plantsPerRow; index++)
                    if (index < plants.length ||
                        (index == plants.length &&
                            plants.length < HomeMetrics.plantsPerRow))
                      SizedBox(
                        width: HomeMetrics.plantImageWidth,
                        child: Center(
                          child: SizedBox(
                            width: HomeMetrics.plantShadowWidth,
                            height: HomeMetrics.plantShadowHeight,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: theme.ink.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(
                                  HomeMetrics.plantShadowHeight / 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      const SizedBox(
                        width: HomeMetrics.plantImageWidth,
                      ),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: HomeMetrics.shelfBoardHeight +
                  HomeMetrics.shelfTopHeight -
                  HomeMetrics.shelfOverlap -
                  HomeMetrics.nameTagHeight,
              height:
                  HomeMetrics.shelfPlantZoneHeight + HomeMetrics.nameTagHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List<Widget>.generate(
                  HomeMetrics.plantsPerRow,
                  (index) {
                    if (index < plants.length) {
                      final plant = plants[index];
                      return _PlantOnShelf(
                        plant: plant,
                        now: now,
                        onTap: () => onPlantTap(plant),
                      );
                    }
                    if (index == plants.length) return const _ShelfBooks();
                    return const SizedBox(
                      width: HomeMetrics.plantImageWidth,
                      height: HomeMetrics.plantImageHeight,
                    );
                  },
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlantOnShelf extends StatelessWidget {
  const _PlantOnShelf({
    required this.plant,
    required this.now,
    required this.onTap,
  });

  final PlantEntity plant;
  final DateTime now;
  final VoidCallback onTap;

  String _displayName(AppLocalizations localizations) {
    if (plant.customName.trim().isNotEmpty) return plant.customName;
    final commonName = plant.speciesCommonName?.trim();
    if (commonName != null && commonName.isNotEmpty) return commonName;
    final scientificName = plant.speciesScientificName?.trim();
    if (scientificName != null && scientificName.isNotEmpty) {
      return scientificName;
    }
    return localizations.homePlantNameFallback;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final localizations = AppLocalizations.of(context)!;
    final cares = dueCares(plant, now);
    final name = _displayName(localizations);
    final semanticValue =
        cares.isEmpty ? null : careSemanticsValue(cares, localizations);
    final asset = PlantAssetResolver.plantAsset(
      plant.canonicalSpeciesSlug,
      water: plant.cultivationMethod == 'hydro',
    );
    final variation = _variationFor(plant.id);
    final image = asset == null
        ? ColoredBox(
            color: theme.sproutGreen.withValues(alpha: 0.35),
            child: Icon(
              Icons.local_florist_outlined,
              size: HomeMetrics.booksHeight / 2,
              color: theme.leafGreen,
            ),
          )
        : Image.asset(
            asset,
            fit: BoxFit.contain,
            alignment: Alignment.bottomCenter,
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: theme.sproutGreen.withValues(alpha: 0.35),
              child: Icon(
                Icons.local_florist_outlined,
                size: HomeMetrics.booksHeight / 2,
                color: theme.leafGreen,
              ),
            ),
          );

    return Semantics(
      key: ValueKey('plant-${plant.id}'),
      button: true,
      label: name,
      value: semanticValue,
      onTap: onTap,
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: HomeMetrics.plantImageWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: HomeMetrics.plantImageWidth,
                height: HomeMetrics.plantImageHeight,
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.diagonal3Values(
                        variation.scaleX,
                        variation.scale,
                        1,
                      )..rotateZ(variation.rotation),
                      child: SizedBox(
                        width: HomeMetrics.plantImageWidth,
                        height: HomeMetrics.plantImageHeight,
                        child: image,
                      ),
                    ),
                    CareSignals(
                      key: ValueKey('care-signals-${plant.id}'),
                      cares: cares,
                    ),
                  ],
                ),
              ),
              PlantNameTag(name: name),
            ],
          ),
        ),
      ),
    );
  }

  _PlantVariation _variationFor(String id) {
    final hash = id.codeUnits.fold<int>(
      17,
      (value, unit) => (value * 31 + unit) & 0x7fffffff,
    );
    final normalizedScale = (hash % 1001) / 1000;
    final normalizedRotation = ((hash ~/ 1001) % 1001) / 1000;
    final scale = HomeMetrics.plantVariationMinScale +
        normalizedScale *
            (HomeMetrics.plantVariationMaxScale -
                HomeMetrics.plantVariationMinScale);
    final rotationDegrees = (normalizedRotation * 2 - 1) *
        HomeMetrics.plantVariationMaxRotationDegrees;

    return _PlantVariation(
      scale: scale,
      scaleX: hash.isEven ? -scale : scale,
      rotation: rotationDegrees * HomeMetrics.degreesToRadians,
    );
  }
}

class _PlantVariation {
  const _PlantVariation({
    required this.scale,
    required this.scaleX,
    required this.rotation,
  });

  final double scale;
  final double scaleX;
  final double rotation;
}

class _ShelfBooks extends StatelessWidget {
  const _ShelfBooks();

  static const _asset = 'assets/svg/home/shelf_books.svg';

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ExcludeSemantics(
        child: SizedBox(
          width: HomeMetrics.plantImageWidth,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: HomeMetrics.nameTagHeight,
            ),
            child: SizedBox(
              height: HomeMetrics.plantImageHeight,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  _asset,
                  width: HomeMetrics.booksWidth,
                  height: HomeMetrics.booksHeight,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
