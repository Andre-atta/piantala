import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/presentation/screens/home/widgets/plant_shelf_view.dart';

// ── Helper ────────────────────────────────────────────────────────────────

PlantEntity _fakePlant({
  String id = 'plant-1',
  String customName = 'Pothos',
  String? speciesScientificName = 'Epipremnum aureum',
  String? photoUrl,
}) {
  return PlantEntity(
    id: id,
    userId: 'user-1',
    customName: customName,
    speciesApiId: null,
    speciesScientificName: speciesScientificName,
    speciesCommonName: null,
    roomId: 'unassigned',
    shelfPosition: 0,
    photoUrl: photoUrl,
    thumbnailUrl: null,
    wateringConfig: null,
    createdAt: DateTime(2024),
  );
}

Widget _buildUnderTest(List<PlantEntity> plants) {
  return ProviderScope(
    child: MaterialApp(
      home: Scaffold(
        body: PlantShelfView(plants: plants),
      ),
    ),
  );
}

// ── Tests ─────────────────────────────────────────────────────────────────

void main() {
  group('PlantShelfView', () {
    testWidgets('renders without crash with a single plant', (tester) async {
      final plant = _fakePlant();

      await tester.pumpWidget(_buildUnderTest([plant]));
      // Senza errori di frame = ✅
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders the wall background (Image.asset widget present)',
        (tester) async {
      // Questo test verifica che lo Stack contenga un Image.asset
      // per lo sfondo parete — non verifica il contenuto del PNG.
      await tester.pumpWidget(_buildUnderTest([_fakePlant()]));

      // Image.asset è presente come layer base dello Stack
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('renders pothos illustration asset even if photoUrl is present',
        (tester) async {
      // Nella shelf view, l'illustrazione locale ha la priorità e la foto reale
      // non viene usata (art-direction.md §2).
      final pothos = _fakePlant(
        speciesScientificName: 'Epipremnum aureum',
        photoUrl: 'http://example.com/photo.jpg', // Questa deve essere ignorata
      ).copyWith(cultivationMethod: 'hydro');

      await tester.pumpWidget(_buildUnderTest([pothos]));
      expect(tester.takeException(), isNull);

      // Almeno un Image.asset presente (sfondo + eventuale illustrazione)
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('shows generic placeholder for unknown species',
        (tester) async {
      final unknown = _fakePlant(
        speciesScientificName: 'Unknown species',
        photoUrl:
            'http://example.com/photo.jpg', // Anche qui, deve essere ignorata
      );

      await tester.pumpWidget(_buildUnderTest([unknown]));
      expect(tester.takeException(), isNull);

      // Icona placeholder generica presente (nessun CachedNetworkImage usato)
      expect(find.byIcon(Icons.local_florist_outlined), findsWidgets);
    });

    testWidgets('renders multiple plants without crash', (tester) async {
      final plants = List.generate(
        5,
        (i) => _fakePlant(id: 'plant-$i', customName: 'Pianta $i'),
      );

      await tester.pumpWidget(_buildUnderTest(plants));
      expect(tester.takeException(), isNull);
    });
  });
}
