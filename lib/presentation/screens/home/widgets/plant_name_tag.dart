import 'package:flutter/material.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';

class PlantNameTag extends StatelessWidget {
  const PlantNameTag({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: HomeMetrics.plantTagMaxWidth,
        minHeight: HomeMetrics.plantTagHeight,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: HomeMetrics.plantTagHorizontalPadding,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.cream,
          border: Border.all(
            color: theme.ink,
          ),
        ),
        child: Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.body.copyWith(
            fontSize: HomeMetrics.plantTagFontSize,
            height: 1,
            color: theme.ink,
          ),
        ),
      ),
    );
  }
}
