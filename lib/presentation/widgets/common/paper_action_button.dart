import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/navigation_metrics.dart';

class PaperActionButton extends StatefulWidget {
  const PaperActionButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  State<PaperActionButton> createState() => _PaperActionButtonState();
}

class _PaperActionButtonState extends State<PaperActionButton> {
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
            milliseconds: NavigationMetrics.pressAnimationMilliseconds,
          );

    return Semantics(
      button: true,
      label: widget.label,
      onTap: widget.onPressed,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) {
            _setPressed(false);
            widget.onPressed();
          },
          onTapCancel: () => _setPressed(false),
          child: AnimatedContainer(
            duration: animationDuration,
            transform: Matrix4.translationValues(
              0,
              _isPressed ? NavigationMetrics.pressedOffset : 0,
              0,
            ),
            constraints: const BoxConstraints(minHeight: AppSpacing.xxl),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: theme.terracotta,
              border: Border.all(
                color: theme.ink,
                width: AppStroke.line,
              ),
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.body.copyWith(color: theme.ink),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
