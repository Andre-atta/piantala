import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/compass_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/compass_scanner_dialog.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';

const _compassGoldenKey = ValueKey('compass-dialog-golden');

({Widget widget, GlobalKey<_CompassTestHostState> hostKey}) _app({
  required Stream<double?> stream,
  double textScale = 1,
}) {
  final hostKey = GlobalKey<_CompassTestHostState>();
  return (
    hostKey: hostKey,
    widget: ProviderScope(
      overrides: [
        compassHeadingStreamProvider.overrideWith((ref) => stream),
      ],
      child: MaterialApp(
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
            textScaler: TextScaler.linear(textScale),
          ),
          child: RepaintBoundary(
            key: _compassGoldenKey,
            child: child,
          ),
        ),
        home: _CompassTestHost(key: hostKey),
      ),
    ),
  );
}

class _CompassTestHost extends StatefulWidget {
  const _CompassTestHost({required super.key});

  @override
  State<_CompassTestHost> createState() => _CompassTestHostState();
}

class _CompassTestHostState extends State<_CompassTestHost> {
  String? result;
  bool dialogClosed = false;

  Future<void> open() async {
    result = await showPaperDialog<String>(
      context: context,
      builder: (context) => const CompassScannerDialog(),
    );
    if (mounted) setState(() => dialogClosed = true);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: PiantalaTheme.standard.cream,
        body: Center(
          child: TextButton(
            onPressed: open,
            child: const Text('Open'),
          ),
        ),
      );
}

Future<void> _open(WidgetTester tester, Widget app) async {
  await tester.pumpWidget(app);
  await tester.tap(find.byType(TextButton));
  await tester.pumpAndSettle();
}

void _setScreenSize(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(390, 844)
    ..devicePixelRatio = 1
    ..viewPadding = const FakeViewPadding(top: 24, bottom: 24);
}

void main() {
  testWidgets('shows first heading and restarts the stability progress',
      (tester) async {
    final controller = StreamController<double?>.broadcast();
    addTearDown(controller.close);
    final app = _app(stream: controller.stream);
    await _open(tester, app.widget);
    controller.add(270);
    await tester.pump(const Duration(milliseconds: 20));
    expect(find.text('Ovest'), findsOneWidget);
    expect(find.text('Tieni fermo per: 3 s'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.text('Tieni fermo per: 1 s'), findsOneWidget);
    controller.add(281);
    await tester.pump(const Duration(milliseconds: 20));
    expect(find.text('Tieni fermo per: 3 s'), findsOneWidget);
  });

  testWidgets('locks after three steady seconds, retries, and saves code',
      (tester) async {
    final controller = StreamController<double?>.broadcast();
    addTearDown(controller.close);
    final app = _app(stream: controller.stream);
    await _open(tester, app.widget);

    controller.add(270);
    await tester.pump(const Duration(milliseconds: 20));
    await tester.pump(const Duration(milliseconds: 3020));
    expect(find.text('Direzione rilevata'), findsOneWidget);
    expect(find.text('Esposizione rilevata'), findsOneWidget);
    expect(find.byType(HangingTag), findsNWidgets(2));

    final semantics = tester.ensureSemantics();
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Riprova'));
    await tester.pumpAndSettle();
    expect(find.text('Tieni fermo per: 3 s'), findsOneWidget);
    expect(find.byType(HangingTag), findsOneWidget);

    controller.add(270);
    await tester.pump(const Duration(milliseconds: 20));
    await tester.pump(const Duration(milliseconds: 3020));
    await tester.tap(find.bySemanticsLabel('Salva'));
    await tester.pumpAndSettle();
    semantics.dispose();
    expect(app.hostKey.currentState!.result, 'W');
    expect(app.hostKey.currentState!.dialogClosed, isTrue);
  });

  testWidgets('cancel returns null', (tester) async {
    final controller = StreamController<double?>.broadcast();
    addTearDown(controller.close);
    final app = _app(stream: controller.stream);
    await _open(tester, app.widget);

    await tester.tap(find.byType(HangingTag));
    await tester.pumpAndSettle();

    expect(app.hostKey.currentState!.result, isNull);
    expect(app.hostKey.currentState!.dialogClosed, isTrue);
  });

  testWidgets('shows unavailable after five seconds without a sensor',
      (tester) async {
    final app = _app(stream: const Stream<double?>.empty());
    await _open(tester, app.widget);

    expect(find.byType(HangingTag), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));

    expect(find.text('Bussola non disponibile'), findsOneWidget);
    expect(find.byType(HangingTag), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders in-progress and locked compass goldens', (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewPadding);
    final controller = StreamController<double?>.broadcast();
    addTearDown(controller.close);
    final app = _app(stream: controller.stream, textScale: 1.5);
    await _open(tester, app.widget);

    controller.add(270);
    await tester.pump(const Duration(milliseconds: 20));
    await expectLater(
      find.byKey(_compassGoldenKey),
      matchesGoldenFile('goldens/compass_scanner_in_progress.png'),
    );
    expect(tester.takeException(), isNull);

    await tester.pump(const Duration(seconds: 3));
    await expectLater(
      find.byKey(_compassGoldenKey),
      matchesGoldenFile('goldens/compass_scanner_locked.png'),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('exposes compass direction semantics', (tester) async {
    final controller = StreamController<double?>.broadcast();
    addTearDown(controller.close);
    final app = _app(stream: controller.stream);
    await _open(tester, app.widget);
    controller.add(270);
    await tester.pump(const Duration(milliseconds: 20));

    final semantics = tester.ensureSemantics();
    expect(
      find.bySemanticsLabel('Bussola, direzione Ovest'),
      findsOneWidget,
    );
    semantics.dispose();
    expect(find.byType(PaperDialogScaffold), findsOneWidget);
  });
}
