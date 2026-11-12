import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_paper_card_metrics.dart';

class RoomPinButton extends StatefulWidget {
  const RoomPinButton({
    required this.label,
    required this.onPressed,
    this.child,
    this.showOptionsDots = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Widget? child;
  final bool showOptionsDots;

  @override
  State<RoomPinButton> createState() => _RoomPinButtonState();
}

class _RoomPinButtonState extends State<RoomPinButton> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed != value) setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final animationDuration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(
            milliseconds: RoomPaperCardMetrics.optionsPressMilliseconds,
          );

    return Semantics(
      container: true,
      button: true,
      label: widget.label,
      onTap: widget.onPressed,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onPressed,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          child: AnimatedContainer(
            duration: animationDuration,
            transform: Matrix4.translationValues(
              0,
              _isPressed ? RoomPaperCardMetrics.optionsPressOffset : 0,
              0,
            ),
            child: CustomPaint(
              painter: _RoomPinPainter(
                ink: theme.ink,
                cream: theme.cream,
                terracotta: theme.terracotta,
                showOptionsDots: widget.showOptionsDots,
              ),
              child: SizedBox(
                width: RoomPaperCardMetrics.optionsWidth,
                height: RoomPaperCardMetrics.optionsHeight,
                child:
                    widget.child == null ? null : Center(child: widget.child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoomPinPainter extends CustomPainter {
  const _RoomPinPainter({
    required this.ink,
    required this.cream,
    required this.terracotta,
    required this.showOptionsDots,
  });

  final Color ink;
  final Color cream;
  final Color terracotta;
  final bool showOptionsDots;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = RoomPaperCardMetrics.optionsRadius;
    canvas
      ..drawCircle(
        center.translate(0, RoomPaperCardMetrics.optionsShadowOffset),
        radius,
        Paint()..color = ink,
      )
      ..drawCircle(
        center,
        radius,
        Paint()..color = terracotta,
      )
      ..drawCircle(
        center,
        radius,
        Paint()
          ..color = ink
          ..strokeWidth = RoomPaperCardMetrics.optionsOutlineWidth
          ..style = PaintingStyle.stroke,
      )
      ..drawCircle(
        center.translate(-radius / 2, -radius / 2),
        RoomPaperCardMetrics.optionsLightRadius,
        Paint()
          ..color = cream.withValues(
            alpha: RoomPaperCardMetrics.optionsLightOpacity,
          ),
      );

    if (showOptionsDots) {
      for (var index = -1; index <= 1; index++) {
        canvas.drawCircle(
          Offset(
            center.dx +
                index *
                    (RoomPaperCardMetrics.optionsDotRadius * 2 +
                        RoomPaperCardMetrics.optionsDotSpacing),
            center.dy,
          ),
          RoomPaperCardMetrics.optionsDotRadius,
          Paint()..color = cream,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_RoomPinPainter oldDelegate) =>
      ink != oldDelegate.ink ||
      cream != oldDelegate.cream ||
      terracotta != oldDelegate.terracotta ||
      showOptionsDots != oldDelegate.showOptionsDots;
}
