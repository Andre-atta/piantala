import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/navigation_metrics.dart';

class CentralNavigationTag extends StatefulWidget {
  const CentralNavigationTag({
    required this.iconAsset,
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onPressed;

  @override
  State<CentralNavigationTag> createState() => _CentralNavigationTagState();
}

class _CentralNavigationTagState extends State<CentralNavigationTag> {
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
          key: const ValueKey('navigation-create-button'),
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) {
            _setPressed(false);
            widget.onPressed();
          },
          onTapCancel: () => _setPressed(false),
          child: AnimatedContainer(
            duration: animationDuration,
            width: NavigationMetrics.createButtonWidth,
            height: NavigationMetrics.createButtonHeight,
            transform: Matrix4.translationValues(
              0,
              _isPressed ? NavigationMetrics.pressedOffset : 0,
              0,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/nav/nav_fab_pebble.svg',
                  width: NavigationMetrics.createButtonWidth,
                  height: NavigationMetrics.createButtonHeight,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: NavigationMetrics.createContentTopPadding,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        widget.iconAsset,
                        width: NavigationMetrics.createIconSize,
                        height: NavigationMetrics.createIconSize,
                        theme: SvgTheme(currentColor: theme.deepGreen),
                      ),
                      Text(
                        widget.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.body.copyWith(
                          fontSize: NavigationMetrics.createLabelFontSize,
                          height: NavigationMetrics.createLabelLineHeight /
                              NavigationMetrics.createLabelFontSize,
                          color: theme.ink,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
