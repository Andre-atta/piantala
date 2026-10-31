import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';

void main() {
  group('PlantAssetResolver', () {
    test(
        'returns exact asset path for known slug and substrate (epipremnum_aureum, water)',
        () {
      final assetPath =
          PlantAssetResolver.plantAsset('epipremnum_aureum', water: true);
      expect(assetPath,
          equals('assets/illustrations/plants/epipremnum_aureum_water.png'));
    });

    test(
        'returns null for unknown substrate of a known species (epipremnum_aureum, soil)',
        () {
      final assetPath =
          PlantAssetResolver.plantAsset('epipremnum_aureum', water: false);
      expect(assetPath, isNull);
    });

    test('returns null for completely unknown species', () {
      final assetPath =
          PlantAssetResolver.plantAsset('falsa_pianta', water: true);
      expect(assetPath, isNull);
    });

    test('wallBackground returns the correct generic room asset', () {
      final assetPath = PlantAssetResolver.wallBackground();
      expect(
          assetPath, equals('assets/illustrations/rooms/wall_background.png'));
    });
  });
}
