import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/utils/compass_utils.dart';

void main() {
  group('exposureFromHeading', () {
    test('maps headings on both sides of sector boundaries', () {
      expect(exposureFromHeading(22.4), 'N');
      expect(exposureFromHeading(22.5), 'NE');
      expect(exposureFromHeading(337.5), 'N');
      expect(exposureFromHeading(-10), 'N');
      expect(exposureFromHeading(359.9), 'N');
      expect(exposureFromHeading(360), 'N');
    });

    test('normalizes arbitrary turns and negative angles', () {
      expect(exposureFromHeading(382.5), 'NE');
      expect(exposureFromHeading(-337.5), 'NE');
      expect(exposureFromHeading(270), 'W');
    });
  });

  group('angularDifference', () {
    test('returns the shortest angle in the range from 0 to 180', () {
      expect(angularDifference(359, 1), 2);
      expect(angularDifference(1, 359), 2);
      expect(angularDifference(-10, 0), 10);
      expect(angularDifference(0, 180), 180);
      expect(angularDifference(360, 0), 0);
    });
  });
}
