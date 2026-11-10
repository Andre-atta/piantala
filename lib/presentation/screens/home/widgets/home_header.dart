import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';
import 'package:piantala/presentation/screens/home/widgets/room_page_indicator.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.roomName,
    required this.nextRoomName,
    required this.plantCount,
    required this.exposure,
    required this.currentPage,
    required this.pageCount,
    required this.onNextRoomTap,
    required this.onPageSelected,
    super.key,
  });

  final String roomName;
  final String? nextRoomName;
  final int plantCount;
  final String exposure;
  final int currentPage;
  final int pageCount;
  final VoidCallback onNextRoomTap;
  final ValueChanged<int> onPageSelected;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final localizations = AppLocalizations.of(context)!;

    return SizedBox(
      height: HomeMetrics.headerHeight,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(
            left: AppSpacing.md,
            right: AppSpacing.sm,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: HomeMetrics.headerRoomNameHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: HomeMetrics.headerWindowReserveWidth,
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Semantics(
                              header: true,
                              child: Text(
                                roomName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.h1.copyWith(
                                  fontSize: HomeMetrics.headerRoomNameSize,
                                  height: HomeMetrics.headerRoomNameHeight /
                                      HomeMetrics.headerRoomNameSize,
                                  color: theme.deepGreen,
                                ),
                              ),
                            ),
                          ),
                          if (nextRoomName != null)
                            SizedBox(
                              width: HomeMetrics.nextRoomWidth,
                              height: HomeMetrics.pageIndicatorTouchSize,
                              child: Semantics(
                                button: true,
                                label: nextRoomName,
                                child: GestureDetector(
                                  onTap: onNextRoomTap,
                                  behavior: HitTestBehavior.opaque,
                                  child: ShaderMask(
                                    blendMode: BlendMode.dstIn,
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                        theme.deepGreen,
                                        theme.deepGreen.withValues(alpha: 0),
                                      ],
                                    ).createShader(bounds),
                                    child: Text(
                                      nextRoomName!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: theme.h1.copyWith(
                                        fontSize: HomeMetrics.nextRoomNameSize,
                                        height: 1,
                                        color: theme.deepGreen.withValues(
                                          alpha: HomeMetrics.nextRoomOpacity,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: HomeMetrics.headerMetaLineHeight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: HomeMetrics.headerWindowReserveWidth,
                      ),
                      child: Text(
                        localizations.homeRoomMeta(plantCount, exposure),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.body.copyWith(
                          fontSize: HomeMetrics.headerMetaFontSize,
                          height: HomeMetrics.headerMetaLineHeight /
                              HomeMetrics.headerMetaFontSize,
                          color: theme.ink,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (pageCount > 1)
                Positioned(
                  left: 0,
                  right: HomeMetrics.headerWindowReserveWidth,
                  bottom: -HomeMetrics.pageIndicatorOverflow,
                  child: RoomPageIndicator(
                    pageCount: pageCount,
                    currentPage: currentPage,
                    onPageSelected: onPageSelected,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
