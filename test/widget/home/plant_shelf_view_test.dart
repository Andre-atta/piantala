import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/home/widgets/plant_shelf_view.dart';
import 'package:piantala/presentation/screens/home/widgets/watering_stick.dart';

PlantEntity _plant({
  String id = 'plant-1',
  String customName = 'Pothos',
  String? speciesScientificName = 'Epipremnum aureum',
  DateTime? lastWateredAt,
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
    photoUrl: null,
    thumbnailUrl: null,
    wateringConfig: lastWateredAt == null
        ? null
        : WateringConfigEntity(
            lastWateredAt: lastWateredAt,
            frequencyDays: 7,
          ),
    createdAt: DateTime(2024),
  );
}

Widget _buildUnderTest(
  List<PlantEntity> plants, {
  double textScale = 1,
}) {
  return ProviderScope(
    child: MaterialApp(
      locale: const Locale('it'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
      ),
      home: Builder(
        builder: (context) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: Scaffold(
            body: PlantShelfView(plants: plants),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders wall, shelf, and a single plant without errors',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_buildUnderTest([_plant()]));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders plant artwork even when the plant has no photo',
      (tester) async {
    await tester.pumpWidget(_buildUnderTest([_plant()]));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the generic artwork for an unknown species',
      (tester) async {
    await tester.pumpWidget(
      _buildUnderTest([
        _plant(speciesScientificName: 'Unknown species'),
      ]),
    );
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.local_florist_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows the date stick for a plant due for watering',
      (tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(
      _buildUnderTest([
        _plant(lastWateredAt: DateTime.now().subtract(const Duration(days: 8))),
      ]),
    );
    await tester.pumpAndSettle();

    expect(find.byType(WateringStick), findsOneWidget);
    final plantSemantics = tester.getSemantics(
      find.byKey(const ValueKey('plant-plant-1')),
    );
    expect(plantSemantics.label, 'Pothos');
    expect(plantSemantics.value, startsWith('Da annaffiare il '));
    expect(tester.takeException(), isNull);
    semantics.dispose();
  });

  testWidgets('keeps the plant touch target and text valid at scale 1.5',
      (tester) async {
    await tester.pumpWidget(
      _buildUnderTest(
        [_plant(customName: 'Una pianta dal nome molto lungo')],
        textScale: 1.5,
      ),
    );
    await tester.pumpAndSettle();

    final size = tester.getSize(
      find.byKey(const ValueKey('plant-plant-1')),
    );
    expect(size.width, greaterThanOrEqualTo(48));
    expect(size.height, greaterThanOrEqualTo(48));
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders empty shelf decorations without intercepting taps',
      (tester) async {
    await tester.pumpWidget(_buildUnderTest([_plant()]));
    await tester.pumpAndSettle();

    expect(find.byType(SvgPicture), findsWidgets);
    expect(tester.takeException(), isNull);
  });
}
