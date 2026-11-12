import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/home/care_type.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';
import 'package:piantala/presentation/screens/home/widgets/care_signals.dart';

void main() {
  testWidgets('places each illustration in its corner without hit testing',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('it'),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Align(
            child: CareSignals(
              cares: [CareType.watering, CareType.fertilizing],
            ),
          ),
        ),
      ),
    );

    final cell = tester.getRect(find.byType(CareSignals));
    final watering = tester.getRect(
      find.descendant(
        of: find.byType(CareSignals),
        matching: find.byKey(const ValueKey('care-signal-watering')),
      ),
    );
    final fertilizing = tester.getRect(
      find.descendant(
        of: find.byType(CareSignals),
        matching: find.byKey(const ValueKey('care-signal-fertilizing')),
      ),
    );

    expect(watering.top, cell.top + HomeMetrics.careSignalWateringTop);
    expect(watering.left, cell.left + HomeMetrics.careSignalWateringLeft);
    expect(
      fertilizing.top,
      cell.top + HomeMetrics.careSignalFertilizingTop,
    );
    expect(
      fertilizing.right,
      cell.right - HomeMetrics.careSignalFertilizingRight,
    );
    expect(watering.width, HomeMetrics.careSignalSize);
    expect(watering.height, HomeMetrics.careSignalSize);
    expect(fertilizing.width, HomeMetrics.careSignalSize);
    expect(fertilizing.height, HomeMetrics.careSignalSize);
    expect(watering.left, greaterThanOrEqualTo(cell.left));
    expect(watering.top, greaterThanOrEqualTo(cell.top));
    expect(watering.right, lessThanOrEqualTo(cell.right));
    expect(watering.bottom, lessThanOrEqualTo(cell.bottom));
    expect(fertilizing.left, greaterThanOrEqualTo(cell.left));
    expect(fertilizing.top, greaterThanOrEqualTo(cell.top));
    expect(fertilizing.right, lessThanOrEqualTo(cell.right));
    expect(fertilizing.bottom, lessThanOrEqualTo(cell.bottom));
    expect(
      find.descendant(
        of: find.byType(CareSignals),
        matching: find.byType(IgnorePointer),
      ),
      findsOneWidget,
    );
  });

  testWidgets('renders no illustrations for an empty care list',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CareSignals(cares: []),
        ),
      ),
    );

    expect(find.byKey(const ValueKey('care-signal-watering')), findsNothing);
    expect(find.byKey(const ValueKey('care-signal-fertilizing')), findsNothing);
  });
}
