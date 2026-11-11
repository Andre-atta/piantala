import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/navigation_metrics.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';

enum HangingTagVariant { primary, secondary, danger }

class HangingTag extends StatefulWidget {
  const HangingTag({
    required this.label,
    required this.onPressed,
    this.variant = HangingTagVariant.primary,
    this.mirrored = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final HangingTagVariant variant;
  final bool mirrored;

  @override
  State<HangingTag> createState() => _HangingTagState();
}

class _HangingTagState extends State<HangingTag> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed != value) setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final enabled = widget.onPressed != null;
    final animationDuration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(
            milliseconds: NavigationMetrics.pressAnimationMilliseconds,
          );
    final rotation = (widget.mirrored ? -1 : 1) *
        PaperComponentMetrics.tagPressedRotationDegrees *
        math.pi /
        180;
    final labelPadding = EdgeInsets.only(
      left: widget.mirrored
          ? PaperComponentMetrics.tagLabelMirroredLeft
          : PaperComponentMetrics.tagLabelLeft,
      right: widget.mirrored
          ? PaperComponentMetrics.tagLabelMirroredRight
          : PaperComponentMetrics.tagLabelRight,
    );
    final colors = switch (widget.variant) {
      HangingTagVariant.primary => (fill: theme.deepGreen, text: theme.paper),
      HangingTagVariant.secondary => (fill: theme.paperTan, text: theme.ink),
      HangingTagVariant.danger => (fill: theme.terracotta, text: theme.paper),
    };

    return Semantics(
      button: true,
      label: widget.label,
      enabled: enabled,
      onTap: widget.onPressed,
      child: ExcludeSemantics(
        child: Transform.rotate(
          alignment: Alignment.topCenter,
          angle: rotation,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: widget.onPressed,
            onTapDown: enabled ? (_) => _setPressed(true) : null,
            onTapUp: enabled ? (_) => _setPressed(false) : null,
            onTapCancel: enabled ? () => _setPressed(false) : null,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: PaperComponentMetrics.tagWidth,
                minHeight: PaperComponentMetrics.tagHeight,
              ),
              child: IntrinsicWidth(
                child: AnimatedContainer(
                  duration: animationDuration,
                  transform: Matrix4.translationValues(
                    0,
                    _isPressed ? NavigationMetrics.pressedOffset : 0,
                    0,
                  ),
                  child: CustomPaint(
                    painter: _HangingTagPainter(
                      ink: theme.ink,
                      cream: theme.cream,
                      terracotta: theme.terracotta,
                      fill: enabled ? colors.fill : theme.paperTan,
                      disabled: !enabled,
                      mirrored: widget.mirrored,
                    ),
                    child: SizedBox(
                      height: PaperComponentMetrics.tagHeight,
                      child: Padding(
                        padding: labelPadding.copyWith(
                          top: PaperComponentMetrics.tagLabelTop,
                        ),
                        child: SizedBox(
                          height: PaperComponentMetrics.tagLabelHeight,
                          child: Center(
                            child: Text(
                              widget.label.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: theme.body.copyWith(
                                color: enabled ? colors.text : theme.softInk,
                                fontSize: PaperComponentMetrics.tagFontSize,
                                letterSpacing:
                                    PaperComponentMetrics.tagLetterSpacing,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HangingTagPainter extends CustomPainter {
  const _HangingTagPainter({
    required this.ink,
    required this.cream,
    required this.terracotta,
    required this.fill,
    required this.disabled,
    required this.mirrored,
  });

  final Color ink;
  final Color cream;
  final Color terracotta;
  final Color fill;
  final bool disabled;
  final bool mirrored;

  @override
  void paint(Canvas canvas, Size size) {
    final leadingEdge = mirrored
        ? size.width - PaperComponentMetrics.tagBodyLeft
        : PaperComponentMetrics.tagBodyLeft;
    final trailingEdge = mirrored
        ? PaperComponentMetrics.tagNotchX
        : size.width - PaperComponentMetrics.tagBodyRightInset;
    final outerNotchX = mirrored
        ? size.width - PaperComponentMetrics.tagNotchX
        : PaperComponentMetrics.tagNotchX;
    final body = Path()
      ..moveTo(leadingEdge, PaperComponentMetrics.tagBodyTop)
      ..lineTo(trailingEdge, PaperComponentMetrics.tagBodyTop)
      ..lineTo(trailingEdge, PaperComponentMetrics.tagBodyBottom)
      ..lineTo(leadingEdge, PaperComponentMetrics.tagBodyBottom)
      ..lineTo(outerNotchX, PaperComponentMetrics.tagNotchTipY)
      ..lineTo(outerNotchX, PaperComponentMetrics.tagNotchTop)
      ..close();

    final centerOffset = size.width / 2 - PaperComponentMetrics.tagWidth / 2;
    canvas
      ..drawLine(
        PaperComponentMetrics.tagWireStart.translate(centerOffset, 0),
        PaperComponentMetrics.tagWireEnd.translate(centerOffset, 0),
        Paint()
          ..color = terracotta
          ..strokeWidth = PaperComponentMetrics.tagWireWidth,
      )
      ..drawCircle(
        PaperComponentMetrics.tagPinCenter.translate(centerOffset, 0),
        PaperComponentMetrics.tagPinRadius,
        Paint()..color = terracotta,
      )
      ..drawCircle(
        PaperComponentMetrics.tagPinCenter.translate(centerOffset, 0),
        PaperComponentMetrics.tagPinRadius,
        Paint()
          ..color = ink
          ..strokeWidth = PaperComponentMetrics.tagPinStroke
          ..style = PaintingStyle.stroke,
      );

    final fillPaint = Paint()
      ..color = disabled
          ? fill.withValues(
              alpha: PaperComponentMetrics.disabledFillOpacity,
            )
          : fill;
    final outlinePaint = Paint()
      ..color = disabled
          ? ink.withValues(alpha: PaperComponentMetrics.disabledInkOpacity)
          : ink
      ..strokeWidth = PaperComponentMetrics.tagOutlineWidth
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    if (disabled) {
      canvas.drawPath(body, fillPaint);
      for (final metric in body.computeMetrics()) {
        for (var start = 0.0;
            start < metric.length;
            start += PaperComponentMetrics.disabledDashLength +
                PaperComponentMetrics.disabledDashGap) {
          final end = math.min(
            start + PaperComponentMetrics.disabledDashLength,
            metric.length,
          );
          canvas.drawPath(metric.extractPath(start, end), outlinePaint);
        }
      }
    } else {
      canvas
        ..drawPath(body, fillPaint)
        ..drawPath(body, outlinePaint);
    }

    final holeCenter =
        PaperComponentMetrics.tagHoleCenter.translate(centerOffset, 0);
    canvas
      ..drawCircle(
        holeCenter,
        PaperComponentMetrics.tagHoleRadius,
        Paint()..color = cream,
      )
      ..drawCircle(
        holeCenter,
        PaperComponentMetrics.tagHoleRadius,
        Paint()
          ..color = ink
          ..strokeWidth = PaperComponentMetrics.tagHoleStroke
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(_HangingTagPainter oldDelegate) =>
      ink != oldDelegate.ink ||
      cream != oldDelegate.cream ||
      terracotta != oldDelegate.terracotta ||
      fill != oldDelegate.fill ||
      disabled != oldDelegate.disabled ||
      mirrored != oldDelegate.mirrored;
}
