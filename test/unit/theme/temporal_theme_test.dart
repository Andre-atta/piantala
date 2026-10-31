import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/temporal_theme.dart';

void main() {
  group('TemporalPeriodX.fromHour', () {
    test('00–05 → night', () {
      for (final h in [0, 1, 3, 5]) {
        expect(
          TemporalPeriodX.fromHour(h),
          TemporalPeriod.night,
          reason: 'hour=$h',
        );
      }
    });

    test('06–08 → dawn', () {
      for (final h in [6, 7, 8]) {
        expect(
          TemporalPeriodX.fromHour(h),
          TemporalPeriod.dawn,
          reason: 'hour=$h',
        );
      }
    });

    test('09–17 → day', () {
      for (final h in [9, 12, 15, 17]) {
        expect(
          TemporalPeriodX.fromHour(h),
          TemporalPeriod.day,
          reason: 'hour=$h',
        );
      }
    });

    test('18–20 → dusk', () {
      for (final h in [18, 19, 20]) {
        expect(
          TemporalPeriodX.fromHour(h),
          TemporalPeriod.dusk,
          reason: 'hour=$h',
        );
      }
    });

    test('21–23 → evening', () {
      for (final h in [21, 22, 23]) {
        expect(
          TemporalPeriodX.fromHour(h),
          TemporalPeriod.evening,
          reason: 'hour=$h',
        );
      }
    });
  });

  group('TemporalPeriod.greeting', () {
    test('ogni periodo ha un saluto diverso e non vuoto', () {
      final greetings = TemporalPeriod.values.map((p) => p.greeting).toList();
      expect(
        greetings.toSet().length,
        equals(TemporalPeriod.values.length),
        reason: 'Ogni periodo deve avere un saluto UNICO',
      );
      for (final g in greetings) {
        expect(g.isNotEmpty, isTrue);
      }
    });
  });

  group('TemporalPeriod.icon', () {
    test('ogni periodo ha un icon emoji diverso', () {
      final icons = TemporalPeriod.values.map((p) => p.icon).toList();
      expect(icons.toSet().length, equals(TemporalPeriod.values.length));
    });
  });

  group('TemporalTheme.buildTheme', () {
    test('ogni periodo restituisce un ThemeData diverso', () {
      final themes =
          TemporalPeriod.values.map(TemporalTheme.buildTheme).toList();

      // I colori di sfondo devono essere tutti diversi
      final backgrounds = themes.map((t) => t.scaffoldBackgroundColor).toList();
      expect(
        backgrounds.toSet().length,
        equals(TemporalPeriod.values.length),
        reason: 'Ogni periodo deve avere un scaffoldBackgroundColor UNICO',
      );
    });
  });
}
