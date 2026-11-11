import 'dart:math' as math;

import 'package:flutter/material.dart';

class CompassDialPainter extends CustomPainter {
  const CompassDialPainter({
    required this.heading,
    required this.north,
    required this.east,
    required this.south,
    required this.west,
    required this.cardinalStyle,
    required this.paper,
    required this.cream,
    required this.ink,
    required this.deepGreen,
    required this.sage,
    required this.terracotta,
  });

  final double? heading;
  final String north;
  final String east;
  final String south;
  final String west;
  final TextStyle cardinalStyle;
  final Color paper;
  final Color cream;
  final Color ink;
  final Color deepGreen;
  final Color sage;
  final Color terracotta;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    canvas
      ..drawCircle(
        center.translate(0, 3),
        radius,
        Paint()..color = ink,
      )
      ..drawCircle(
        center,
        radius - 0.75,
        Paint()..color = paper,
      )
      ..drawCircle(
        center,
        radius - 0.75,
        Paint()
          ..color = ink
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke,
      );

    _drawDashedCircle(canvas, center, radius * 0.66);
    _drawTicks(canvas, center, radius);
    _drawCardinalLetters(canvas, center, radius);
    if (heading != null) _drawNeedle(canvas, center, heading!);
  }

  void _drawDashedCircle(Canvas canvas, Offset center, double radius) {
    const dash = 3.0;
    const gap = 5.0;
    final circumference = 2 * math.pi * radius;
    final paint = Paint()
      ..color = sage
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    for (var distance = 0.0; distance < circumference; distance += dash + gap) {
      final startAngle = distance / radius;
      final sweep =
          math.min(dash / radius, (circumference - distance) / radius);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        false,
        paint,
      );
    }
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    for (var degrees = 10; degrees < 360; degrees += 10) {
      if (degrees % 90 == 0) continue;
      final isLong = degrees % 30 == 0;
      final angle = degrees * math.pi / 180;
      final outerRadius = radius - 12;
      final innerRadius = outerRadius - (isLong ? 14 : 8);
      canvas.drawLine(
        center.translate(
          math.sin(angle) * outerRadius,
          -math.cos(angle) * outerRadius,
        ),
        center.translate(
          math.sin(angle) * innerRadius,
          -math.cos(angle) * innerRadius,
        ),
        Paint()
          ..color = ink
          ..strokeWidth = isLong ? 2 : 1.2,
      );
    }
  }

  void _drawCardinalLetters(Canvas canvas, Offset center, double radius) {
    final positions = <(String, double)>[
      (north, 0),
      (east, 90),
      (south, 180),
      (west, 270),
    ];
    for (final (label, degrees) in positions) {
      final angle = degrees * math.pi / 180;
      final distance = radius - 64;
      final textPainter = TextPainter(
        text: TextSpan(
          text: label,
          style: cardinalStyle,
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
        canvas,
        center.translate(
              math.sin(angle) * distance,
              -math.cos(angle) * distance,
            ) -
            Offset(textPainter.width / 2, textPainter.height / 2),
      );
    }
  }

  void _drawNeedle(Canvas canvas, Offset center, double degrees) {
    final radians = degrees * math.pi / 180;
    final direction = Offset(math.sin(radians), -math.cos(radians));
    final perpendicular = Offset(-direction.dy, direction.dx);
    final tip = center + direction * 48;
    final tail = center - direction * 36;
    final side = perpendicular * 5;
    final point = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo((center + side).dx, (center + side).dy)
      ..lineTo(center.dx, center.dy)
      ..lineTo((center - side).dx, (center - side).dy)
      ..close();
    final tailPath = Path()
      ..moveTo(center.dx, center.dy)
      ..lineTo((center + side).dx, (center + side).dy)
      ..lineTo(tail.dx, tail.dy)
      ..lineTo((center - side).dx, (center - side).dy)
      ..close();
    final outline = Paint()
      ..color = ink
      ..strokeWidth = 1.5
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas
      ..drawPath(tailPath, Paint()..color = cream)
      ..drawPath(tailPath, outline)
      ..drawPath(point, Paint()..color = terracotta)
      ..drawPath(point, outline)
      ..drawCircle(center, 5.5, Paint()..color = terracotta)
      ..drawCircle(
        center,
        5.5,
        Paint()
          ..color = ink
          ..strokeWidth = 1.4
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(CompassDialPainter oldDelegate) =>
      heading != oldDelegate.heading ||
      north != oldDelegate.north ||
      east != oldDelegate.east ||
      south != oldDelegate.south ||
      west != oldDelegate.west ||
      cardinalStyle != oldDelegate.cardinalStyle ||
      paper != oldDelegate.paper ||
      cream != oldDelegate.cream ||
      ink != oldDelegate.ink ||
      deepGreen != oldDelegate.deepGreen ||
      sage != oldDelegate.sage ||
      terracotta != oldDelegate.terracotta;
}
