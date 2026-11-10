import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';

class HomeFloor extends StatelessWidget {
  const HomeFloor({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return SizedBox(
      height: HomeMetrics.floorHeight,
      child: CustomPaint(
        painter: _FloorPainter(
          floor: theme.floor,
          border: theme.floorBorder,
          joints: theme.ink.withValues(alpha: 0.22),
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _FloorPainter extends CustomPainter {
  const _FloorPainter({
    required this.floor,
    required this.border,
    required this.joints,
  });

  final Color floor;
  final Color border;
  final Color joints;

  @override
  void paint(Canvas canvas, Size size) {
    canvas
      ..drawRect(Offset.zero & size, Paint()..color = floor)
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width, HomeMetrics.floorBorderHeight),
        Paint()..color = border,
      );
    final jointPaint = Paint()
      ..color = joints
      ..strokeWidth = AppStroke.hairline;
    for (var x = HomeMetrics.floorJointSpacing;
        x < size.width;
        x += HomeMetrics.floorJointSpacing) {
      canvas.drawLine(
        Offset(x, HomeMetrics.floorBorderHeight),
        Offset(x, size.height),
        jointPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_FloorPainter oldDelegate) =>
      floor != oldDelegate.floor ||
      border != oldDelegate.border ||
      joints != oldDelegate.joints;
}
