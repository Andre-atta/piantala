import 'package:material_ui/material_ui.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';

/// Sfondo della stanza (parete sopra il pavimento).
class WoodPatternBackground extends StatelessWidget {
  const WoodPatternBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return ColoredBox(
      color: theme.cabinetBack,
    );
  }
}
