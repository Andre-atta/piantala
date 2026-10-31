import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/domain/entities/opb_contribution_entity.dart';
import 'package:piantala/presentation/providers/opb_contribution_providers.dart';

void main() {
  group('validateContributionProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('displayPid non valido se contiene numeri ("Rosa123 canina")', () {
      const entity = OpbContributionEntity(
        displayPid: 'Rosa123 canina',
        minTemp: 10,
        maxTemp: 25,
        minSoilMoist: 20,
      );

      final res = container.read(validateContributionProvider(entity));
      expect(res.isValid, isFalse);
      expect(res.errors['displayPid'], isNotNull);
    });

    test('displayPid non valido se singola parola o caratteri non latini', () {
      const singleWord = OpbContributionEntity(
        displayPid: 'Monstera',
        minTemp: 10,
        maxTemp: 25,
        minSoilMoist: 20,
      );
      final res1 = container.read(validateContributionProvider(singleWord));
      expect(res1.isValid, isFalse);

      const specialChars = OpbContributionEntity(
        displayPid: 'Monstera delic-iosa',
        minTemp: 10,
        maxTemp: 25,
        minSoilMoist: 20,
      );
      final res2 = container.read(validateContributionProvider(specialChars));
      expect(res2.isValid, isFalse);
    });

    test('errore se min >= max su intervallo temperatura', () {
      const entity = OpbContributionEntity(
        displayPid: 'Monstera deliciosa',
        minTemp: 30,
        maxTemp: 20, // min > max
        minSoilMoist: 20,
      );

      final res = container.read(validateContributionProvider(entity));
      expect(res.isValid, isFalse);
      expect(res.errors['tempMin'], isNotNull);
    });

    test('errore se valori numerici fuori dai limiti ammessi', () {
      const entity = OpbContributionEntity(
        displayPid: 'Monstera deliciosa',
        minTemp: -50, // sotto -20°C
        maxTemp: 25,
        minSoilMoist: 20,
      );

      final res = container.read(validateContributionProvider(entity));
      expect(res.isValid, isFalse);
      expect(res.errors['tempMin'], isNotNull);
    });

    test('form non valido se meno di 3 campi numerici compilati', () {
      const entity = OpbContributionEntity(
        displayPid: 'Monstera deliciosa',
        minTemp: 15,
        maxTemp: 28, // solo 2 campi
      );

      final res = container.read(validateContributionProvider(entity));
      expect(res.filledNumericFieldCount, equals(2));
      expect(res.isValid, isFalse);
    });

    test('form valido con displayPid corretto e almeno 3 campi numerici validi',
        () {
      const entity = OpbContributionEntity(
        displayPid: 'Monstera deliciosa',
        alias: 'Pianta del pane americano',
        category: 'Araceae',
        origin: 'Messico tropicale',
        minTemp: 18,
        maxTemp: 30,
        minSoilMoist: 25,
        maxSoilMoist: 60,
      );

      final res = container.read(validateContributionProvider(entity));
      expect(res.errors, isEmpty);
      expect(res.filledNumericFieldCount, equals(4));
      expect(res.isValid, isTrue);
    });
  });
}
