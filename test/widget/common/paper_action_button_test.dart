import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/presentation/widgets/common/paper_action_button.dart';

Widget _app({
  required VoidCallback onPressed,
  double textScale = 1,
}) {
  return MaterialApp(
    theme: ThemeData(
      extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
    ),
    home: Center(
      child: MediaQuery(
        data: const MediaQueryData().copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: RepaintBoundary(
          key: const ValueKey('paper-action-button-golden'),
          child: SizedBox(
            width: 240,
            child: Align(
              child: PaperActionButton(
                label: 'Aggiungi pianta',
                onPressed: onPressed,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders its normal golden and has a 48 dp target',
      (tester) async {
    await tester.pumpWidget(_app(onPressed: () {}));
    await tester.pumpAndSettle();

    final size = tester.getSize(find.byType(PaperActionButton));
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
    await expectLater(
      find.byKey(const ValueKey('paper-action-button-golden')),
      matchesGoldenFile('goldens/paper_action_button.png'),
    );
  });

  testWidgets('renders the pressed state golden', (tester) async {
    await tester.pumpWidget(_app(onPressed: () {}));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(PaperActionButton)),
    );
    await tester.pump(const Duration(milliseconds: 150));

    await expectLater(
      find.byKey(const ValueKey('paper-action-button-golden')),
      matchesGoldenFile('goldens/paper_action_button_pressed.png'),
    );

    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('fits text at 1.5 scale without overflow', (tester) async {
    await tester.pumpWidget(
      _app(onPressed: () {}, textScale: 1.5),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
