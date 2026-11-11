import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/utils/compass_utils.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/compass_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/compass_dial_painter.dart';
import 'package:piantala/presentation/screens/rooms/widgets/compass_scanner_metrics.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';

class CompassScannerDialog extends ConsumerStatefulWidget {
  const CompassScannerDialog({super.key});

  @override
  ConsumerState<CompassScannerDialog> createState() =>
      _CompassScannerDialogState();
}

class _CompassScannerDialogState extends ConsumerState<CompassScannerDialog>
    with TickerProviderStateMixin {
  late final AnimationController _progressController;
  late final AnimationController _needleController;
  Animation<double>? _needleAnimation;
  Timer? _unavailableTimer;
  double? _referenceHeading;
  double? _currentHeading;
  double? _displayHeading;
  bool _isLocked = false;
  bool _isUnavailable = false;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: CompassScannerMetrics.stabilizationMilliseconds,
      ),
    )
      ..addStatusListener(_onProgressStatus)
      ..addListener(_onProgressTick);
    _needleController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: CompassScannerMetrics.needleTransitionMilliseconds,
      ),
    )..addListener(_onNeedleTick);
    _startUnavailableTimer();
  }

  @override
  void dispose() {
    _unavailableTimer?.cancel();
    _progressController.dispose();
    _needleController.dispose();
    super.dispose();
  }

  void _startUnavailableTimer() {
    _unavailableTimer?.cancel();
    _unavailableTimer = Timer(
      const Duration(milliseconds: CompassScannerMetrics.unavailableTimeoutMs),
      () {
        if (mounted && _currentHeading == null) {
          setState(() => _isUnavailable = true);
        }
      },
    );
  }

  void _onProgressStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed || !mounted || _isLocked) return;
    setState(() => _isLocked = true);
    unawaited(HapticFeedback.selectionClick());
  }

  void _onProgressTick() {
    if (mounted) setState(() {});
  }

  void _onNeedleTick() {
    final animation = _needleAnimation;
    if (animation == null || !mounted) return;
    setState(() => _displayHeading = animation.value);
  }

  void _onHeading(double? heading) {
    if (heading == null || _isLocked) return;
    _unavailableTimer?.cancel();
    final wasUnavailable = _isUnavailable;
    _currentHeading = heading;

    if (wasUnavailable && mounted) {
      setState(() => _isUnavailable = false);
    }

    final reference = _referenceHeading;
    if (reference == null ||
        angularDifference(heading, reference) >
            CompassScannerMetrics.stabilityThresholdDegrees) {
      _referenceHeading = heading;
      _progressController
        ..stop()
        ..value = 0
        ..forward();
    }

    _animateNeedleTo(heading);
    if (mounted) setState(() {});
  }

  void _animateNeedleTo(double heading) {
    if (MediaQuery.of(context).disableAnimations) {
      _needleController
        ..stop()
        ..value = 1;
      _displayHeading = heading;
      return;
    }

    final begin = _displayHeading ?? heading;
    final shortestEnd = begin + ((heading - begin + 540) % 360) - 180;
    _needleAnimation = Tween<double>(begin: begin, end: shortestEnd).animate(
      CurvedAnimation(
        parent: _needleController,
        curve: Curves.easeOut,
      ),
    );
    _needleController
      ..stop()
      ..value = 0
      ..forward();
  }

  void _retry() {
    setState(() {
      _isLocked = false;
      _isUnavailable = false;
      _currentHeading = null;
      _displayHeading = null;
      _referenceHeading = null;
      _progressController
        ..stop()
        ..value = 0;
      _needleController
        ..stop()
        ..value = 0;
    });
    _startUnavailableTimer();
  }

  String _localizedDirection(AppLocalizations l10n, String code) =>
      switch (code) {
        'N' => l10n.exposureNorth,
        'NE' => l10n.exposureNorthEast,
        'E' => l10n.exposureEast,
        'SE' => l10n.exposureSouthEast,
        'S' => l10n.exposureSouth,
        'SW' => l10n.exposureSouthWest,
        'W' => l10n.exposureWest,
        'NW' => l10n.exposureNorthWest,
        _ => '--',
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;
    ref.watch(compassHeadingStreamProvider);
    ref.listen(compassHeadingStreamProvider, (previous, next) {
      next.when(
        data: _onHeading,
        loading: () {},
        error: (error, stackTrace) {
          if (mounted) setState(() => _isUnavailable = true);
        },
      );
    });

    final directionCode =
        _currentHeading == null ? null : exposureFromHeading(_currentHeading!);
    final directionName =
        directionCode == null ? '--' : _localizedDirection(l10n, directionCode);
    final progress = _isUnavailable
        ? 0.0
        : _isLocked
            ? 1.0
            : _progressController.value;
    final remainingSeconds = math.max(
      0,
      (CompassScannerMetrics.stabilizationSeconds * (1 - progress)).ceil(),
    );
    final isUnavailable = _isUnavailable;

    return PaperDialogScaffold(
      title: l10n.compassTitle,
      rotationDegrees: CompassScannerMetrics.dialogRotationDegrees,
      actions: [
        if (isUnavailable || !_isLocked)
          HangingTag(
            label: l10n.commonCancel,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: () => Navigator.of(context).pop(),
          )
        else ...[
          HangingTag(
            label: l10n.compassRetry,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: _retry,
          ),
          HangingTag(
            label: l10n.commonSave,
            onPressed: () => Navigator.of(context).pop(directionCode),
          ),
        ],
      ],
      child: Column(
        children: [
          if (isUnavailable)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: CompassScannerMetrics.unavailableVerticalPadding,
              ),
              child: Text(
                l10n.compassUnavailable,
                textAlign: TextAlign.center,
                style: theme.body.copyWith(color: theme.softInk),
              ),
            )
          else ...[
            Semantics(
              label: l10n.compassDialSemantics(directionName),
              image: true,
              child: ExcludeSemantics(
                child: Transform.rotate(
                  angle:
                      CompassScannerMetrics.dialRotationDegrees * math.pi / 180,
                  child: RepaintBoundary(
                    child: CustomPaint(
                      size: const Size(
                        CompassScannerMetrics.dialSize,
                        CompassScannerMetrics.dialSize,
                      ),
                      painter: CompassDialPainter(
                        heading: _displayHeading,
                        north: l10n.compassLetterNorth,
                        east: l10n.compassLetterEast,
                        south: l10n.compassLetterSouth,
                        west: l10n.compassLetterWest,
                        cardinalStyle: theme.h1.copyWith(
                          color: theme.deepGreen,
                          fontSize: CompassScannerMetrics.cardinalFontSize,
                        ),
                        paper: theme.paper,
                        cream: theme.cream,
                        ink: theme.ink,
                        deepGreen: theme.deepGreen,
                        sage: theme.sage,
                        terracotta: theme.terracotta,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: CompassScannerMetrics.dialTextSpacing),
            Text(
              _isLocked ? l10n.compassLocked : l10n.compassPointHint,
              textAlign: TextAlign.center,
              style: theme.body.copyWith(
                color: theme.ink,
                fontSize: CompassScannerMetrics.messageFontSize,
              ),
            ),
            Text(
              directionName,
              textAlign: TextAlign.center,
              style: theme.h1.copyWith(
                color: theme.deepGreen,
                fontSize: CompassScannerMetrics.directionFontSize,
              ),
            ),
            _CompassProgressBar(progress: progress),
            const SizedBox(height: AppSpacing.xs),
            Text(
              _isLocked ? l10n.compassDone : l10n.compassHold(remainingSeconds),
              textAlign: TextAlign.center,
              style: theme.body.copyWith(color: theme.softInk),
            ),
          ],
        ],
      ),
    );
  }
}

class _CompassProgressBar extends StatelessWidget {
  const _CompassProgressBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return SizedBox(
      key: const ValueKey('compass-progress'),
      width: CompassScannerMetrics.progressWidth,
      height: CompassScannerMetrics.progressHeight,
      child: CustomPaint(
        painter: _CompassProgressPainter(
          progress: progress,
          fill: theme.leafGreen,
          background: theme.paper,
          outline: theme.ink,
        ),
      ),
    );
  }
}

class _CompassProgressPainter extends CustomPainter {
  const _CompassProgressPainter({
    required this.progress,
    required this.fill,
    required this.background,
    required this.outline,
  });

  final double progress;
  final Color fill;
  final Color background;
  final Color outline;

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Offset.zero & size;
    canvas
      ..drawRect(bounds, Paint()..color = background)
      ..drawRect(
        Rect.fromLTWH(0, 0, size.width * progress, size.height),
        Paint()..color = fill,
      )
      ..drawRect(
        bounds,
        Paint()
          ..color = outline
          ..strokeWidth = AppStroke.hairline
          ..style = PaintingStyle.stroke,
      );
  }

  @override
  bool shouldRepaint(_CompassProgressPainter oldDelegate) =>
      progress != oldDelegate.progress ||
      fill != oldDelegate.fill ||
      background != oldDelegate.background ||
      outline != oldDelegate.outline;
}
