import 'package:material_ui/material_ui.dart';

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

    return Container(
      constraints: const BoxConstraints(
        maxWidth: HomeMetrics.nameTagMaxWidth,
      ),
      height: HomeMetrics.nameTagHeight,
      padding: const EdgeInsets.symmetric(
        horizontal: HomeMetrics.nameTagHorizontalPadding,
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
        softWrap: false,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        textScaler: TextScaler.noScaling,
        style: theme.body.copyWith(
          fontSize: HomeMetrics.nameTagFontSize,
          height: 1.15,
          color: theme.ink,
        ),
      ),
    );
  }
}
