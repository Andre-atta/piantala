import 'package:flutter/material.dart';

import 'package:piantala/core/theme/piantala_theme.dart';

extension PiantalaThemeContext on BuildContext {
  PiantalaTheme get piantala => Theme.of(this).extension<PiantalaTheme>()!;
}
