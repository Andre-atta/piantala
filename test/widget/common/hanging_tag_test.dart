import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';

enum _TagState { normal, pressed, disabled, mirrored }

Widget _app({
  required HangingTagVariant variant,
  required _TagState state,
  String label = 'Salva',
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
          key: const ValueKey('hanging-tag-golden'),
          child: SizedBox(
            width: 180,
            height: 100,
            child: Center(
              child: HangingTag(
                label: label,
                variant: variant,
                onPressed: state == _TagState.disabled ? null : () {},
                mirrored: state == _TagState.mirrored,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders normal, pressed, disabled, and mirrored goldens',
      (tester) async {
    for (final variant in HangingTagVariant.values) {
      for (final state in _TagState.values) {
        await tester.pumpWidget(_app(variant: variant, state: state));
        TestGesture? gesture;
        if (state == _TagState.pressed) {
          gesture = await tester.startGesture(
            tester.getCenter(find.byType(HangingTag)),
          );
          await tester.pump(const Duration(milliseconds: 150));
        } else {
          await tester.pumpAndSettle();
        }

        await expectLater(
          find.byKey(const ValueKey('hanging-tag-golden')),
          matchesGoldenFile(
            'goldens/hanging_tag_${variant.name}_${state.name}.png',
          ),
        );
        await gesture?.up();
        await tester.pumpAndSettle();
      }
    }
  });

  testWidgets('has a 48 dp target, grows for long labels, and is semantic',
      (tester) async {
    await tester.pumpWidget(
      _app(
        variant: HangingTagVariant.primary,
        state: _TagState.normal,
        label: 'Aggiornamento delle impostazioni',
      ),
    );

    final size = tester.getSize(find.byType(HangingTag));
    expect(size.width, greaterThanOrEqualTo(112));
    expect(size.height, greaterThanOrEqualTo(48));
    expect(size.width, greaterThan(112));
    expect(
      tester.getSemantics(find.byType(HangingTag)),
      matchesSemantics(
        label: 'Aggiornamento delle impostazioni',
        isButton: true,
        hasEnabledState: true,
        isEnabled: true,
        hasTapAction: true,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('fits text at 1.5 scale without overflow', (tester) async {
    await tester.pumpWidget(
      _app(
        variant: HangingTagVariant.primary,
        state: _TagState.normal,
        textScale: 1.5,
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}
