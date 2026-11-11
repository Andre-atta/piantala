import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/presentation/widgets/common/torn_paper_sheet.dart';

Widget _app({
  required TornPaperColor color,
  required bool ruled,
  double textScale = 1,
}) {
  return MaterialApp(
    theme: ThemeData(
      extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
    ),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textScale),
      ),
      child: child!,
    ),
    home: Scaffold(
      body: Center(
        child: RepaintBoundary(
          key: const ValueKey('torn-paper-sheet-golden'),
          child: SizedBox(
            width: 280,
            child: TornPaperSheet(
              color: color,
              decoration: TornPaperDecoration.tape,
              rotationDegrees: 0.8,
              ruled: ruled,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Foglie sane e luce indiretta, con attenzione '
                    'all’acqua durante tutta la settimana.',
                  ),
                  SizedBox(height: 180),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders color and ruled goldens', (tester) async {
    for (final color in TornPaperColor.values) {
      for (final ruled in [false, true]) {
        await tester.pumpWidget(_app(color: color, ruled: ruled));
        await tester.pumpAndSettle();

        await expectLater(
          find.byKey(const ValueKey('torn-paper-sheet-golden')),
          matchesGoldenFile(
            'goldens/torn_paper_${color.name}_${ruled ? 'ruled' : 'plain'}.png',
          ),
        );
      }
    }
  });

  testWidgets('fits text at 1.5 scale without overflow', (tester) async {
    await tester.pumpWidget(
      _app(color: TornPaperColor.paperTan, ruled: true, textScale: 1.5),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
