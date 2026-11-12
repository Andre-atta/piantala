import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/providers/theme_providers.dart';
import 'package:piantala/presentation/screens/home/home_screen.dart';
import 'package:piantala/presentation/screens/home/widgets/home_floor.dart';
import 'package:piantala/presentation/screens/home/widgets/watering_stick.dart';
import 'package:piantala/presentation/widgets/common/paper_action_button.dart';
import 'package:piantala/presentation/widgets/common/piantala_navigation_bar.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

RoomEntity _room(String id, String name, String exposure) => RoomEntity(
      id: id,
      userId: 'user-1',
      name: name,
      exposure: exposure,
      createdAt: DateTime(2026),
    );

PlantEntity _plant(
  String id,
  String roomId, {
  String? speciesScientificName,
  String cultivationMethod = 'soil',
  WateringConfigEntity? wateringConfig,
}) =>
    PlantEntity(
      id: id,
      userId: 'user-1',
      roomId: roomId,
      customName: 'Pianta $id',
      shelfPosition: 0,
      createdAt: DateTime(2026),
      speciesScientificName: speciesScientificName,
      cultivationMethod: cultivationMethod,
      wateringConfig: wateringConfig,
    );

({Widget widget, GoRouter router}) _app({
  required List<PlantEntity> plants,
  required List<RoomEntity> rooms,
}) {
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/plants/add',
        builder: (context, state) => const Scaffold(
          body: Text('Add plant route'),
        ),
      ),
    ],
  );
  return (
    router: router,
    widget: ProviderScope(
      overrides: [
        plantsProvider.overrideWith((ref) => Stream.value(plants)),
        roomsProvider.overrideWith((ref) => Stream.value(rooms)),
        temporalPeriodProvider
            .overrideWith((ref) => Stream.value(TemporalPeriod.day)),
      ],
      child: MaterialApp.router(
        routerConfig: router,
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
      ),
    ),
  );
}

void main() {
  testWidgets('renders room metadata, window, cabinet, floor, and navigation',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: List.generate(4, (index) => _plant('plant-$index', 'room-1')),
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.text('Soggiorno'), findsOneWidget);
    expect(find.text('4 piante · Esposizione Sud'), findsOneWidget);
    expect(find.byType(HomeFloor), findsOneWidget);
    expect(find.byType(PiantalaNavigationBar), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the header and floor fixed while scrolling the cabinet',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: List.generate(15, (index) => _plant('plant-$index', 'room-1')),
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();
    final headerTop = tester.getTopLeft(find.text('Soggiorno'));
    final floorTop = tester.getTopLeft(find.byType(HomeFloor));

    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    expect(tester.getTopLeft(find.text('Soggiorno')), headerTop);
    expect(tester.getTopLeft(find.byType(HomeFloor)), floorTop);
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the localized empty room action and navigates to add',
      (tester) async {
    final app = _app(
      plants: const [],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.text('Soggiorno è vuota'), findsOneWidget);
    expect(find.byType(PaperActionButton), findsOneWidget);
    await tester.tap(find.byType(PaperActionButton));
    await tester.pumpAndSettle();

    expect(app.router.routeInformationProvider.value.uri.path, '/plants/add');
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders the localized empty shelf state', (tester) async {
    final app = _app(plants: const [], rooms: const []);
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.text('La tua mensola è vuota'), findsOneWidget);
    expect(find.byType(PaperActionButton), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
      'fits three trimmed plant assets across the shelf without overlap',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: [
        _plant(
          'chlorophytum',
          'room-1',
          speciesScientificName: 'Chlorophytum comosum',
          cultivationMethod: 'hydro',
        ),
        _plant(
          'epipremnum',
          'room-1',
          speciesScientificName: 'Epipremnum aureum',
          cultivationMethod: 'hydro',
        ),
        _plant(
          'pilea',
          'room-1',
          speciesScientificName: 'Pilea peperomioides',
        ),
      ],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    final plantRects = [
      for (final id in ['chlorophytum', 'epipremnum', 'pilea'])
        tester.getRect(find.byKey(ValueKey('plant-$id'))),
    ]..sort((first, second) => first.left.compareTo(second.left));
    expect(plantRects, hasLength(3));
    for (var index = 1; index < plantRects.length; index++) {
      expect(
        plantRects[index - 1].right,
        lessThanOrEqualTo(plantRects[index].left),
      );
    }

    final plantAssets = tester
        .widgetList<Image>(find.byType(Image))
        .map((image) => image.image)
        .whereType<AssetImage>()
        .map((image) => image.assetName)
        .toSet();
    expect(
      plantAssets,
      containsAll([
        'assets/illustrations/plants/chlorophytum_comosum_water.png',
        'assets/illustrations/plants/epipremnum_aureum_water.png',
        'assets/illustrations/plants/pilea_peperomioides_soil.png',
      ]),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders centered watering sticks on three plant species',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: [
        _plant(
          'chlorophytum',
          'room-1',
          speciesScientificName: 'Chlorophytum comosum',
          cultivationMethod: 'hydro',
          wateringConfig: WateringConfigEntity(
            frequencyDays: 1,
            lastWateredAt: DateTime(2026),
          ),
        ),
        _plant(
          'epipremnum',
          'room-1',
          speciesScientificName: 'Epipremnum aureum',
          cultivationMethod: 'hydro',
          wateringConfig: WateringConfigEntity(
            frequencyDays: 1,
            lastWateredAt: DateTime(2026),
          ),
        ),
        _plant(
          'pilea',
          'room-1',
          speciesScientificName: 'Pilea peperomioides',
          wateringConfig: WateringConfigEntity(
            frequencyDays: 1,
            lastWateredAt: DateTime(2026),
          ),
        ),
      ],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.byType(WateringStick), findsNWidgets(3));
    await expectLater(
      find.byType(MainScaffold),
      matchesGoldenFile('goldens/home_watering_sticks.png'),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('advances to the next room from its accessible header target',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: [
        _plant('plant-1', 'room-1'),
        _plant('plant-2', 'room-2'),
      ],
      rooms: [
        _room('room-1', 'Soggiorno', 'S'),
        _room('room-2', 'Cucina', 'E'),
      ],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cucina'));
    await tester.pumpAndSettle();

    expect(find.text('Cucina'), findsOneWidget);
    expect(find.text('1 pianta · Esposizione Est'), findsOneWidget);
    final metadataRect = tester.getRect(
      find.text('1 pianta · Esposizione Est'),
    );
    final pageIndicatorTouchRect = tester.getRect(
      find.byKey(const ValueKey('room-page-1')),
    );
    expect(metadataRect.overlaps(pageIndicatorTouchRect), isFalse);
    expect(tester.takeException(), isNull);
  });
}
