import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';

Future<T?> showPaperDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool dismissible = true,
}) {
  final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: dismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: context.piantala.ink.withValues(
      alpha: PaperComponentMetrics.dialogBarrierOpacity,
    ),
    transitionDuration: reduceMotion
        ? Duration.zero
        : const Duration(
            milliseconds: PaperComponentMetrics.dialogFadeMilliseconds,
          ),
    pageBuilder: (context, animation, secondaryAnimation) => builder(context),
    transitionBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}
