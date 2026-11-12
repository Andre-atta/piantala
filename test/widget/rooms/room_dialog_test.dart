import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/domain/entities/user_entity.dart';
import 'package:piantala/domain/repositories/i_room_repository.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_dialog.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';

const _dialogGoldKey = ValueKey('room-dialog-golden');

class _RoomRepository implements IRoomRepository {
  final addedRooms = <RoomEntity>[];
  final updatedRooms = <RoomEntity>[];
  Completer<void>? addCompleter;

  @override
  Future<void> addRoom(RoomEntity room) async {
    addedRooms.add(room);
    await addCompleter?.future;
  }

  @override
  Future<void> deleteRoom(String roomId) async {}

  @override
  Future<void> updateRoom(RoomEntity room) async {
    updatedRooms.add(room);
  }

  @override
  Stream<List<RoomEntity>> watchRooms() => const Stream.empty();
}

({Widget widget, _RoomRepository repository}) _app({
  RoomEntity? room,
  double textScale = 1,
  _RoomRepository? repository,
}) {
  final roomRepository = repository ?? _RoomRepository();
  return (
    repository: roomRepository,
    widget: ProviderScope(
      overrides: [
        authStateProvider.overrideWith(
          (ref) => Stream.value(const UserEntity(uid: 'user-1')),
        ),
        roomRepositoryProvider.overrideWith((ref) => roomRepository),
      ],
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
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: RepaintBoundary(
            key: _dialogGoldKey,
            child: child,
          ),
        ),
        home: Consumer(
          builder: (context, ref, child) {
            ref.watch(authStateProvider);
            return Builder(
              builder: (context) => Scaffold(
                backgroundColor: PiantalaTheme.standard.cream,
                body: Center(
                  child: TextButton(
                    key: const ValueKey('open-room-dialog'),
                    onPressed: () => showPaperDialog<void>(
                      context: context,
                      builder: (context) => RoomDialog(room: room),
                    ),
                    child: const Text('Open'),
                  ),
                ),
              ),
            );
          },
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

Future<void> _openDialog(WidgetTester tester) async {
  await tester.tap(find.byKey(const ValueKey('open-room-dialog')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('creates a room with existing room fields', (tester) async {
    final app = _app();
    await tester.pumpWidget(app.widget);
    await _openDialog(tester);

    await tester.enterText(
      find.byKey(const ValueKey('room-dialog-name-field')),
      'Studio',
    );
    await tester.enterText(
      find.byKey(const ValueKey('room-dialog-notes-field')),
      'Vicino alla finestra',
    );
    await tester.tap(find.byKey(const ValueKey('room-dialog-save')));
    await tester.pumpAndSettle();

    expect(app.repository.addedRooms, hasLength(1));
    final savedRoom = app.repository.addedRooms.single;
    expect(savedRoom.userId, 'user-1');
    expect(savedRoom.name, 'Studio');
    expect(savedRoom.notes, 'Vicino alla finestra');
    expect(savedRoom.exposure, 'UNKNOWN');
    expect(savedRoom.createdAt.isUtc, isTrue);
    expect(find.byType(RoomDialog), findsNothing);
  });

  testWidgets('loads and updates an existing room', (tester) async {
    final room = RoomEntity(
      id: 'room-1',
      userId: 'user-1',
      name: 'Soggiorno',
      exposure: 'NE',
      notes: 'Luce del mattino',
      createdAt: DateTime(2026),
    );
    final app = _app(room: room);
    await tester.pumpWidget(app.widget);
    await _openDialog(tester);

    expect(
      tester
          .widget<TextFormField>(
            find.byKey(const ValueKey('room-dialog-name-field')),
          )
          .controller!
          .text,
      'Soggiorno',
    );
    expect(
      tester
          .widget<TextFormField>(
            find.byKey(const ValueKey('room-dialog-notes-field')),
          )
          .controller!
          .text,
      'Luce del mattino',
    );
    expect(find.text('Nord-Est'), findsOneWidget);

    await tester.enterText(
      find.byKey(const ValueKey('room-dialog-name-field')),
      'Studio',
    );
    await tester.tap(find.byKey(const ValueKey('room-dialog-save')));
    await tester.pumpAndSettle();

    expect(app.repository.updatedRooms, hasLength(1));
    expect(app.repository.updatedRooms.single.id, 'room-1');
    expect(app.repository.updatedRooms.single.createdAt, room.createdAt);
    expect(app.repository.updatedRooms.single.name, 'Studio');
    expect(app.repository.updatedRooms.single.exposure, 'NE');
    expect(app.repository.updatedRooms.single.notes, 'Luce del mattino');
  });

  testWidgets('validates an empty room name in terracotta', (tester) async {
    final app = _app();
    await tester.pumpWidget(app.widget);
    await _openDialog(tester);

    await tester.tap(find.byKey(const ValueKey('room-dialog-save')));
    await tester.pumpAndSettle();

    final error = tester.widget<Text>(find.text('Inserisci un nome'));
    expect(error.style?.color, PiantalaTheme.standard.terracotta);
    expect(app.repository.addedRooms, isEmpty);
  });

  testWidgets('compass button has a labeled 48 dp target', (tester) async {
    final app = _app();
    await tester.pumpWidget(app.widget);
    await _openDialog(tester);

    final semantics = tester.ensureSemantics();
    final compass = find.bySemanticsLabel(
      "Rileva l'esposizione con la bussola",
    );
    expect(tester.getSize(compass).width, greaterThanOrEqualTo(48));
    expect(tester.getSize(compass).height, greaterThanOrEqualTo(48));
    expect(
      tester.getSemantics(compass),
      matchesSemantics(
        label: "Rileva l'esposizione con la bussola",
        isButton: true,
        hasTapAction: true,
      ),
    );
    semantics.dispose();
  });

  testWidgets('disables save while repository is saving', (tester) async {
    final repository = _RoomRepository()..addCompleter = Completer<void>();
    final app = _app(repository: repository);
    await tester.pumpWidget(app.widget);
    await _openDialog(tester);
    await tester.enterText(
      find.byKey(const ValueKey('room-dialog-name-field')),
      'Studio',
    );

    final semantics = tester.ensureSemantics();
    await tester.tap(find.byKey(const ValueKey('room-dialog-save')));
    await tester.pump();

    expect(
      tester
          .widget<HangingTag>(
            find.byKey(const ValueKey('room-dialog-save')),
          )
          .onPressed,
      isNull,
    );
    expect(find.byType(CircularProgressIndicator), findsNothing);
    semantics.dispose();

    repository.addCompleter!.complete();
    await tester.pumpAndSettle();
    expect(find.byType(RoomDialog), findsNothing);
  });

  testWidgets('keeps the form scrollable and actions above the keyboard',
      (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetViewInsets);
    final app = _app();
    await tester.pumpWidget(app.widget);
    await _openDialog(tester);

    tester.view.viewInsets = const FakeViewPadding(bottom: 320);
    await tester.pumpAndSettle();

    final keyboardTop =
        tester.view.physicalSize.height / tester.view.devicePixelRatio - 320;
    expect(
      tester.getRect(find.byKey(const ValueKey('room-dialog-save'))).bottom,
      lessThanOrEqualTo(keyboardTop),
    );
    expect(
      tester
          .getRect(
            find.byKey(const ValueKey('room-dialog-name-field')),
          )
          .top,
      lessThan(keyboardTop),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('renders new and edit dialog goldens at normal and large text',
      (tester) async {
    _setScreenSize(tester);
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final room = RoomEntity(
      id: 'room-1',
      userId: 'user-1',
      name: 'Soggiorno',
      exposure: 'S',
      notes: 'Pianta vicino alla finestra',
      createdAt: DateTime(2026),
    );

    for (final (mode, roomToEdit) in [
      ('new', null),
      ('edit', room),
    ]) {
      final app = _app(room: roomToEdit, textScale: 1.5);
      await tester.pumpWidget(app.widget);
      await _openDialog(tester);
      await expectLater(
        find.byKey(_dialogGoldKey),
        matchesGoldenFile('goldens/room_dialog_$mode.png'),
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    }
  });
}
