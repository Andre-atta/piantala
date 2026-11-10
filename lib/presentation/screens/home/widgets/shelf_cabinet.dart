import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';
import 'package:piantala/presentation/screens/home/widgets/shelf_row.dart';

class ShelfCabinet extends StatelessWidget {
  const ShelfCabinet({
    required this.plants,
    required this.now,
    required this.onPlantTap,
    super.key,
  });

  static const _vineAsset = 'assets/svg/home/vine_trailing.svg';

  final List<PlantEntity> plants;
  final DateTime now;
  final ValueChanged<PlantEntity> onPlantTap;

  List<List<PlantEntity>> _rows() {
    return [
      for (var start = 0;
          start < plants.length;
          start += HomeMetrics.plantsPerRow)
        plants
            .skip(start)
            .take(HomeMetrics.plantsPerRow)
            .toList(growable: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final rows = _rows();

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: HomeMetrics.cabinetSideMargin,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: Column(
              children: [
                const SizedBox(height: HomeMetrics.cabinetCrossbarHeight),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        left: HomeMetrics.cabinetPostWidth,
                        right: HomeMetrics.cabinetPostWidth,
                        child: ColoredBox(color: theme.paper),
                      ),
                      Positioned.fill(
                        left: HomeMetrics.cabinetPostWidth,
                        right: HomeMetrics.cabinetPostWidth,
                        bottom: HomeMetrics.cabinetBottomCrossbarHeight,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              for (final row in rows)
                                ShelfRow(
                                  plants: row,
                                  now: now,
                                  onPlantTap: onPlantTap,
                                ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: HomeMetrics.cabinetBottomCrossbarHeight,
                        width: HomeMetrics.cabinetPostWidth,
                        child: _CabinetBoard(
                          fill: theme.sage,
                          stroke: theme.ink,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: HomeMetrics.cabinetBottomCrossbarHeight,
                        width: HomeMetrics.cabinetPostWidth,
                        child: _CabinetBoard(
                          fill: theme.sage,
                          stroke: theme.ink,
                        ),
                      ),
                      Positioned(
                        left: HomeMetrics.cabinetPostWidth,
                        right: HomeMetrics.cabinetPostWidth,
                        bottom: 0,
                        height: HomeMetrics.cabinetBottomCrossbarHeight,
                        child: _CabinetBoard(
                          fill: theme.sage,
                          stroke: theme.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: -HomeMetrics.cabinetCrossbarOverhang,
            right: -HomeMetrics.cabinetCrossbarOverhang,
            top: 0,
            height: HomeMetrics.cabinetCrossbarHeight,
            child: _CabinetBoard(
              fill: theme.sage,
              stroke: theme.ink,
            ),
          ),
          Positioned(
            left: HomeMetrics.cabinetFootInset,
            bottom: 0,
            width: HomeMetrics.cabinetFootWidth,
            height: HomeMetrics.cabinetFootHeight,
            child: _CabinetBoard(
              fill: theme.sage,
              stroke: theme.ink,
            ),
          ),
          Positioned(
            right: HomeMetrics.cabinetFootInset,
            bottom: 0,
            width: HomeMetrics.cabinetFootWidth,
            height: HomeMetrics.cabinetFootHeight,
            child: _CabinetBoard(
              fill: theme.sage,
              stroke: theme.ink,
            ),
          ),
          Positioned(
            right: HomeMetrics.vineRight,
            top: HomeMetrics.vineTop,
            width: HomeMetrics.vineWidth,
            height: HomeMetrics.vineHeight,
            child: IgnorePointer(
              child: ExcludeSemantics(
                child: SvgPicture.asset(_vineAsset),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CabinetBoard extends StatelessWidget {
  const _CabinetBoard({
    required this.fill,
    required this.stroke,
  });

  final Color fill;
  final Color stroke;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(
          color: stroke,
          width: AppStroke.line,
        ),
      ),
    );
  }
}
