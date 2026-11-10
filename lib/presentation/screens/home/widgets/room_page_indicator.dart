import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';

class RoomPageIndicator extends StatelessWidget {
  const RoomPageIndicator({
    required this.pageCount,
    required this.currentPage,
    required this.onPageSelected,
    super.key,
  });

  final int pageCount;
  final int currentPage;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final localizations = AppLocalizations.of(context)!;
    final animationDuration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(
            milliseconds: HomeMetrics.pageTransitionMilliseconds,
          );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(pageCount, (index) {
          final isActive = index == currentPage;
          return Semantics(
            button: true,
            selected: isActive,
            label: localizations.homeRoomPageSemantics(index + 1, pageCount),
            child: SizedBox(
              width: HomeMetrics.pageIndicatorTouchSize,
              height: HomeMetrics.pageIndicatorTouchSize,
              child: GestureDetector(
                key: ValueKey('room-page-$index'),
                behavior: HitTestBehavior.opaque,
                onTap: () => onPageSelected(index),
                child: Center(
                  child: AnimatedContainer(
                    duration: animationDuration,
                    width: isActive
                        ? HomeMetrics.pageIndicatorActiveWidth
                        : HomeMetrics.pageIndicatorInactiveWidth,
                    height: HomeMetrics.pageIndicatorHeight,
                    color: isActive ? theme.deepGreen : theme.sage,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
