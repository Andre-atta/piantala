import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/widgets/common/piantala_navigation_bar.dart';

Widget _app({
  required int selectedIndex,
  required VoidCallback onCreate,
  double textScale = 1,
  bool disableAnimations = false,
}) {
  return MaterialApp(
    locale: const Locale('it'),
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    theme: ThemeData(
      extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
    ),
    home: Builder(
      builder: (context) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          disableAnimations: disableAnimations,
          textScaler: TextScaler.linear(textScale),
        ),
        child: Center(
          child: RepaintBoundary(
            key: const ValueKey('navigation-bar-golden'),
            child: SizedBox(
              width: 390,
              height: 104,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: PiantalaNavigationBar(
                  selectedIndex: selectedIndex,
                  isRoomsRoute: false,
                  onDestinationSelected: (_) {},
                  onCreatePressed: onCreate,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders its normal golden and all navigation targets',
      (tester) async {
    await tester.pumpWidget(_app(selectedIndex: 0, onCreate: () {}));
    await tester.pumpAndSettle();

    for (var index = 0; index < 4; index++) {
      final size = tester.getSize(
        find.byKey(ValueKey('navigation-$index')),
      );
      expect(size.width, greaterThanOrEqualTo(48));
      expect(size.height, greaterThanOrEqualTo(48));
    }
    expect(
      tester.getSize(find.byKey(const ValueKey('navigation-create-button'))),
      const Size(108, 72),
    );
    await expectLater(
      find.byKey(const ValueKey('navigation-bar-golden')),
      matchesGoldenFile('goldens/piantala_navigation_bar.png'),
    );
  });

  testWidgets('renders the navigation golden with a pressed destination',
      (tester) async {
    await tester.pumpWidget(_app(selectedIndex: 0, onCreate: () {}));
    final gesture = await tester.startGesture(
      tester.getCenter(find.byKey(const ValueKey('navigation-1'))),
    );
    await tester.pump(const Duration(milliseconds: 150));

    await expectLater(
      find.byKey(const ValueKey('navigation-bar-golden')),
      matchesGoldenFile('goldens/piantala_navigation_bar_pressed.png'),
    );

    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('shows the localized room action and avoids text overflow',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('it'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.5),
          ),
          child: child!,
        ),
        home: Center(
          child: SizedBox(
            width: 390,
            height: 104,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: PiantalaNavigationBar(
                selectedIndex: 1,
                isRoomsRoute: true,
                onDestinationSelected: (_) {},
                onCreatePressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('nuova stanza'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('center action invokes callback and observes reduced motion',
      (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      _app(
        selectedIndex: 0,
        onCreate: () => pressed = true,
        disableAnimations: true,
        textScale: 1.5,
      ),
    );
    await tester.tap(find.byKey(const ValueKey('navigation-create-button')));
    await tester.pumpAndSettle();

    expect(pressed, isTrue);
    expect(tester.takeException(), isNull);
  });
}
