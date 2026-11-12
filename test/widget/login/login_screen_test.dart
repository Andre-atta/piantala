import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/screens/login/login_screen.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';

class _FakeAuthController extends AuthController {
  int googleSignInCalls = 0;
  Completer<void>? googleSignInCompleter;

  @override
  FutureOr<void> build() {}

  @override
  Future<void> signInWithGoogle() async {
    googleSignInCalls++;
    state = const AsyncLoading();
    await googleSignInCompleter?.future;
    state = const AsyncData(null);
  }
}

Widget _app({
  required _FakeAuthController authController,
  double textScale = 1,
  Locale locale = const Locale('it'),
}) {
  return ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(() => authController),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: TemporalTheme.buildTheme(TemporalPeriod.night),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaler: TextScaler.linear(textScale),
        ),
        child: child!,
      ),
      home: const LoginScreen(),
    ),
  );
}

void main() {
  testWidgets('renders illustrated day login and complete action semantics',
      (tester) async {
    final controller = _FakeAuthController();
    await tester.pumpWidget(_app(authController: controller));
    await tester.pumpAndSettle();

    expect(find.text('Ciao'), findsOneWidget);
    expect(find.text('Piantala'), findsOneWidget);
    expect(
      find.text('Le tue piante, una mensola alla volta.'),
      findsOneWidget,
    );
    expect(find.byType(OutlinedButton), findsNothing);
    expect(find.byType(ElevatedButton), findsNothing);
    expect(find.byType(Image), findsNWidgets(2));
    final theme = Theme.of(
      tester.element(find.byKey(const ValueKey('login-google'))),
    );
    expect(theme.brightness, Brightness.light);
    expect(
      theme.extension<PiantalaTheme>()!.display.fontFamily,
      'Sue Ellen Francisco',
    );

    final semantics = tester.ensureSemantics();
    expect(
      tester.getSemantics(find.byKey(const ValueKey('login-google'))).label,
      'Continua con Google',
    );
    expect(
      tester.getSemantics(find.byKey(const ValueKey('login-email'))).label,
      'Accedi con email',
    );
    expect(
      tester.getSemantics(find.text('Piantala')),
      matchesSemantics(
        label: 'Piantala',
        isHeader: true,
      ),
    );

    final googleTag = find.byKey(const ValueKey('login-google'));
    await tester.ensureVisible(googleTag);
    await tester.tap(googleTag);
    await tester.pump();
    expect(controller.googleSignInCalls, 1);
    semantics.dispose();
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps login actions reachable at 360x640 and text scale 1.5',
      (tester) async {
    tester.view
      ..physicalSize = const Size(360, 640)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _app(authController: _FakeAuthController(), textScale: 1.5),
    );
    await tester.pumpAndSettle();

    final googleTag = find.byKey(const ValueKey('login-google'));
    final emailTag = find.byKey(const ValueKey('login-email'));
    await tester.scrollUntilVisible(googleTag, 100);
    await tester.scrollUntilVisible(emailTag, 100);
    await tester.ensureVisible(emailTag);
    await tester.pumpAndSettle();
    expect(tester.getRect(googleTag).bottom, lessThanOrEqualTo(640));
    expect(tester.getRect(emailTag).bottom, lessThanOrEqualTo(640));
    await tester.tap(emailTag);
    await tester.pumpAndSettle();
    expect(find.text('Email'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('disables both tags while Google sign-in is loading',
      (tester) async {
    final controller = _FakeAuthController()
      ..googleSignInCompleter = Completer<void>();
    await tester.pumpWidget(_app(authController: controller));
    await tester.pumpAndSettle();

    final googleTag = find.byKey(const ValueKey('login-google'));
    await tester.ensureVisible(googleTag);
    await tester.tap(googleTag);
    await tester.pump();

    expect(tester.widget<HangingTag>(googleTag).onPressed, isNull);
    expect(
      tester
          .widget<HangingTag>(find.byKey(const ValueKey('login-email')))
          .onPressed,
      isNull,
    );

    controller.googleSignInCompleter!.complete();
    await tester.pumpAndSettle();
    expect(tester.widget<HangingTag>(googleTag).onPressed, isNotNull);
  });

  testWidgets('email tag opens the existing authentication sheet',
      (tester) async {
    await tester.pumpWidget(_app(authController: _FakeAuthController()));
    await tester.pumpAndSettle();

    final emailTag = find.byKey(const ValueKey('login-email'));
    await tester.scrollUntilVisible(emailTag, 100);
    await tester.tap(emailTag);
    await tester.pumpAndSettle();

    expect(find.text('Accedi con email'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('uses localized English login copy', (tester) async {
    await tester.pumpWidget(
      _app(
        authController: _FakeAuthController(),
        locale: const Locale('en'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hello'), findsOneWidget);
    expect(find.text('Your plants, one shelf at a time.'), findsOneWidget);
    expect(find.bySemanticsLabel('the Privacy Policy'), findsOneWidget);
  });
}
