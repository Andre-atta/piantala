import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/widgets/common/central_navigation_tag.dart';
import 'package:piantala/presentation/widgets/common/navigation_metrics.dart';

class PiantalaNavigationBar extends StatelessWidget {
  const PiantalaNavigationBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onCreatePressed,
    required this.isRoomsRoute,
    this.waveBackdrop,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onCreatePressed;
  final bool isRoomsRoute;
  final Color? waveBackdrop;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final localizations = AppLocalizations.of(context)!;
    final tabs = [
      _NavigationItem(
        label: localizations.navHome,
        asset: 'assets/svg/nav/nav_shelf.svg',
        routeIndex: 0,
      ),
      _NavigationItem(
        label: localizations.navRooms,
        asset: 'assets/svg/nav/nav_rooms.svg',
        routeIndex: 1,
      ),
      _NavigationItem(
        label: localizations.navEncyclopedia,
        asset: 'assets/svg/nav/nav_encyclopedia.svg',
        routeIndex: 2,
      ),
      _NavigationItem(
        label: localizations.navProfile,
        asset: 'assets/svg/nav/nav_profile.svg',
        routeIndex: 3,
      ),
    ];

    return ColoredBox(
      color: theme.paper,
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SizedBox(
          height: NavigationMetrics.barHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final sideWidth = math
                  .max(
                    0,
                    (constraints.maxWidth - NavigationMetrics.centerGap) / 2,
                  )
                  .toDouble();

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Column(
                      children: [
                        SizedBox(
                          height: NavigationMetrics.waveHeight,
                          width: double.infinity,
                          child: ColoredBox(
                            color: waveBackdrop ??
                                Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        Expanded(
                          child: ColoredBox(color: theme.paper),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: NavigationMetrics.waveHeight,
                    child: SvgPicture.asset(
                      'assets/svg/nav/nav_wave.svg',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    top: NavigationMetrics.waveHeight,
                    left: 0,
                    width: sideWidth,
                    height: NavigationMetrics.barHeight -
                        NavigationMetrics.waveHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: tabs
                          .take(2)
                          .map(
                            (item) => _NavigationButton(
                              item: item,
                              selected: selectedIndex == item.routeIndex,
                              onTap: () =>
                                  onDestinationSelected(item.routeIndex),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Positioned(
                    top: NavigationMetrics.waveHeight,
                    right: 0,
                    width: sideWidth,
                    height: NavigationMetrics.barHeight -
                        NavigationMetrics.waveHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: tabs
                          .skip(2)
                          .map(
                            (item) => _NavigationButton(
                              item: item,
                              selected: selectedIndex == item.routeIndex,
                              onTap: () =>
                                  onDestinationSelected(item.routeIndex),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: NavigationMetrics.createButtonBottom,
                    child: Center(
                      child: CentralNavigationTag(
                        iconAsset: isRoomsRoute
                            ? 'assets/svg/nav/fab_hammer.svg'
                            : 'assets/svg/nav/fab_pot.svg',
                        label: isRoomsRoute
                            ? localizations.navNewRoom
                            : localizations.navNewPlant,
                        onPressed: onCreatePressed,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavigationButton extends StatefulWidget {
  const _NavigationButton({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final _NavigationItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<_NavigationButton> {
  bool _isPressed = false;

  void _setPressed(bool value) {
    if (_isPressed != value) setState(() => _isPressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final color = widget.selected ? theme.deepGreen : theme.ink;
    final animationDuration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(
            milliseconds: NavigationMetrics.pressAnimationMilliseconds,
          );

    return Semantics(
      button: true,
      selected: widget.selected,
      label: widget.item.label,
      onTap: widget.onTap,
      child: SizedBox(
        width: NavigationMetrics.targetWidth,
        height: NavigationMetrics.targetHeight,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) {
            _setPressed(false);
            widget.onTap();
          },
          onTapCancel: () => _setPressed(false),
          child: AnimatedContainer(
            key: ValueKey('navigation-${widget.item.routeIndex}'),
            duration: animationDuration,
            transform: Matrix4.translationValues(
              0,
              _isPressed ? NavigationMetrics.pressedOffset : 0,
              0,
            ),
            child: ExcludeSemantics(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: NavigationMetrics.iconFrameWidth,
                    height: NavigationMetrics.iconFrameHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (widget.selected)
                          SvgPicture.asset(
                            'assets/svg/nav/nav_active_blob.svg',
                            width: NavigationMetrics.iconFrameWidth,
                            height: NavigationMetrics.iconFrameHeight,
                            fit: BoxFit.fill,
                          ),
                        SvgPicture.asset(
                          widget.item.asset,
                          width: NavigationMetrics.iconSize,
                          height: NavigationMetrics.iconSize,
                          theme: SvgTheme(currentColor: color),
                        ),
                      ],
                    ),
                  ),
                  if (widget.selected)
                    SizedBox(
                      height: NavigationMetrics.createLabelLineHeight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          widget.item.label.toUpperCase(),
                          maxLines: 1,
                          style: theme.label.copyWith(
                            fontSize: NavigationMetrics.activeLabelFontSize,
                            letterSpacing:
                                NavigationMetrics.activeLabelLetterSpacing,
                            height: 1,
                            color: color,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(
                      height: NavigationMetrics.createLabelLineHeight,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  const _NavigationItem({
    required this.label,
    required this.asset,
    required this.routeIndex,
  });

  final String label;
  final String asset;
  final int routeIndex;
}
