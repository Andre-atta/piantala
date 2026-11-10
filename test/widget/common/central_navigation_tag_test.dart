import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/presentation/widgets/common/central_navigation_tag.dart';

Widget _app(Widget child) {
  return MaterialApp(
    theme: ThemeData(
      extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
    ),
    home: Center(
      child: RepaintBoundary(
        key: const ValueKey('central-tag-golden'),
        child: SizedBox(
          width: 160,
          height: 120,
          child: Center(child: child),
        ),
      ),
    ),
  );
}

CentralNavigationTag _tag({VoidCallback? onPressed}) => CentralNavigationTag(
      iconAsset: 'assets/svg/nav/fab_pot.svg',
      label: 'nuova pianta',
      onPressed: onPressed ?? () {},
    );

void main() {
  testWidgets('renders its normal golden and has a large accessible target',
      (tester) async {
    await tester.pumpWidget(_app(_tag()));
    await tester.pumpAndSettle();

    expect(
      tester.getSize(find.byKey(const ValueKey('navigation-create-button'))),
      const Size(108, 72),
    );
    await expectLater(
      find.byKey(const ValueKey('central-tag-golden')),
      matchesGoldenFile('goldens/central_navigation_tag.png'),
    );
  });

  testWidgets('renders the pressed golden and invokes the action',
      (tester) async {
    var pressed = false;
    await tester.pumpWidget(_app(_tag(onPressed: () => pressed = true)));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const ValueKey('navigation-create-button'))),
    );
    await tester.pump(
      const Duration(milliseconds: 150),
    );

    await expectLater(
      find.byKey(const ValueKey('central-tag-golden')),
      matchesGoldenFile('goldens/central_navigation_tag_pressed.png'),
    );

    await gesture.up();
    await tester.pumpAndSettle();
    expect(pressed, isTrue);
  });

  testWidgets('scales text without overflow and respects reduced motion',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            disableAnimations: true,
            textScaler: const TextScaler.linear(1.5),
          ),
          child: child!,
        ),
        home: Scaffold(body: Center(child: _tag())),
      ),
    );
    await tester.pumpAndSettle();

    final size = tester.getSize(
      find.byKey(const ValueKey('navigation-create-button')),
    );
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);
  });
}
