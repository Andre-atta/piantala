import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/screens/profile/profile_metrics.dart';

void _paintTactilePin({
  required Canvas canvas,
  required Offset center,
  required double radius,
  required Color fill,
  required Color inkColor,
  required Color highlightColor,
}) {
  canvas
    ..drawCircle(
      center.translate(
        ProfileMetrics.itemDropShadowOffset * 0.7,
        ProfileMetrics.itemDropShadowOffset * 0.9,
      ),
      radius,
      Paint()
        ..color = inkColor.withValues(
          alpha: ProfileMetrics.itemDropShadowOpacity,
        ),
    )
    ..drawCircle(center, radius, Paint()..color = fill)
    ..drawCircle(
      center,
      radius,
      Paint()
        ..color = inkColor
        ..strokeWidth = AppStroke.hairline
        ..style = PaintingStyle.stroke,
    )
    ..drawCircle(
      center.translate(
        ProfileMetrics.pinHighlightOffset,
        ProfileMetrics.pinHighlightOffset,
      ),
      ProfileMetrics.pinHighlightRadius,
      Paint()
        ..color = highlightColor.withValues(
          alpha: ProfileMetrics.pinHighlightOpacity,
        ),
    );
}

class CorkboardCordPainter extends CustomPainter {
  const CorkboardCordPainter({
    required this.cordColor,
    required this.pinColor,
    required this.inkColor,
    required this.highlightColor,
  });

  final Color cordColor;
  final Color pinColor;
  final Color inkColor;
  final Color highlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final pinCenter = Offset(size.width / 2, ProfileMetrics.cordPinTopOffset);
    final leftAnchor = Offset(ProfileMetrics.cordAnchorInset, size.height);
    final rightAnchor =
        Offset(size.width - ProfileMetrics.cordAnchorInset, size.height);

    final cordPaint = Paint()
      ..color = cordColor
      ..strokeWidth = ProfileMetrics.cordStrokeWidth
      ..style = PaintingStyle.stroke;

    canvas
      ..drawLine(pinCenter, leftAnchor, cordPaint)
      ..drawLine(pinCenter, rightAnchor, cordPaint);

    _paintTactilePin(
      canvas: canvas,
      center: pinCenter,
      radius: ProfileMetrics.cordPinRadius,
      fill: pinColor,
      inkColor: inkColor,
      highlightColor: highlightColor,
    );
  }

  @override
  bool shouldRepaint(CorkboardCordPainter oldDelegate) =>
      cordColor != oldDelegate.cordColor ||
      pinColor != oldDelegate.pinColor ||
      inkColor != oldDelegate.inkColor ||
      highlightColor != oldDelegate.highlightColor;
}

class CorkboardFramePainter extends CustomPainter {
  const CorkboardFramePainter({
    required this.woodColor,
    required this.bevelLightColor,
    required this.bevelDarkColor,
    required this.inkColor,
  });

  final Color woodColor;
  final Color bevelLightColor;
  final Color bevelDarkColor;
  final Color inkColor;

  @override
  void paint(Canvas canvas, Size size) {
    final shadowRect = RRect.fromRectAndRadius(
      (Offset.zero & size).translate(
        ProfileMetrics.frameDropShadowOffset,
        ProfileMetrics.frameDropShadowOffset,
      ),
      const Radius.circular(ProfileMetrics.frameRadius),
    );
    canvas.drawRRect(
      shadowRect,
      Paint()
        ..color = inkColor.withValues(
          alpha: ProfileMetrics.frameDropShadowOpacity,
        ),
    );

    final outerRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(ProfileMetrics.frameRadius),
    );
    const inset = ProfileMetrics.frameBorderWidth;
    final innerRect = Rect.fromLTRB(
      inset,
      inset,
      size.width - inset,
      size.height - inset,
    );

    canvas.drawRRect(outerRect, Paint()..color = woodColor);

    final topStrip = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(innerRect.right, innerRect.top)
      ..lineTo(innerRect.left, innerRect.top)
      ..close();
    final leftStrip = Path()
      ..moveTo(0, 0)
      ..lineTo(innerRect.left, innerRect.top)
      ..lineTo(innerRect.left, innerRect.bottom)
      ..lineTo(0, size.height)
      ..close();
    final bottomStrip = Path()
      ..moveTo(innerRect.left, innerRect.bottom)
      ..lineTo(innerRect.right, innerRect.bottom)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final rightStrip = Path()
      ..moveTo(innerRect.right, innerRect.top)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(innerRect.right, innerRect.bottom)
      ..close();

    canvas
      ..drawPath(
        topStrip,
        Paint()
          ..color = bevelLightColor.withValues(
            alpha: ProfileMetrics.corkSpeckOpacity,
          ),
      )
      ..drawPath(
        leftStrip,
        Paint()
          ..color = bevelLightColor.withValues(
            alpha: ProfileMetrics.corkSpeckOpacity * 0.7,
          ),
      )
      ..drawPath(
        bottomStrip,
        Paint()
          ..color = bevelDarkColor.withValues(
            alpha: ProfileMetrics.corkSpeckOpacity * 1.4,
          ),
      )
      ..drawPath(
        rightStrip,
        Paint()
          ..color = bevelDarkColor.withValues(
            alpha: ProfileMetrics.corkSpeckOpacity,
          ),
      );

    final innerRidge = Rect.fromLTRB(
      inset * 0.55,
      inset * 0.55,
      size.width - inset * 0.55,
      size.height - inset * 0.55,
    );
    final miterStroke = Paint()
      ..color = bevelDarkColor
      ..strokeWidth = AppStroke.hairline
      ..style = PaintingStyle.stroke;

    canvas
      ..drawRect(innerRidge, miterStroke)
      ..drawLine(Offset.zero, innerRect.topLeft, miterStroke)
      ..drawLine(Offset(size.width, 0), innerRect.topRight, miterStroke)
      ..drawLine(Offset(0, size.height), innerRect.bottomLeft, miterStroke)
      ..drawLine(
        Offset(size.width, size.height),
        innerRect.bottomRight,
        miterStroke,
      )
      ..drawRRect(
        outerRect,
        Paint()
          ..color = inkColor
          ..strokeWidth = AppStroke.line
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(CorkboardFramePainter oldDelegate) =>
      woodColor != oldDelegate.woodColor ||
      bevelLightColor != oldDelegate.bevelLightColor ||
      bevelDarkColor != oldDelegate.bevelDarkColor ||
      inkColor != oldDelegate.inkColor;
}

class CorkboardSurfacePainter extends CustomPainter {
  const CorkboardSurfacePainter({
    required this.baseColor,
    required this.speckColor,
    required this.accentSpeckColor,
    required this.insetShadowColor,
  });

  final Color baseColor;
  final Color speckColor;
  final Color accentSpeckColor;
  final Color insetShadowColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = baseColor,
    );

    final speckPaint = Paint()
      ..color = speckColor.withValues(alpha: ProfileMetrics.corkSpeckOpacity);
    final largeSpeckPaint = Paint()
      ..color =
          accentSpeckColor.withValues(alpha: ProfileMetrics.corkSpeckOpacity);
    const step = ProfileMetrics.corkSpeckSpacing;
    var row = 0;
    for (var y = step / 2; y < size.height; y += step) {
      final xOffset = row.isEven ? 0.0 : step / 2;
      var col = 0;
      for (var x = step / 2 + xOffset; x < size.width; x += step) {
        final isLarge = (row + col) % 3 == 0;
        canvas.drawCircle(
          Offset(x, y),
          isLarge
              ? ProfileMetrics.corkSpeckLargeRadius
              : ProfileMetrics.corkSpeckRadius,
          isLarge ? largeSpeckPaint : speckPaint,
        );
        col++;
      }
      row++;
    }

    final innerShadowPaint = Paint()
      ..color = insetShadowColor.withValues(
        alpha: ProfileMetrics.corkInnerShadowOpacity,
      );
    canvas
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, ProfileMetrics.corkInnerShadowWidth),
        innerShadowPaint,
      )
      ..drawRect(
        Rect.fromLTWH(0, 0, ProfileMetrics.corkInnerShadowWidth, size.height),
        innerShadowPaint,
      );
  }

  @override
  bool shouldRepaint(CorkboardSurfacePainter oldDelegate) =>
      baseColor != oldDelegate.baseColor ||
      speckColor != oldDelegate.speckColor ||
      accentSpeckColor != oldDelegate.accentSpeckColor ||
      insetShadowColor != oldDelegate.insetShadowColor;
}

class SketchPaperBorderPainter extends CustomPainter {
  const SketchPaperBorderPainter({
    required this.fillColor,
    required this.inkColor,
  });

  final Color fillColor;
  final Color inkColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final shadowRect = rect.translate(
      ProfileMetrics.itemDropShadowOffset,
      ProfileMetrics.itemDropShadowOffset,
    );
    const overhang = ProfileMetrics.sketchCornerOverhang;
    final stroke = Paint()
      ..color = inkColor
      ..strokeWidth = AppStroke.hairline;

    canvas
      ..drawRect(
        shadowRect,
        Paint()
          ..color = inkColor.withValues(
            alpha: ProfileMetrics.itemDropShadowOpacity,
          ),
      )
      ..drawRect(rect, Paint()..color = fillColor)
      ..drawLine(Offset(-overhang, 0), Offset(size.width + overhang, 0), stroke)
      ..drawLine(
        Offset(-overhang, size.height),
        Offset(size.width + overhang, size.height),
        stroke,
      )
      ..drawLine(Offset(0, -overhang), Offset(0, size.height + overhang), stroke)
      ..drawLine(
        Offset(size.width, -overhang),
        Offset(size.width, size.height + overhang),
        stroke,
      );
  }

  @override
  bool shouldRepaint(SketchPaperBorderPainter oldDelegate) =>
      fillColor != oldDelegate.fillColor || inkColor != oldDelegate.inkColor;
}

class PostItCurlPainter extends CustomPainter {
  const PostItCurlPainter({
    required this.fillColor,
    required this.curlColor,
    required this.inkColor,
  });

  final Color fillColor;
  final Color curlColor;
  final Color inkColor;

  @override
  void paint(Canvas canvas, Size size) {
    final curl = ProfileMetrics.postItCurlSize;
    final body = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - curl)
      ..lineTo(size.width - curl, size.height)
      ..lineTo(0, size.height)
      ..close();

    final shadow = body.shift(
      const Offset(
        ProfileMetrics.itemDropShadowOffset,
        ProfileMetrics.itemDropShadowOffset,
      ),
    );

    final fold = Path()
      ..moveTo(size.width - curl, size.height - curl)
      ..lineTo(size.width, size.height - curl)
      ..lineTo(size.width - curl, size.height)
      ..close();

    final stroke = Paint()
      ..color = inkColor
      ..strokeWidth = AppStroke.hairline
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    canvas
      ..drawPath(
        shadow,
        Paint()
          ..color = inkColor.withValues(
            alpha: ProfileMetrics.itemDropShadowOpacity,
          ),
      )
      ..drawPath(body, Paint()..color = fillColor)
      ..drawPath(body, stroke)
      ..drawPath(fold, Paint()..color = curlColor)
      ..drawPath(fold, stroke);
  }

  @override
  bool shouldRepaint(PostItCurlPainter oldDelegate) =>
      fillColor != oldDelegate.fillColor ||
      curlColor != oldDelegate.curlColor ||
      inkColor != oldDelegate.inkColor;
}

class TactilePinDot extends StatelessWidget {
  const TactilePinDot({
    required this.fillColor,
    required this.radius,
    super.key,
  });

  final Color fillColor;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return SizedBox(
      width: radius * 2 + ProfileMetrics.itemDropShadowOffset,
      height: radius * 2 + ProfileMetrics.itemDropShadowOffset,
      child: CustomPaint(
        painter: _TactilePinWidgetPainter(
          fillColor: fillColor,
          inkColor: theme.ink,
          highlightColor: theme.cream,
          radius: radius,
        ),
      ),
    );
  }
}

class _TactilePinWidgetPainter extends CustomPainter {
  const _TactilePinWidgetPainter({
    required this.fillColor,
    required this.inkColor,
    required this.highlightColor,
    required this.radius,
  });

  final Color fillColor;
  final Color inkColor;
  final Color highlightColor;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    _paintTactilePin(
      canvas: canvas,
      center: Offset(radius, radius),
      radius: radius,
      fill: fillColor,
      inkColor: inkColor,
      highlightColor: highlightColor,
    );
  }

  @override
  bool shouldRepaint(_TactilePinWidgetPainter oldDelegate) =>
      fillColor != oldDelegate.fillColor ||
      inkColor != oldDelegate.inkColor ||
      highlightColor != oldDelegate.highlightColor ||
      radius != oldDelegate.radius;
}

class WorldMapPainter extends CustomPainter {
  const WorldMapPainter({
    required this.paperColor,
    required this.foldShadeColor,
    required this.landColor,
    required this.coastColor,
    required this.inkColor,
    required this.accentColor,
    required this.leftPinColor,
    required this.rightPinColor,
    required this.highlightColor,
  });

  final Color paperColor;
  final Color foldShadeColor;
  final Color landColor;
  final Color coastColor;
  final Color inkColor;
  final Color accentColor;
  final Color leftPinColor;
  final Color rightPinColor;
  final Color highlightColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas
      ..drawRect(
        rect.translate(
          ProfileMetrics.itemDropShadowOffset,
          ProfileMetrics.itemDropShadowOffset,
        ),
        Paint()
          ..color = inkColor.withValues(
            alpha: ProfileMetrics.itemDropShadowOpacity,
          ),
      )
      ..drawRect(rect, Paint()..color = paperColor);

    final panelWidth = size.width / 4;
    for (final index in [1, 3]) {
      canvas.drawRect(
        Rect.fromLTWH(index * panelWidth, 0, panelWidth, size.height),
        Paint()
          ..color = foldShadeColor.withValues(
            alpha: ProfileMetrics.mapFoldOpacity,
          ),
      );
    }

    final gridPaint = Paint()
      ..color = inkColor.withValues(alpha: ProfileMetrics.mapGridOpacity)
      ..strokeWidth = AppStroke.hairline;

    for (final factor in [0.25, 0.5, 0.75]) {
      final x = size.width * factor;
      final y = size.height * factor;
      canvas
        ..drawLine(Offset(x, 0), Offset(x, size.height), gridPaint)
        ..drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final landFill = Paint()..color = landColor;
    final coastStroke = Paint()
      ..color = coastColor
      ..strokeWidth = AppStroke.line
      ..style = PaintingStyle.stroke;
    final landStroke = Paint()
      ..color = inkColor
      ..strokeWidth = AppStroke.hairline
      ..style = PaintingStyle.stroke;

    final islands = <Path>[
      Path()
        ..moveTo(size.width * 0.08, size.height * 0.30)
        ..quadraticBezierTo(
          size.width * 0.22,
          size.height * 0.16,
          size.width * 0.30,
          size.height * 0.34,
        )
        ..quadraticBezierTo(
          size.width * 0.20,
          size.height * 0.48,
          size.width * 0.08,
          size.height * 0.30,
        )
        ..close(),
      Path()
        ..moveTo(size.width * 0.24, size.height * 0.54)
        ..quadraticBezierTo(
          size.width * 0.31,
          size.height * 0.50,
          size.width * 0.33,
          size.height * 0.78,
        )
        ..quadraticBezierTo(
          size.width * 0.24,
          size.height * 0.86,
          size.width * 0.24,
          size.height * 0.54,
        )
        ..close(),
      Path()
        ..moveTo(size.width * 0.48, size.height * 0.34)
        ..quadraticBezierTo(
          size.width * 0.61,
          size.height * 0.22,
          size.width * 0.68,
          size.height * 0.44,
        )
        ..quadraticBezierTo(
          size.width * 0.58,
          size.height * 0.64,
          size.width * 0.48,
          size.height * 0.34,
        )
        ..close(),
      Path()
        ..moveTo(size.width * 0.76, size.height * 0.68)
        ..quadraticBezierTo(
          size.width * 0.88,
          size.height * 0.60,
          size.width * 0.90,
          size.height * 0.82,
        )
        ..quadraticBezierTo(
          size.width * 0.78,
          size.height * 0.88,
          size.width * 0.76,
          size.height * 0.68,
        )
        ..close(),
    ];

    for (final island in islands) {
      canvas
        ..drawPath(island, landFill)
        ..drawPath(island, coastStroke)
        ..drawPath(island, landStroke);
    }

    final route = Path()
      ..moveTo(size.width * 0.56, size.height * 0.44)
      ..quadraticBezierTo(
        size.width * 0.69,
        size.height * 0.56,
        size.width * 0.80,
        size.height * 0.72,
      );
    final routePaint = Paint()
      ..color = accentColor
      ..strokeWidth = AppStroke.fine
      ..style = PaintingStyle.stroke;
    for (final metric in route.computeMetrics()) {
      for (var d = 0.0;
          d < metric.length;
          d += ProfileMetrics.mapRouteDash + ProfileMetrics.mapRouteGap) {
        final end = math.min(d + ProfileMetrics.mapRouteDash, metric.length);
        canvas.drawPath(metric.extractPath(d, end), routePaint);
      }
    }

    final compassCenter = Offset(
      size.width - ProfileMetrics.mapCompassRightOffset,
      ProfileMetrics.mapCompassTopOffset,
    );
    final r = ProfileMetrics.mapCompassRadius;
    final star = Path()
      ..moveTo(compassCenter.dx, compassCenter.dy - r)
      ..lineTo(compassCenter.dx + r * 0.28, compassCenter.dy - r * 0.28)
      ..lineTo(compassCenter.dx + r, compassCenter.dy)
      ..lineTo(compassCenter.dx + r * 0.28, compassCenter.dy + r * 0.28)
      ..lineTo(compassCenter.dx, compassCenter.dy + r)
      ..lineTo(compassCenter.dx - r * 0.28, compassCenter.dy + r * 0.28)
      ..lineTo(compassCenter.dx - r, compassCenter.dy)
      ..lineTo(compassCenter.dx - r * 0.28, compassCenter.dy - r * 0.28)
      ..close();
    canvas
      ..drawPath(star, Paint()..color = accentColor)
      ..drawPath(
        star,
        Paint()
          ..color = inkColor
          ..strokeWidth = AppStroke.hairline
          ..style = PaintingStyle.stroke,
      )
      ..drawRect(
        rect,
        Paint()
          ..color = inkColor
          ..strokeWidth = AppStroke.hairline
          ..style = PaintingStyle.stroke,
      );

    _paintTactilePin(
      canvas: canvas,
      center: Offset(ProfileMetrics.mapPinInset, ProfileMetrics.mapPinInset),
      radius: ProfileMetrics.mapPinRadius,
      fill: leftPinColor,
      inkColor: inkColor,
      highlightColor: highlightColor,
    );
    _paintTactilePin(
      canvas: canvas,
      center: Offset(
        size.width - ProfileMetrics.mapPinInset,
        ProfileMetrics.mapPinInset,
      ),
      radius: ProfileMetrics.mapPinRadius,
      fill: rightPinColor,
      inkColor: inkColor,
      highlightColor: highlightColor,
    );
  }

  @override
  bool shouldRepaint(WorldMapPainter oldDelegate) =>
      paperColor != oldDelegate.paperColor ||
      foldShadeColor != oldDelegate.foldShadeColor ||
      landColor != oldDelegate.landColor ||
      coastColor != oldDelegate.coastColor ||
      inkColor != oldDelegate.inkColor ||
      accentColor != oldDelegate.accentColor ||
      leftPinColor != oldDelegate.leftPinColor ||
      rightPinColor != oldDelegate.rightPinColor ||
      highlightColor != oldDelegate.highlightColor;
}

class PermissionStatusDisc extends StatelessWidget {
  const PermissionStatusDisc({
    required this.active,
    super.key,
  });

  final bool active;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return SizedBox(
      width: ProfileMetrics.permissionsDiscSize,
      height: ProfileMetrics.permissionsDiscSize,
      child: CustomPaint(
        painter: _PermissionDiscPainter(
          active: active,
          fillColor: theme.sproutGreen,
          inkColor: theme.ink,
        ),
        child: active
            ? Center(
                child: Icon(
                  Icons.check,
                  size: ProfileMetrics.permissionsDiscCheckSize,
                  color: theme.deepGreen,
                ),
              )
            : null,
      ),
    );
  }
}

class _PermissionDiscPainter extends CustomPainter {
  const _PermissionDiscPainter({
    required this.active,
    required this.fillColor,
    required this.inkColor,
  });

  final bool active;
  final Color fillColor;
  final Color inkColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - AppStroke.hairline;
    final strokePaint = Paint()
      ..color = inkColor
      ..strokeWidth = AppStroke.fine
      ..style = PaintingStyle.stroke;

    if (active) {
      canvas
        ..drawCircle(center, radius, Paint()..color = fillColor)
        ..drawCircle(center, radius, strokePaint);
      return;
    }

    final circlePath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    for (final metric in circlePath.computeMetrics()) {
      for (var d = 0.0;
          d < metric.length;
          d += ProfileMetrics.permissionsDashLength +
              ProfileMetrics.permissionsDashGap) {
        final end =
            math.min(d + ProfileMetrics.permissionsDashLength, metric.length);
        canvas.drawPath(metric.extractPath(d, end), strokePaint);
      }
    }
  }

  @override
  bool shouldRepaint(_PermissionDiscPainter oldDelegate) =>
      active != oldDelegate.active ||
      fillColor != oldDelegate.fillColor ||
      inkColor != oldDelegate.inkColor;
}

class VersionHangingTag extends StatelessWidget {
  const VersionHangingTag({
    required this.title,
    required this.version,
    super.key,
  });

  final String title;
  final String version;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return Transform.rotate(
      angle: ProfileMetrics.versionTagRotationDegrees *
          ProfileMetrics.degreesToRadians,
      child: SizedBox(
        width: ProfileMetrics.versionTagWidth,
        height: ProfileMetrics.versionTagHeight,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _VersionTagPainter(
                  fillColor: theme.paperTan,
                  holeFillColor: theme.floor,
                  inkColor: theme.ink,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: ProfileMetrics.versionTagPaddingTop,
                    left: AppSpacing.xs,
                    right: AppSpacing.xs,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: theme.label.copyWith(
                          fontSize: ProfileMetrics.versionTagTitleFontSize,
                          color: theme.softInk,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        version,
                        textAlign: TextAlign.center,
                        style: theme.body.copyWith(
                          fontSize: ProfileMetrics.versionTagNumberFontSize,
                          color: theme.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -ProfileMetrics.versionTagPinRadius,
              child: TactilePinDot(
                fillColor: theme.deepGreen,
                radius: ProfileMetrics.versionTagPinRadius,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VersionTagPainter extends CustomPainter {
  const _VersionTagPainter({
    required this.fillColor,
    required this.holeFillColor,
    required this.inkColor,
  });

  final Color fillColor;
  final Color holeFillColor;
  final Color inkColor;

  @override
  void paint(Canvas canvas, Size size) {
    const cut = ProfileMetrics.versionTagTopCut;
    final tagPath = Path()
      ..moveTo(cut, 0)
      ..lineTo(size.width - cut, 0)
      ..lineTo(size.width, cut)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..lineTo(0, cut)
      ..close();

    final shadow = tagPath.shift(
      const Offset(
        ProfileMetrics.itemDropShadowOffset,
        ProfileMetrics.itemDropShadowOffset,
      ),
    );

    final stroke = Paint()
      ..color = inkColor
      ..strokeWidth = AppStroke.hairline
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final holeCenter = Offset(
      ProfileMetrics.versionTagHoleOffset,
      ProfileMetrics.versionTagHoleOffset,
    );

    canvas
      ..drawPath(
        shadow,
        Paint()
          ..color = inkColor.withValues(
            alpha: ProfileMetrics.itemDropShadowOpacity,
          ),
      )
      ..drawPath(tagPath, Paint()..color = fillColor)
      ..drawPath(tagPath, stroke)
      ..drawCircle(
        holeCenter,
        ProfileMetrics.versionTagHoleRadius,
        Paint()..color = holeFillColor,
      )
      ..drawCircle(
        holeCenter,
        ProfileMetrics.versionTagHoleRadius,
        stroke,
      );
  }

  @override
  bool shouldRepaint(_VersionTagPainter oldDelegate) =>
      fillColor != oldDelegate.fillColor ||
      holeFillColor != oldDelegate.holeFillColor ||
      inkColor != oldDelegate.inkColor;
}
