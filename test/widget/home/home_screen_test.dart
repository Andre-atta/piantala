import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/providers/theme_providers.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';
import 'package:piantala/presentation/screens/home/home_screen.dart';
import 'package:piantala/presentation/screens/home/widgets/home_floor.dart';
import 'package:piantala/presentation/screens/home/widgets/plant_name_tag.dart';
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
  String? customName,
  String? speciesScientificName,
  String cultivationMethod = 'soil',
  WateringConfigEntity? wateringConfig,
  FertilizingConfigEntity? fertilizingConfig,
}) =>
    PlantEntity(
      id: id,
      userId: 'user-1',
      roomId: roomId,
      customName: customName ?? 'Pianta $id',
      shelfPosition: 0,
      createdAt: DateTime(2026),
      speciesScientificName: speciesScientificName,
      cultivationMethod: cultivationMethod,
      wateringConfig: wateringConfig,
      fertilizingConfig: fertilizingConfig,
    );

({Widget widget, GoRouter router}) _app({
  required List<PlantEntity> plants,
  required List<RoomEntity> rooms,
  double textScale = 1,
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
      GoRoute(
        path: '/plants/:id',
        builder: (context, state) => Scaffold(
          body: Text('Plant ${state.pathParameters['id']} route'),
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
        ...GlobalMaterialLocalizations.delegates,
      ],
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          extensions: const <ThemeExtension<dynamic>>[PiantalaTheme.standard],
        ),
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: child!,
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Home does not overflow at textScale 1.5', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: List.generate(3, (index) => _plant('plant-$index', 'room-1')),
      rooms: [_room('room-1', 'Soggiorno', 'S')],
      textScale: 1.5,
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });

  testWidgets('plant name tags stay compact and single-line at textScale 1.5',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const shortName = 'Rocco';
    const longName = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmn';
    final app = _app(
      plants: [
        _plant('short-name', 'room-1', customName: shortName),
        _plant('long-name', 'room-1', customName: longName),
      ],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
      textScale: 1.5,
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    final shortTag = find.descendant(
      of: find.byKey(const ValueKey('plant-short-name')),
      matching: find.byType(PlantNameTag),
    );
    final longTag = find.descendant(
      of: find.byKey(const ValueKey('plant-long-name')),
      matching: find.byType(PlantNameTag),
    );
    expect(shortTag, findsOneWidget);
    expect(longTag, findsOneWidget);

    final shortText = tester.widget<Text>(
      find.descendant(of: shortTag, matching: find.byType(Text)),
    );
    final longText = tester.widget<Text>(
      find.descendant(of: longTag, matching: find.byType(Text)),
    );
    expect(shortText.maxLines, 1);
    expect(shortText.softWrap, isFalse);
    expect(shortText.overflow, TextOverflow.ellipsis);
    expect(shortText.textScaler, TextScaler.noScaling);
    expect(longText.maxLines, 1);
    expect(longText.softWrap, isFalse);
    expect(longText.overflow, TextOverflow.ellipsis);
    expect(longText.textScaler, TextScaler.noScaling);

    final shortTagRect = tester.getRect(shortTag);
    final longTagRect = tester.getRect(longTag);
    expect(shortTagRect.width, lessThan(HomeMetrics.nameTagMaxWidth));
    expect(longTagRect.width, lessThanOrEqualTo(HomeMetrics.nameTagMaxWidth));
    expect(shortTagRect.height, HomeMetrics.nameTagHeight);
    expect(longTagRect.height, HomeMetrics.nameTagHeight);
    expect(
      tester.getSemantics(find.byKey(const ValueKey('plant-long-name'))).label,
      longName,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('cabinet height fills space to floor for 1, 2, 4, and 6 rows',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    for (final rowCount in [1, 2, 4, 6]) {
      await tester.pumpWidget(const SizedBox.shrink());
      final app = _app(
        plants: List.generate(
          rowCount * HomeMetrics.plantsPerRow,
          (index) => _plant('plant-$rowCount-$index', 'room-1'),
        ),
        rooms: [_room('room-1', 'Soggiorno', 'S')],
      );
      addTearDown(app.router.dispose);

      await tester.pumpWidget(app.widget);
      await tester.pumpAndSettle();

      final cabinetFrameRect = tester.getRect(
        find.byKey(const ValueKey('shelf-cabinet-frame')),
      );
      final floorRect = tester.getRect(find.byType(HomeFloor));
      expect(
        cabinetFrameRect.bottom,
        equals(floorRect.top),
      );

      final scrollable = tester.state<ScrollableState>(
        find.descendant(
          of: find.byType(SingleChildScrollView).first,
          matching: find.byType(Scrollable),
        ),
      );
      if (rowCount >= 6) {
        expect(scrollable.position.maxScrollExtent, greaterThan(0));
      }
      expect(tester.takeException(), isNull);
    }
  });

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
    final createButton = find.byKey(
      const ValueKey('navigation-create-button'),
    );
    final createLabel = find.text('nuova pianta');
    expect(
      tester
          .getRect(createButton)
          .contains(tester.getRect(createLabel).topLeft),
      isTrue,
    );
    expect(
      tester.getRect(createLabel).bottom,
      lessThanOrEqualTo(tester.getRect(createButton).bottom),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('keeps the header and floor fixed while scrolling the cabinet',
      (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final app = _app(
      plants: List.generate(18, (index) => _plant('plant-$index', 'room-1')),
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();
    final cabinetHeight = tester
        .getSize(find.byKey(const ValueKey('shelf-cabinet-frame')))
        .height;
    expect(
      cabinetHeight,
      lessThan(
        HomeMetrics.cabinetCrossbarHeight +
            6 * HomeMetrics.shelfRowHeight +
            HomeMetrics.cabinetBottomBeamHeight,
      ),
    );
    expect(
      tester
          .state<ScrollableState>(
            find.descendant(
              of: find.byType(SingleChildScrollView).first,
              matching: find.byType(Scrollable),
            ),
          )
          .position
          .maxScrollExtent,
      greaterThan(0),
    );
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

  testWidgets('renders care signals in corners of three plant cells',
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
            lastWateredAt: DateTime(2026, 11),
          ),
        ),
        _plant(
          'epipremnum',
          'room-1',
          speciesScientificName: 'Epipremnum aureum',
          cultivationMethod: 'hydro',
          fertilizingConfig: FertilizingConfigEntity(
            frequencyDays: 1,
            lastFertilizedAt: DateTime(2026, 11),
          ),
        ),
        _plant(
          'pilea',
          'room-1',
          speciesScientificName: 'Pilea peperomioides',
          wateringConfig: WateringConfigEntity(
            frequencyDays: 1,
            lastWateredAt: DateTime(2026, 11),
          ),
          fertilizingConfig: FertilizingConfigEntity(
            frequencyDays: 1,
            lastFertilizedAt: DateTime(2026, 11),
          ),
        ),
      ],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('care-signal-watering')),
      findsNWidgets(2),
    );
    expect(
      find.byKey(const ValueKey('care-signal-fertilizing')),
      findsNWidgets(2),
    );
    for (final (plantId, watering, fertilizing) in [
      ('chlorophytum', true, false),
      ('epipremnum', false, true),
      ('pilea', true, true),
    ]) {
      final cell = tester.getRect(
        find.byKey(ValueKey('care-signals-$plantId')),
      );
      if (watering) {
        final signal = tester.getRect(
          find.descendant(
            of: find.byKey(ValueKey('care-signals-$plantId')),
            matching: find.byKey(const ValueKey('care-signal-watering')),
          ),
        );
        expect(signal.left, cell.left + HomeMetrics.careSignalWateringLeft);
        expect(signal.top, cell.top + HomeMetrics.careSignalWateringTop);
      }
      if (fertilizing) {
        final signal = tester.getRect(
          find.descendant(
            of: find.byKey(ValueKey('care-signals-$plantId')),
            matching: find.byKey(const ValueKey('care-signal-fertilizing')),
          ),
        );
        expect(
          signal.right,
          cell.right - HomeMetrics.careSignalFertilizingRight,
        );
        expect(signal.top, cell.top + HomeMetrics.careSignalFertilizingTop);
      }
      expect(find.byKey(ValueKey('care-signals-$plantId')), findsOneWidget);
    }

    expect(
      tester
          .getSemantics(find.byKey(const ValueKey('plant-chlorophytum')))
          .value,
      'Da annaffiare',
    );
    expect(
      tester.getSemantics(find.byKey(const ValueKey('plant-epipremnum'))).value,
      'Da concimare',
    );
    expect(
      tester.getSemantics(find.byKey(const ValueKey('plant-pilea'))).value,
      'Da annaffiare, Da concimare',
    );
    await expectLater(
      find.byType(MainScaffold),
      matchesGoldenFile('goldens/home_care_signals.png'),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders no care signals for a plant without due care',
      (tester) async {
    final app = _app(
      plants: [_plant('plant-no-care', 'room-1')],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(
      find.byKey(const ValueKey('care-signal-watering')),
      findsNothing,
    );
    expect(
      find.byKey(const ValueKey('care-signal-fertilizing')),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('tapping a care signal opens the plant details', (tester) async {
    final app = _app(
      plants: [
        _plant(
          'plant-tappable',
          'room-1',
          wateringConfig: WateringConfigEntity(
            frequencyDays: 1,
            lastWateredAt: DateTime(2026, 11),
          ),
        ),
      ],
      rooms: [_room('room-1', 'Soggiorno', 'S')],
    );
    addTearDown(app.router.dispose);
    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();
    await tester.tapAt(
      tester.getRect(find.byKey(const ValueKey('care-signal-watering'))).center,
    );
    await tester.pumpAndSettle();

    expect(
      app.router.routeInformationProvider.value.uri.path,
      '/plants/plant-tappable',
    );
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
