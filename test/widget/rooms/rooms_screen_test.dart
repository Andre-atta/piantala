import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/domain/repositories/i_plant_repository.dart';
import 'package:piantala/domain/repositories/i_room_repository.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/rooms_screen.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_paper_card.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_paper_card_metrics.dart';
import 'package:piantala/presentation/widgets/common/piantala_navigation_bar.dart';

const _roomsGoldenKey = ValueKey('rooms-screen-golden');

RoomEntity _room(String id, String name, String exposure) => RoomEntity(
      id: id,
      userId: 'user-1',
      name: name,
      exposure: exposure,
      createdAt: DateTime(2026),
    );

PlantEntity _plant(String id, String roomId) => PlantEntity(
      id: id,
      userId: 'user-1',
      roomId: roomId,
      customName: 'Pianta $id',
      shelfPosition: 0,
      createdAt: DateTime(2026),
    );

List<RoomEntity> _roomsWithAllAppearances() {
  final roomsByAppearance = <int, RoomEntity>{};
  for (var index = 0; roomsByAppearance.length < 3; index++) {
    final room = _room('room-$index', 'Stanza $index', 'S');
    roomsByAppearance.putIfAbsent(
      RoomPaperCard.appearanceIndexForRoomId(room.id),
      () => room,
    );
  }
  return roomsByAppearance.values.toList();
}

class _RoomRepository implements IRoomRepository {
  final deletedRoomIds = <String>[];

  @override
  Future<void> addRoom(RoomEntity room) async {}

  @override
  Future<void> deleteRoom(String roomId) async {
    deletedRoomIds.add(roomId);
  }

  @override
  Future<void> updateRoom(RoomEntity room) async {}

  @override
  Stream<List<RoomEntity>> watchRooms() => const Stream.empty();
}

class _PlantRepository implements IPlantRepository {
  final updatedPlants = <PlantEntity>[];

  @override
  Future<void> addPlant(PlantEntity plant) async {}

  @override
  Future<void> deletePlant(String plantId) async {}

  @override
  Future<void> updatePlant(PlantEntity plant) async {
    updatedPlants.add(plant);
  }

  @override
  Stream<PlantEntity?> watchPlant(String plantId) => const Stream.empty();

  @override
  Stream<List<PlantEntity>> watchPlants() => const Stream.empty();
}

({Widget widget, GoRouter router}) _app({
  required List<RoomEntity> rooms,
  List<PlantEntity> plants = const [],
  _RoomRepository? roomRepository,
  _PlantRepository? plantRepository,
  double textScale = 1,
}) {
  final router = GoRouter(
    initialLocation: '/rooms',
    routes: [
      GoRoute(
        path: '/rooms',
        builder: (context, state) => const RoomsScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(),
      ),
      GoRoute(
        path: '/encyclopedia',
        builder: (context, state) => const Scaffold(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const Scaffold(),
      ),
      GoRoute(
        path: '/plants/add',
        builder: (context, state) => const Scaffold(),
      ),
    ],
  );
  return (
    router: router,
    widget: ProviderScope(
      overrides: [
        roomsProvider.overrideWith((ref) => Stream.value(rooms)),
        plantsProvider.overrideWith((ref) => Stream.value(plants)),
        if (roomRepository != null)
          roomRepositoryProvider.overrideWith((ref) => roomRepository),
        if (plantRepository != null)
          plantRepositoryProvider.overrideWith((ref) => plantRepository),
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
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: RepaintBoundary(
            key: _roomsGoldenKey,
            child: child,
          ),
        ),
      ),
    ),
  );
}

void _setScreenSize(WidgetTester tester) {
  tester.view
    ..physicalSize = const Size(390, 844)
    ..devicePixelRatio = 1;
}

void main() {
  testWidgets('renders three room cards in the screen golden', (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final app = _app(
      rooms: _roomsWithAllAppearances(),
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.byType(RoomPaperCard), findsNWidgets(3));
    final navigationBar =
        tester.widget<PiantalaNavigationBar>(find.byType(PiantalaNavigationBar));
    expect(navigationBar.selectedIndex, 1);
    expect(navigationBar.isRoomsRoute, isTrue);
    await expectLater(
      find.byKey(_roomsGoldenKey),
      matchesGoldenFile('goldens/rooms_screen_three_rooms.png'),
    );
    expect(tester.takeException(), isNull);
  });

  test('room appearance is deterministic and independent of list order', () {
    final rooms = _roomsWithAllAppearances();
    final appearanceById = {
      for (final room in rooms)
        room.id: RoomPaperCard.appearanceIndexForRoomId(room.id),
    };

    expect(
      {
        for (final room in rooms.reversed)
          room.id: RoomPaperCard.appearanceIndexForRoomId(room.id),
      },
      appearanceById,
    );
    expect(appearanceById.values.toSet(), {0, 1, 2});
    for (final room in rooms) {
      expect(
        RoomPaperCard.appearanceIndexForRoomId(room.id),
        appearanceById[room.id],
      );
    }
  });

  testWidgets('room options button opens the localized text menu',
      (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final app = _app(
      rooms: [_room('room-1', 'Soggiorno', 'S')],
      textScale: 1.5,
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();
    final semantics = tester.ensureSemantics();
    final optionsButton = find.bySemanticsLabel('Opzioni stanza Soggiorno');
    expect(tester.getSize(optionsButton).width, greaterThanOrEqualTo(48));
    expect(tester.getSize(optionsButton).height, greaterThanOrEqualTo(48));
    expect(
      tester.getSemantics(optionsButton),
      matchesSemantics(
        label: 'Opzioni stanza Soggiorno',
        isButton: true,
        hasTapAction: true,
      ),
    );
    semantics.dispose();
    await tester.tap(optionsButton);
    await tester.pumpAndSettle();

    expect(find.text('Modifica'), findsOneWidget);
    expect(find.text('Elimina'), findsOneWidget);
    expect(find.byType(PopupMenuButton<Object>), findsNothing);
    expect(find.byType(InkWell), findsNothing);

    final editRow = find
        .ancestor(
          of: find.text('Modifica'),
          matching: find.byType(GestureDetector),
        )
        .first;
    expect(tester.getSize(editRow).height, greaterThanOrEqualTo(48));
    final rowMovement = find
        .descendant(
          of: editRow,
          matching: find.byType(AnimatedContainer),
        )
        .first;
    final gesture = await tester.startGesture(tester.getCenter(editRow));
    await tester.pump(
      const Duration(
        milliseconds: RoomPaperCardMetrics.optionsPressMilliseconds,
      ),
    );
    final transform = tester.widget<AnimatedContainer>(rowMovement).transform!;
    expect(
      transform.getTranslation().y,
      RoomPaperCardMetrics.optionsPressOffset,
    );
    await gesture.up();
    await tester.pumpAndSettle();
  });

  testWidgets('deleting a room reassigns its plants to unassigned',
      (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final roomRepository = _RoomRepository();
    final plantRepository = _PlantRepository();
    final app = _app(
      rooms: [_room('room-1', 'Soggiorno', 'S')],
      plants: [
        _plant('plant-in-room', 'room-1'),
        _plant('plant-elsewhere', 'room-2'),
      ],
      roomRepository: roomRepository,
      plantRepository: plantRepository,
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();
    final semantics = tester.ensureSemantics();
    final optionsButton = find.bySemanticsLabel('Opzioni stanza Soggiorno');
    await tester.tap(optionsButton);
    semantics.dispose();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Elimina'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('ELIMINA'));
    await tester.pumpAndSettle();

    expect(plantRepository.updatedPlants, hasLength(1));
    expect(plantRepository.updatedPlants.single.id, 'plant-in-room');
    expect(plantRepository.updatedPlants.single.roomId, 'unassigned');
    expect(roomRepository.deletedRoomIds, ['room-1']);
  });

  testWidgets('shows the paper empty state and fits at 1.5 text scale',
      (tester) async {
    final app = _app(rooms: [], textScale: 1.5);
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.text('Nessuna stanza creata.'), findsOneWidget);
    expect(find.text('Tocca "nuova stanza" per cominciare.'), findsOneWidget);
    expect(find.byType(RoomPaperCard), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('room cards fit at 1.5 text scale', (tester) async {
    final app = _app(
      rooms: [_room('room-1', 'Soggiorno molto lungo', 'S')],
      textScale: 1.5,
    );
    addTearDown(app.router.dispose);

    await tester.pumpWidget(app.widget);
    await tester.pumpAndSettle();

    expect(find.byType(RoomPaperCard), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
