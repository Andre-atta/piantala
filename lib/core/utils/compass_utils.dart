import 'dart:math' as math;

const _compassDirections = <String>[
  'N',
  'NE',
  'E',
  'SE',
  'S',
  'SW',
  'W',
  'NW',
];

String exposureFromHeading(double heading) {
  final normalized = ((heading % 360) + 360) % 360;
  final sector = ((normalized + 22.5) / 45).floor() % _compassDirections.length;
  return _compassDirections[sector];
}

double angularDifference(double a, double b) {
  final difference = ((a - b) % 360).abs();
  return math.min(difference, 360 - difference);
}
