import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/screens/login/login_screen.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/paper_text_field.dart';

class _FakeAuthController extends AuthController {
  int googleSignInCalls = 0;
  int emailSignInCalls = 0;
  int registrationCalls = 0;
  int resetCalls = 0;
  Completer<void>? googleSignInCompleter;
  Completer<void>? operationCompleter;
  String? submittedEmail;
  String? submittedPassword;
  AuthFailure? nextFailure;

  @override
  FutureOr<void> build() {}

  @override
  Future<void> signInWithGoogle() async {
    googleSignInCalls++;
    state = const AsyncLoading();
    await googleSignInCompleter?.future;
    state = const AsyncData(null);
  }

  @override
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    emailSignInCalls++;
    submittedEmail = email;
    submittedPassword = password;
    await _completeNextOperation();
  }

  @override
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String displayName,
  ) async {
    registrationCalls++;
    submittedEmail = email;
    submittedPassword = password;
    await _completeNextOperation();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    resetCalls++;
    submittedEmail = email;
    await _completeNextOperation();
  }

  Future<void> _completeNextOperation() async {
    if (operationCompleter != null) {
      state = const AsyncLoading();
      await operationCompleter!.future;
    }
    final failure = nextFailure;
    nextFailure = null;
    if (failure == null) {
      state = const AsyncData(null);
    } else {
      state = AsyncError(
        AuthException('firebase-internal-detail', failure: failure),
        StackTrace.current,
      );
    }
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

Future<void> _openEmailDialog(
  WidgetTester tester,
  _FakeAuthController controller, {
  double textScale = 1,
}) async {
  await tester.pumpWidget(
    _app(authController: controller, textScale: textScale),
  );
  await tester.pumpAndSettle();
  final googleTag = find.byKey(const ValueKey('login-google'));
  final emailTag = find.byKey(const ValueKey('login-email'));
  await tester.scrollUntilVisible(googleTag, 100);
  await tester.scrollUntilVisible(emailTag, 100);
  await tester.drag(find.byType(ListView).first, const Offset(0, -200));
  await tester.pumpAndSettle();
  await tester.ensureVisible(emailTag);
  await tester.tap(emailTag);
  await tester.pumpAndSettle();
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
    expect(find.byType(PaperDialogScaffold), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
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

  testWidgets('email opens a paper dialog and switches to registration',
      (tester) async {
    await _openEmailDialog(tester, _FakeAuthController());

    expect(find.byType(PaperDialogScaffold), findsOneWidget);
    expect(find.text('Accedi'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    await tester.tap(find.text('Non hai un account? Registrati'));
    await tester.pumpAndSettle();

    expect(find.text('Crea account'), findsOneWidget);
    expect(find.text('NOME'), findsOneWidget);
    expect(find.text('CONFERMA PASSWORD'), findsOneWidget);
    expect(find.textContaining("Creando l'account accetti"), findsOneWidget);
    expect(find.text('Hai già un account? Accedi'), findsOneWidget);

    final passwordField = tester.widget<PaperTextField>(
      find.ancestor(
        of: find.byKey(const ValueKey('auth-password-field')),
        matching: find.byType(PaperTextField),
      ),
    );
    expect(passwordField.obscureText, isTrue);
    expect(passwordField.enableSuggestions, isFalse);
    expect(passwordField.autocorrect, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('trims email and closes after successful login', (tester) async {
    final controller = _FakeAuthController();
    await _openEmailDialog(tester, controller);

    await tester.enterText(
      find.byKey(const ValueKey('auth-email-field')),
      '  person@example.com  ',
    );
    await tester.enterText(
      find.byKey(const ValueKey('auth-password-field')),
      'secret1',
    );
    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pumpAndSettle();

    expect(controller.emailSignInCalls, 1);
    expect(controller.submittedEmail, 'person@example.com');
    expect(controller.submittedPassword, 'secret1');
    expect(find.byType(PaperDialogScaffold), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('shows neutral localized auth errors without raw exceptions',
      (tester) async {
    final controller = _FakeAuthController()
      ..nextFailure = AuthFailure.invalidCredential;
    await _openEmailDialog(tester, controller);

    await tester.enterText(
      find.byKey(const ValueKey('auth-email-field')),
      'person@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('auth-password-field')),
      'secret1',
    );
    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Email o password non validi.'), findsOneWidget);
    expect(find.text('firebase-internal-detail'), findsNothing);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('wraps and announces long auth errors in a live region',
      (tester) async {
    tester.view
      ..physicalSize = const Size(360, 640)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = _FakeAuthController()
      ..nextFailure = AuthFailure.tooManyRequests;
    await _openEmailDialog(tester, controller, textScale: 1.5);
    await tester.enterText(
      find.byKey(const ValueKey('auth-email-field')),
      'person@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('auth-password-field')),
      'secret1',
    );
    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pumpAndSettle();

    final errorText = find.text('Troppi tentativi. Riprova più tardi.');
    expect(errorText, findsOneWidget);
    expect(tester.widget<Text>(errorText).maxLines, isNull);
    expect(tester.getSize(errorText).height, greaterThan(20));
    expect(
      tester.getSemantics(errorText).flagsCollection.isLiveRegion,
      isTrue,
    );
    expect(find.byType(SnackBar), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'password reset reports neutral success in dialog and disables tag',
      (tester) async {
    final controller = _FakeAuthController()
      ..nextFailure = AuthFailure.resetEmailSent;
    await _openEmailDialog(tester, controller);

    await tester.tap(find.text('Password dimenticata?'));
    await tester.pumpAndSettle();
    expect(find.text('Recupera password'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('auth-email-field')),
      '  person@example.com ',
    );
    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pumpAndSettle();

    expect(controller.resetCalls, 1);
    expect(controller.submittedEmail, 'person@example.com');
    expect(
      find.text(
        "Se l'indirizzo è associato a un account, riceverai le istruzioni.",
      ),
      findsOneWidget,
    );
    expect(
      tester
          .widget<HangingTag>(find.byKey(const ValueKey('email-auth-submit')))
          .onPressed,
      isNull,
    );
    await tester.enterText(
      find.byKey(const ValueKey('auth-email-field')),
      'updated@example.com',
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<HangingTag>(find.byKey(const ValueKey('email-auth-submit')))
          .onPressed,
      isNotNull,
    );
    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pumpAndSettle();
    expect(controller.resetCalls, 2);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('registration validation stays inline and no request is sent',
      (tester) async {
    final controller = _FakeAuthController();
    await _openEmailDialog(tester, controller);
    await tester.tap(find.text('Non hai un account? Registrati'));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pumpAndSettle();

    expect(find.text('Inserisci il tuo nome'), findsOneWidget);
    expect(find.text('Inserisci un indirizzo email valido'), findsOneWidget);
    expect(find.text('Usa almeno 6 caratteri'), findsOneWidget);
    expect(controller.registrationCalls, 0);
    expect(find.byType(SnackBar), findsNothing);
  });

  testWidgets('disables submit tag while authentication is loading',
      (tester) async {
    final controller = _FakeAuthController()
      ..operationCompleter = Completer<void>();
    await _openEmailDialog(tester, controller);
    await tester.enterText(
      find.byKey(const ValueKey('auth-email-field')),
      'person@example.com',
    );
    await tester.enterText(
      find.byKey(const ValueKey('auth-password-field')),
      'secret1',
    );
    await tester.tap(find.byKey(const ValueKey('email-auth-submit')));
    await tester.pump();

    expect(
      tester
          .widget<HangingTag>(find.byKey(const ValueKey('email-auth-submit')))
          .onPressed,
      isNull,
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);

    controller.operationCompleter!.complete();
    await tester.pumpAndSettle();
    expect(find.byType(PaperDialogScaffold), findsNothing);
  });

  testWidgets('registration at text scale 1.5 has no overflow or small targets',
      (tester) async {
    tester.view
      ..physicalSize = const Size(360, 640)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final controller = _FakeAuthController();
    await _openEmailDialog(tester, controller, textScale: 1.5);
    final registrationLink = find.text('Non hai un account? Registrati');
    await tester.ensureVisible(registrationLink);
    await tester.tap(registrationLink);
    await tester.pumpAndSettle();

    final cancelTag = find.byKey(const ValueKey('email-auth-cancel'));
    final submitTag = find.byKey(const ValueKey('email-auth-submit'));
    expect(tester.getSize(cancelTag).width, greaterThanOrEqualTo(48));
    expect(tester.getSize(cancelTag).height, greaterThanOrEqualTo(48));
    expect(tester.getSize(submitTag).width, greaterThanOrEqualTo(48));
    expect(tester.getSize(submitTag).height, greaterThanOrEqualTo(48));

    final passwordField = find.ancestor(
      of: find.byKey(const ValueKey('auth-password-field')),
      matching: find.byType(PaperTextField),
    );
    expect(tester.getSize(passwordField).height, greaterThanOrEqualTo(48));
    final eyeTargets = find.bySemanticsLabel('Mostra password');
    expect(eyeTargets, findsNWidgets(2));
    for (var index = 0; index < eyeTargets.evaluate().length; index++) {
      final eyeTarget = eyeTargets.at(index);
      expect(tester.getSize(eyeTarget).width, greaterThanOrEqualTo(48));
      expect(tester.getSize(eyeTarget).height, greaterThanOrEqualTo(48));
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps form scrollable and action tags above the keyboard',
      (tester) async {
    tester.view
      ..physicalSize = const Size(360, 640)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);

    await _openEmailDialog(tester, _FakeAuthController());
    tester.view.viewInsets = const FakeViewPadding(bottom: 320);
    await tester.pumpAndSettle();

    const keyboardTop = 320.0;
    for (final key in [
      const ValueKey('email-auth-cancel'),
      const ValueKey('email-auth-submit'),
    ]) {
      expect(
        tester.getRect(find.byKey(key)).bottom,
        lessThanOrEqualTo(keyboardTop),
      );
    }
    expect(
      tester.getRect(find.byKey(const ValueKey('auth-email-field'))).top,
      lessThan(keyboardTop),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('uses localized English login and auth dialog copy',
      (tester) async {
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

    final emailTag = find.byKey(const ValueKey('login-email'));
    await tester.ensureVisible(emailTag);
    await tester.tap(emailTag);
    await tester.pumpAndSettle();
    expect(find.text('Sign in'), findsOneWidget);
  });
}
