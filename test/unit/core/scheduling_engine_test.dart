import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/utils/scheduling_constants.dart';
import 'package:piantala/core/utils/scheduling_engine.dart';

void main() {
  group('SchedulingEngine.wateringDateIfDue', () {
    final now = DateTime(2026, 11, 9, 12);

    test('returns null if no last watering date or frequency is available', () {
      expect(
        SchedulingEngine.wateringDateIfDue(
          lastWateredAt: null,
          frequencyDays: 7,
          now: now,
        ),
        isNull,
      );
      expect(
        SchedulingEngine.wateringDateIfDue(
          lastWateredAt: DateTime(2026, 11),
          frequencyDays: null,
          now: now,
        ),
        isNull,
      );
    });

    group('SchedulingEngine.fertilizingDateIfDue', () {
      final now = DateTime(2026, 11, 9, 12);

      test('returns null if no last fertilizing date or frequency is available',
          () {
        expect(
          SchedulingEngine.fertilizingDateIfDue(
            lastFertilizedAt: null,
            frequencyDays: 7,
            now: now,
          ),
          isNull,
        );
        expect(
          SchedulingEngine.fertilizingDateIfDue(
            lastFertilizedAt: DateTime(2026, 11),
            frequencyDays: null,
            now: now,
          ),
          isNull,
        );
      });

      test('returns the next fertilizing date when overdue or due today', () {
        expect(
          SchedulingEngine.fertilizingDateIfDue(
            lastFertilizedAt: DateTime(2026, 11),
            frequencyDays: 7,
            now: now,
          ),
          DateTime(2026, 11, 8),
        );
        expect(
          SchedulingEngine.fertilizingDateIfDue(
            lastFertilizedAt: DateTime(2026, 11, 2),
            frequencyDays: 7,
            now: now,
          ),
          DateTime(2026, 11, 9),
        );
      });

      test('returns null when the due date is in the future', () {
        expect(
          SchedulingEngine.fertilizingDateIfDue(
            lastFertilizedAt: DateTime(2026, 11, 3),
            frequencyDays: 7,
            now: now,
          ),
          isNull,
        );
      });
    });

    test('returns the next watering date when overdue or due today', () {
      expect(
        SchedulingEngine.wateringDateIfDue(
          lastWateredAt: DateTime(2026, 11),
          frequencyDays: 7,
          now: now,
        ),
        DateTime(2026, 11, 8),
      );
      expect(
        SchedulingEngine.wateringDateIfDue(
          lastWateredAt: DateTime(2026, 11, 2),
          frequencyDays: 7,
          now: now,
        ),
        DateTime(2026, 11, 9),
      );
    });

    test('returns null when the due date is in the future', () {
      expect(
        SchedulingEngine.wateringDateIfDue(
          lastWateredAt: DateTime(2026, 11, 3),
          frequencyDays: 7,
          now: now,
        ),
        isNull,
      );
    });
  });

  test('calcola il prossimo evento di irrigazione', () {
    final date = DateTime(2026, 6);
    expect(
      SchedulingEngine.nextWatering(
        lastWateredAt: date,
        frequencyDays: 7,
      ),
      date.add(const Duration(days: 7)),
    );
  });

  test('usa i fallback centralizzati', () {
    expect(SchedulingConstants.soilFallbackWateringDays, 7);
    expect(SchedulingConstants.hydroWateringDays, 3);
    expect(SchedulingConstants.soilFertilizingDays, 30);
    expect(SchedulingConstants.hydroFertilizingDays, 15);
  });
}
