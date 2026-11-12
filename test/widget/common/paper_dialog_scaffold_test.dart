import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/torn_paper_sheet.dart';

const _scaffoldGoldenKey = ValueKey('paper-dialog-scaffold-golden');

void _setScreenSize(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(390, 844)
    ..devicePixelRatio = 1
    ..viewPadding = const FakeViewPadding(top: 24, bottom: 24);
}

Widget _app({
  required int actionCount,
  required FocusNode fieldFocusNode,
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
      colorScheme: ColorScheme.fromSeed(
        seedColor: PiantalaTheme.standard.deepGreen,
      ),
      extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
    ),
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        disableAnimations: disableAnimations,
      ),
      child: RepaintBoundary(
        key: _scaffoldGoldenKey,
        child: child,
      ),
    ),
    home: Builder(
      builder: (context) => Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () {
              showPaperDialog<void>(
                context: context,
                builder: (dialogContext) {
                  final l10n = AppLocalizations.of(dialogContext)!;
                  return PaperDialogScaffold(
                    title: l10n.roomDialogNewTitle,
                    actions: [
                      if (actionCount == 2)
                        HangingTag(
                          label: l10n.commonCancel,
                          variant: HangingTagVariant.secondary,
                          mirrored: true,
                          onPressed: () => Navigator.pop(dialogContext),
                        ),
                      HangingTag(
                        label: l10n.commonSave,
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ],
                    child: TextField(
                      focusNode: fieldFocusNode,
                      decoration: InputDecoration(
                        labelText: l10n.roomDialogNameLabel,
                      ),
                    ),
                  );
                },
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    ),
  );
}

Future<void> _openDialog(
  WidgetTester tester, {
  required int actionCount,
  required FocusNode fieldFocusNode,
}) async {
  await tester.pumpWidget(
    _app(actionCount: actionCount, fieldFocusNode: fieldFocusNode),
  );
  await tester.tap(find.byType(TextButton));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('renders one-action and two-action dialog goldens',
      (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewPadding);

    for (final actionCount in [1, 2]) {
      final focusNode = FocusNode();
      addTearDown(focusNode.dispose);
      await _openDialog(
        tester,
        actionCount: actionCount,
        fieldFocusNode: focusNode,
      );

      expect(focusNode.hasFocus, isTrue);
      expect(find.byType(TornPaperSheet), findsOneWidget);
      expect(
        tester.getTopLeft(find.byType(TornPaperSheet)).dy,
        greaterThanOrEqualTo(84),
      );
      expect(tester.takeException(), isNull);
      await expectLater(
        find.byKey(_scaffoldGoldenKey),
        matchesGoldenFile(
          'goldens/paper_dialog_${actionCount}_action.png',
        ),
      );
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();
    }
  });

  testWidgets('dismisses by tapping outside or using system back',
      (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewPadding);

    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    await _openDialog(
      tester,
      actionCount: 1,
      fieldFocusNode: focusNode,
    );
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();
    expect(find.byType(PaperDialogScaffold), findsNothing);

    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();
    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();
    expect(find.byType(PaperDialogScaffold), findsNothing);
  });

  testWidgets('uses no fade when animations are disabled', (tester) async {
    final focusNode = FocusNode();
    addTearDown(focusNode.dispose);
    await tester.pumpWidget(
      _app(
        actionCount: 1,
        fieldFocusNode: focusNode,
        disableAnimations: true,
      ),
    );
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    expect(find.byType(PaperDialogScaffold), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
