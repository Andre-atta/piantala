import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';

enum TornPaperColor { cream, paperTan, paper }

enum TornPaperDecoration { tape, pin, none }

class TornPaperSheet extends StatelessWidget {
  const TornPaperSheet({
    required this.child,
    required this.color,
    this.rotationDegrees = PaperComponentMetrics.defaultSheetRotationDegrees,
    this.decoration = TornPaperDecoration.none,
    this.ruled = false,
    this.padding = PaperComponentMetrics.defaultSheetPadding,
    super.key,
  }) : assert(
          rotationDegrees >= PaperComponentMetrics.minimumRotationDegrees &&
              rotationDegrees <= PaperComponentMetrics.maximumRotationDegrees,
          PaperComponentMetrics.rotationAssertionMessage,
        );

  final Widget child;
  final TornPaperColor color;
  final double rotationDegrees;
  final TornPaperDecoration decoration;
  final bool ruled;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final paperColor = switch (color) {
      TornPaperColor.cream => theme.cream,
      TornPaperColor.paperTan => theme.paperTan,
      TornPaperColor.paper => theme.paper,
    };
    final rotation = rotationDegrees * math.pi / 180;
    final resolvedPadding = padding.resolve(Directionality.of(context));

    return Transform.rotate(
      angle: rotation,
      child: CustomPaint(
        painter: _TornPaperPainter(
          paperColor: paperColor,
          ink: theme.ink,
          sprout: theme.sproutGreen,
          terracotta: theme.terracotta,
          deepGreen: theme.deepGreen,
          leafGreen: theme.leafGreen,
          decoration: decoration,
          ruled: ruled,
        ),
        child: Padding(
          padding: resolvedPadding.copyWith(
            top: resolvedPadding.top + PaperComponentMetrics.decorationTopInset,
            bottom:
                resolvedPadding.bottom + PaperComponentMetrics.tornBandHeight,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TornPaperPainter extends CustomPainter {
  const _TornPaperPainter({
    required this.paperColor,
    required this.ink,
    required this.sprout,
    required this.terracotta,
    required this.deepGreen,
    required this.leafGreen,
    required this.decoration,
    required this.ruled,
  });

  final Color paperColor;
  final Color ink;
  final Color sprout;
  final Color terracotta;
  final Color deepGreen;
  final Color leafGreen;
  final TornPaperDecoration decoration;
  final bool ruled;

  @override
  void paint(Canvas canvas, Size size) {
    const bodyTop = PaperComponentMetrics.decorationTopInset;
    final bodyBottom = size.height - PaperComponentMetrics.tornBandHeight;
    final path = Path()
      ..moveTo(AppStroke.hairline / 2, bodyTop)
      ..lineTo(size.width - AppStroke.hairline / 2, bodyTop)
      ..lineTo(size.width - AppStroke.hairline / 2, bodyBottom);

    for (final point in kTornEdgePoints.reversed) {
      path.lineTo(
        point.dx / PaperComponentMetrics.tornReferenceWidth * size.width,
        bodyBottom + point.dy,
      );
    }
    path.close();

    canvas
      ..drawPath(
        path,
        Paint()
          ..color = paperColor
          ..style = PaintingStyle.fill,
      )
      ..drawPath(
        path,
        Paint()
          ..color = ink
          ..strokeWidth = AppStroke.hairline
          ..strokeJoin = StrokeJoin.round
          ..style = PaintingStyle.stroke,
      );

    if (ruled) {
      final rulePaint = Paint()
        ..color =
            leafGreen.withValues(alpha: PaperComponentMetrics.ruledOpacity)
        ..strokeWidth = AppStroke.hairline;
      canvas
        ..save()
        ..clipRect(
          Rect.fromLTRB(0, bodyTop, size.width, bodyBottom),
        );
      for (var y = bodyTop + PaperComponentMetrics.ruledSpacing;
          y < bodyBottom;
          y += PaperComponentMetrics.ruledSpacing) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), rulePaint);
      }
      canvas.restore();
    }

    switch (decoration) {
      case TornPaperDecoration.tape:
        _paintTape(canvas, size);
      case TornPaperDecoration.pin:
        _paintPin(canvas, size);
      case TornPaperDecoration.none:
        return;
    }
  }

  void _paintTape(Canvas canvas, Size size) {
    final center =
        Offset(size.width / 2, PaperComponentMetrics.decorationTopInset);
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: PaperComponentMetrics.tapeWidth,
      height: PaperComponentMetrics.tapeHeight,
    );
    canvas
      ..save()
      ..translate(center.dx, center.dy)
      ..rotate(PaperComponentMetrics.tapeRotationDegrees * math.pi / 180)
      ..drawRect(
        rect,
        Paint()
          ..color = sprout
          ..style = PaintingStyle.fill,
      )
      ..drawRect(
        rect,
        Paint()
          ..color = deepGreen
          ..strokeWidth = AppStroke.hairline
          ..style = PaintingStyle.stroke,
      )
      ..restore();
  }

  void _paintPin(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      PaperComponentMetrics.decorationTopInset +
          PaperComponentMetrics.pinDiameter / 2 -
          PaperComponentMetrics.pinProtrusion,
    );
    canvas
      ..drawCircle(
        center,
        PaperComponentMetrics.pinDiameter / 2,
        Paint()..color = terracotta,
      )
      ..drawCircle(
        center,
        PaperComponentMetrics.pinDiameter / 2,
        Paint()
          ..color = ink
          ..strokeWidth = AppStroke.line
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(_TornPaperPainter oldDelegate) =>
      paperColor != oldDelegate.paperColor ||
      ink != oldDelegate.ink ||
      sprout != oldDelegate.sprout ||
      terracotta != oldDelegate.terracotta ||
      deepGreen != oldDelegate.deepGreen ||
      leafGreen != oldDelegate.leafGreen ||
      decoration != oldDelegate.decoration ||
      ruled != oldDelegate.ruled;
}
