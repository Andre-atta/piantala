import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/data/services/sync_service.dart';

void main() {
  test('DateTime.now().toUtc() produce una stringa ISO con "Z"', () {
    final ts = DateTime.now().toUtc();
    final iso = ts.toIso8601String();
    expect(iso.endsWith('Z'), isTrue,
        reason: 'createdAt deve essere UTC: $iso');
  });

  test('SyncService.parseDateTime interpreta stringhe senza fuso come UTC', () {
    const noZone = '2024-06-15T10:00:00';
    final result = SyncService.parseDateTime(noZone);
    expect(result, isNotNull);
    expect(result!.isUtc, isTrue);
    expect(result.hour, equals(10)); // ora preservata, fuso interpretato come UTC

    const withZ = '2024-06-15T10:00:00.000Z';
    final resultZ = SyncService.parseDateTime(withZ);
    expect(resultZ, isNotNull);
    expect(resultZ!.isUtc, isTrue);
    expect(resultZ.hour, equals(10));

    const withOffset = '2024-06-15T10:00:00+02:00';
    final resultOffset = SyncService.parseDateTime(withOffset);
    expect(resultOffset, isNotNull);
    expect(resultOffset!.isUtc, isTrue);
    expect(resultOffset.hour, equals(8)); // +02:00 convertito in UTC
  });
}
