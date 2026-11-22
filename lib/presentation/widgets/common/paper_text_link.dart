import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/navigation_metrics.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';

class PaperTextLink extends StatefulWidget {
  const PaperTextLink({
    required this.label,
    required this.onPressed,
    this.enabled = true,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final bool enabled;

  @override
  State<PaperTextLink> createState() => _PaperTextLinkState();
}

class _PaperTextLinkState extends State<PaperTextLink> {
  bool _isPressed = false;

  void _setPressed(bool pressed) {
    if (_isPressed != pressed) setState(() => _isPressed = pressed);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return Semantics(
      button: true,
      label: widget.label,
      enabled: widget.enabled,
      onTap: widget.enabled ? widget.onPressed : null,
      child: ExcludeSemantics(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.enabled ? widget.onPressed : null,
          onTapDown: widget.enabled ? (_) => _setPressed(true) : null,
          onTapUp: widget.enabled ? (_) => _setPressed(false) : null,
          onTapCancel: widget.enabled ? () => _setPressed(false) : null,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: PaperComponentMetrics.paperTextLinkMinimumTarget,
              minHeight: PaperComponentMetrics.paperTextLinkMinimumTarget,
            ),
            child: AnimatedContainer(
              duration: MediaQuery.of(context).disableAnimations
                  ? Duration.zero
                  : const Duration(
                      milliseconds:
                          NavigationMetrics.pressAnimationMilliseconds,
                    ),
              transform: Matrix4.translationValues(
                0,
                _isPressed ? NavigationMetrics.pressedOffset : 0,
                0,
              ),
              child: Center(
                child: IntrinsicWidth(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: theme.body.copyWith(
                          color: theme.deepGreen,
                          fontSize: PaperComponentMetrics.paperTextLinkFontSize,
                        ),
                      ),
                      const SizedBox(
                        height:
                            PaperComponentMetrics.paperTextLinkUnderlineOffset,
                      ),
                      SizedBox(
                        height: 1,
                        child: ColoredBox(color: theme.deepGreen),
                      ),
                    ],
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
