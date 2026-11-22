import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';
import 'package:piantala/presentation/widgets/common/paper_text_field.dart';
import 'package:piantala/presentation/widgets/common/paper_text_link.dart';

const _fieldGoldenKey = ValueKey('paper-text-field-golden');

Widget _app({
  double textScale = 1,
  String? Function(String?)? validator,
  bool obscureText = false,
  GlobalKey<FormState>? formKey,
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
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: TextScaler.linear(textScale),
      ),
      child: child!,
    ),
    home: Scaffold(
      backgroundColor: PiantalaTheme.standard.cream,
      body: Center(
        child: SizedBox(
          width: 300,
          child: Form(
            key: formKey,
            child: RepaintBoundary(
              key: _fieldGoldenKey,
              child: ColoredBox(
                color: PiantalaTheme.standard.cream,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: PaperTextField(
                    label: 'Password',
                    hintText: 'Scrivi la password',
                    obscureText: obscureText,
                    validator: validator,
                    autofillHints: const [AutofillHints.password],
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
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
  testWidgets('renders field golden at text scale 1.5', (tester) async {
    await tester.pumpWidget(_app(textScale: 1.5));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    await expectLater(
      find.byKey(_fieldGoldenKey),
      matchesGoldenFile('goldens/paper_text_field.png'),
    );
  });

  testWidgets('eye control toggles obscuring and has a 48 dp target',
      (tester) async {
    await tester.pumpWidget(_app(obscureText: true));
    final toggle = find.bySemanticsLabel('Mostra password');
    final semantics = tester.ensureSemantics();

    expect(tester.getSize(toggle).width, greaterThanOrEqualTo(48));
    expect(tester.getSize(toggle).height, greaterThanOrEqualTo(48));
    expect(
      tester.getSemantics(toggle),
      matchesSemantics(
        label: 'Mostra password',
        isButton: true,
        hasTapAction: true,
      ),
    );
    expect(
      tester.widget<TextField>(find.byType(TextField)).obscureText,
      isTrue,
    );

    await tester.tap(toggle);
    await tester.pumpAndSettle();

    expect(
      tester.widget<TextField>(find.byType(TextField)).obscureText,
      isFalse,
    );
    expect(find.bySemanticsLabel('Nascondi password'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('passes field options and styles validation in terracotta',
      (tester) async {
    final formKey = GlobalKey<FormState>();
    await tester.pumpWidget(
      _app(
        formKey: formKey,
        validator: (value) => value!.isEmpty ? 'Campo obbligatorio' : null,
      ),
    );
    final field = tester.widget<TextField>(find.byType(TextField));
    expect(field.autofillHints, const [AutofillHints.password]);
    expect(field.keyboardType, TextInputType.visiblePassword);
    expect(field.textInputAction, TextInputAction.done);

    formKey.currentState!.validate();
    await tester.pumpAndSettle();

    final error = tester.widget<Text>(find.text('Campo obbligatorio'));
    expect(error.style?.color, PiantalaTheme.standard.terracotta);
    expect(find.byIcon(Icons.error), findsNothing);
  });

  testWidgets('paper text link has a 48 dp hit target and fires once',
      (tester) async {
    var pressed = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[
            PiantalaTheme.standard,
          ],
        ),
        home: Scaffold(
          body: Center(
            child: PaperTextLink(
              label: 'Crea un account',
              onPressed: () => pressed++,
            ),
          ),
        ),
      ),
    );

    final link = find.byType(PaperTextLink);
    expect(
      tester.getSize(link).width,
      greaterThanOrEqualTo(PaperComponentMetrics.paperTextLinkMinimumTarget),
    );
    expect(
      tester.getSize(link).height,
      greaterThanOrEqualTo(PaperComponentMetrics.paperTextLinkMinimumTarget),
    );
    final gesture = await tester.startGesture(tester.getCenter(link));
    await tester.pump(const Duration(milliseconds: 300));
    final linkTransform = tester
        .widget<AnimatedContainer>(find.byType(AnimatedContainer))
        .transform;
    expect(linkTransform!.storage[13], 2);
    await gesture.up();
    await tester.pumpAndSettle();
    expect(pressed, 1);
  });
}
