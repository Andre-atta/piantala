import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/screens/login/login_screen.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';

class _GoldenAuthController extends AuthController {
  @override
  Future<void> build() async {}
}

Widget _app(Locale locale) {
  return ProviderScope(
    overrides: [
      authControllerProvider.overrideWith(_GoldenAuthController.new),
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
        data: MediaQuery.of(context).copyWith(disableAnimations: true),
        child: child!,
      ),
      home: const LoginScreen(),
    ),
  );
}

void main() {
  for (final locale in [const Locale('it'), const Locale('en')]) {
    for (final mode in ['home', 'login', 'registration', 'reset']) {
      testWidgets('renders $locale login $mode golden at 360x800',
          (tester) async {
        tester.view
          ..physicalSize = const Size(360, 800)
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(_app(locale));
        await tester.pumpAndSettle();

        if (mode != 'home') {
          final emailTag = find.byKey(const ValueKey('login-email'));
          await tester.scrollUntilVisible(emailTag, 100);
          await tester.ensureVisible(emailTag);
          await tester.tap(emailTag);
          await tester.pumpAndSettle();

          final l10n = AppLocalizations.of(
            tester.element(find.byType(LoginScreen)),
          )!;
          if (mode == 'registration') {
            await tester.tap(find.text(l10n.authButtonGoToRegister));
            await tester.pumpAndSettle();
          } else if (mode == 'reset') {
            await tester.tap(find.text(l10n.authButtonForgotPassword));
            await tester.pumpAndSettle();
          }
          expect(find.byType(PaperDialogScaffold), findsOneWidget);
        }

        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('goldens/login_${locale.languageCode}_$mode.png'),
        );
        expect(tester.takeException(), isNull);
      });
    }
  }
}
