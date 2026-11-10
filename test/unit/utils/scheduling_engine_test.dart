import 'package:flutter_test/flutter_test.dart';
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
          lastWateredAt: DateTime(2026, 11, 1),
          frequencyDays: null,
          now: now,
        ),
        isNull,
      );
    });

    test('returns the next watering date when overdue or due today', () {
      expect(
        SchedulingEngine.wateringDateIfDue(
          lastWateredAt: DateTime(2026, 11, 1),
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
}
