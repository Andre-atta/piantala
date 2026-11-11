import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';
import 'package:piantala/presentation/widgets/common/torn_paper_sheet.dart';

class PaperDialogScaffold extends StatefulWidget {
  const PaperDialogScaffold({
    required this.title,
    required this.child,
    required this.actions,
    this.rotationDegrees = PaperComponentMetrics.dialogSheetRotationDegrees,
    super.key,
  })  : assert(
          actions.length == 1 || actions.length == 2,
          PaperComponentMetrics.actionCountAssertionMessage,
        ),
        assert(
          rotationDegrees >= PaperComponentMetrics.minimumRotationDegrees &&
              rotationDegrees <= PaperComponentMetrics.maximumRotationDegrees,
          PaperComponentMetrics.rotationAssertionMessage,
        );

  final String title;
  final Widget child;
  final List<HangingTag> actions;
  final double rotationDegrees;

  @override
  State<PaperDialogScaffold> createState() => _PaperDialogScaffoldState();
}

class _PaperDialogScaffoldState extends State<PaperDialogScaffold> {
  bool _requestedInitialFocus = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_requestedInitialFocus) return;
    _requestedInitialFocus = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) FocusScope.of(context).nextFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    const actionHeight = PaperComponentMetrics.tagHeight;
    const actionReserve =
        actionHeight - PaperComponentMetrics.dialogActionOverlap;
    const minimumOutsideHeight =
        PaperComponentMetrics.dialogMinimumSheetHeight + actionReserve;

    return Semantics(
      container: true,
      label: widget.title,
      child: Material(
        type: MaterialType.transparency,
        child: FocusTraversalGroup(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final topInset = math.min(
                    PaperComponentMetrics.dialogTopInset,
                    constraints.maxHeight,
                  );
                  final availableHeight =
                      math.max(0, constraints.maxHeight - topInset).toDouble();
                  final actionsBelowSheet =
                      availableHeight >= minimumOutsideHeight;
                  final sheetHeight = actionsBelowSheet
                      ? availableHeight - actionReserve
                      : availableHeight;
                  final actionsTop = actionsBelowSheet
                      ? sheetHeight - PaperComponentMetrics.dialogActionOverlap
                      : math.max(0, availableHeight - actionHeight).toDouble();

                  return Padding(
                    padding: EdgeInsets.only(top: topInset),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:
                            PaperComponentMetrics.dialogHorizontalMargin,
                      ),
                      child: SizedBox(
                        height: availableHeight,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              height: sheetHeight,
                              child: TornPaperSheet(
                                color: TornPaperColor.warm,
                                decoration: TornPaperDecoration.tape,
                                rotationDegrees: widget.rotationDegrees,
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        widget.title,
                                        style: theme.h1.copyWith(
                                          color: theme.deepGreen,
                                          fontSize: PaperComponentMetrics
                                              .dialogTitleFontSize,
                                        ),
                                      ),
                                      widget.child,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: actionsTop,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    for (var index = 0;
                                        index < widget.actions.length;
                                        index++) ...[
                                      if (index > 0)
                                        const SizedBox(
                                          width: PaperComponentMetrics
                                              .dialogActionSpacing,
                                        ),
                                      widget.actions[index],
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
