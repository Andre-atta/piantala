import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/utils/scheduling_constants.dart';
import 'package:piantala/core/utils/scheduling_engine.dart';

void main() {
  test('calcola il prossimo evento di irrigazione', () {
    final date = DateTime(2026, 6, 1);
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
