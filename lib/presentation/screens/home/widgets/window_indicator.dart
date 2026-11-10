import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/theme_providers.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';

class WindowIndicator extends ConsumerWidget {
  const WindowIndicator({super.key});

  static const _frameAsset = 'assets/svg/home/window_frame.svg';
  static const _sunAsset = 'assets/svg/home/window_sun.svg';
  static const _moonAsset = 'assets/svg/home/window_moon.svg';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.piantala;
    final localizations = AppLocalizations.of(context)!;
    final period =
        ref.watch(temporalPeriodProvider).valueOrNull ?? TemporalPeriod.day;
    final skyColor = switch (period) {
      TemporalPeriod.day => theme.skyDay,
      TemporalPeriod.dawn => theme.skyDawn,
      TemporalPeriod.dusk => theme.skyDusk,
      TemporalPeriod.evening => theme.skyEvening,
      TemporalPeriod.night => theme.skyNight,
    };
    final celestialAsset =
        period == TemporalPeriod.evening || period == TemporalPeriod.night
            ? _moonAsset
            : _sunAsset;

    return Semantics(
      label: localizations.homeWindowAccessibility,
      child: SizedBox(
        width: HomeMetrics.windowWidth,
        height: HomeMetrics.windowHeight,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: HomeMetrics.windowWidth *
                  HomeMetrics.windowGlassLeft /
                  HomeMetrics.windowViewBoxWidth,
              top: HomeMetrics.windowHeight *
                  HomeMetrics.windowGlassTop /
                  HomeMetrics.windowViewBoxHeight,
              width: HomeMetrics.windowWidth *
                  HomeMetrics.windowGlassWidth /
                  HomeMetrics.windowViewBoxWidth,
              height: HomeMetrics.windowHeight *
                  HomeMetrics.windowGlassHeight /
                  HomeMetrics.windowViewBoxHeight,
              child: ColoredBox(color: skyColor),
            ),
            Positioned(
              left: HomeMetrics.windowSunLeft,
              top: HomeMetrics.windowSunTop,
              width: HomeMetrics.windowSunSize,
              height: HomeMetrics.windowSunSize,
              child: SvgPicture.asset(celestialAsset),
            ),
            Positioned.fill(
              child: SvgPicture.asset(
                _frameAsset,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
