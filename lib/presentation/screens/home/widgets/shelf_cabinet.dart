import 'dart:math' as math;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_ui/material_ui.dart';
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
    const topBeamHeight = HomeMetrics.cabinetCrossbarHeight;
    const bottomBeamHeight = HomeMetrics.cabinetBottomBeamHeight;
    const footHeight = HomeMetrics.cabinetFootHeight;

    return LayoutBuilder(
      builder: (context, constraints) {
        final cabinetHeight = constraints.maxHeight;
        final shelfViewportHeight =
            cabinetHeight > topBeamHeight + bottomBeamHeight + footHeight
                ? cabinetHeight - topBeamHeight - bottomBeamHeight - footHeight
                : 0.0;

        final minRowsToFill =
            (shelfViewportHeight / HomeMetrics.shelfRowHeight).floor();
        final visibleRowsCount = math.max(
          rows.length,
          math.max(1, minRowsToFill),
        );

        final fitsWithoutScroll = rows.length <= minRowsToFill;
        final rowHeight = fitsWithoutScroll && visibleRowsCount > 0
            ? shelfViewportHeight / visibleRowsCount
            : HomeMetrics.shelfRowHeight;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: HomeMetrics.cabinetSideMargin,
          ),
          child: SizedBox(
            height: cabinetHeight,
            child: Stack(
              key: const ValueKey('shelf-cabinet-frame'),
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  left: HomeMetrics.cabinetPostWidth,
                  right: HomeMetrics.cabinetPostWidth,
                  top: topBeamHeight,
                  bottom: bottomBeamHeight + footHeight,
                  child: CustomPaint(
                    painter: _CabinetBackdropPainter(
                      baseColor: theme.cabinetBack,
                      inkColor: theme.ink,
                    ),
                  ),
                ),
                Positioned(
                  left: HomeMetrics.cabinetPostWidth,
                  top: topBeamHeight,
                  bottom: bottomBeamHeight + footHeight,
                  width: HomeMetrics.cabinetSideWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.cabinetSide,
                      border: Border(
                        right: BorderSide(
                          color: theme.ink.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: HomeMetrics.cabinetPostWidth,
                  top: topBeamHeight,
                  bottom: bottomBeamHeight + footHeight,
                  width: HomeMetrics.cabinetSideWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.cabinetSide,
                      border: Border(
                        left: BorderSide(
                          color: theme.ink.withValues(alpha: 0.35),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: HomeMetrics.cabinetPostWidth,
                  right: HomeMetrics.cabinetPostWidth,
                  top: topBeamHeight,
                  height: shelfViewportHeight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var i = 0; i < visibleRowsCount; i++)
                          ShelfRow(
                            plants: i < rows.length ? rows[i] : const [],
                            now: now,
                            onPlantTap: onPlantTap,
                            rowHeight: rowHeight,
                          ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: topBeamHeight,
                  bottom: bottomBeamHeight + footHeight,
                  width: HomeMetrics.cabinetPostWidth,
                  child: _CabinetBoard(
                    fill: theme.sage,
                    stroke: theme.ink,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: topBeamHeight,
                  bottom: bottomBeamHeight + footHeight,
                  width: HomeMetrics.cabinetPostWidth,
                  child: _CabinetBoard(
                    fill: theme.sage,
                    stroke: theme.ink,
                  ),
                ),
                Positioned(
                  left: -HomeMetrics.cabinetCrossbarOverhang,
                  right: -HomeMetrics.cabinetCrossbarOverhang,
                  top: 0,
                  height: topBeamHeight,
                  child: _CabinetBoard(
                    fill: theme.sage,
                    stroke: theme.ink,
                  ),
                ),
                Positioned(
                  left: -HomeMetrics.cabinetCrossbarOverhang,
                  right: -HomeMetrics.cabinetCrossbarOverhang,
                  bottom: footHeight,
                  height: bottomBeamHeight,
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
                  child: _CabinetFoot(
                    fill: theme.sage,
                    stroke: theme.ink,
                  ),
                ),
                Positioned(
                  right: HomeMetrics.cabinetFootInset,
                  bottom: 0,
                  width: HomeMetrics.cabinetFootWidth,
                  height: HomeMetrics.cabinetFootHeight,
                  child: _CabinetFoot(
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
          ),
        );
      },
    );
  }
}

class _CabinetFoot extends StatelessWidget {
  const _CabinetFoot({
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
        border: Border(
          left: BorderSide(color: stroke, width: AppStroke.line),
          right: BorderSide(color: stroke, width: AppStroke.line),
          bottom: BorderSide(color: stroke, width: AppStroke.line),
        ),
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

class _CabinetBackdropPainter extends CustomPainter {
  const _CabinetBackdropPainter({
    required this.baseColor,
    required this.inkColor,
  });

  final Color baseColor;
  final Color inkColor;

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Fondo base (beige chiaro / paper)
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = baseColor,
    );

    // 2. Doghe verticali (pannelli verticali con leggera alternanza)
    const dogaWidth = HomeMetrics.woodVeinSpacing * 1.0;
    final dogaPaint = Paint()..style = PaintingStyle.fill;
    for (var x = 0.0; x < size.width; x += dogaWidth) {
      final isEven = ((x / dogaWidth).round() % 2) == 0;
      dogaPaint.color = isEven
          ? inkColor.withValues(alpha: 0)
          : inkColor.withValues(alpha: 0.05);
      canvas.drawRect(
        Rect.fromLTWH(x, 0, dogaWidth, size.height),
        dogaPaint,
      );
    }

    // Linee di giunzione tra le doghe
    final linePaint = Paint()
      ..color = inkColor.withValues(alpha: 0.15)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    for (var x = dogaWidth; x < size.width; x += dogaWidth) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
  }

  @override
  bool shouldRepaint(_CabinetBackdropPainter oldDelegate) =>
      oldDelegate.baseColor != baseColor || oldDelegate.inkColor != inkColor;
}
