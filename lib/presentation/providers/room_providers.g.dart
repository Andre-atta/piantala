// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomRepositoryHash() => r'34c03893ba668692a4406892166c2bace722f1cd';

/// See also [roomRepository].
@ProviderFor(roomRepository)
final roomRepositoryProvider = AutoDisposeProvider<IRoomRepository>.internal(
  roomRepository,
  name: r'roomRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$roomRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomRepositoryRef = AutoDisposeProviderRef<IRoomRepository>;
String _$roomsHash() => r'726dfa4936501009cc1a6edfce7c2c6a10ad8865';

/// See also [rooms].
@ProviderFor(rooms)
final roomsProvider = AutoDisposeStreamProvider<List<RoomEntity>>.internal(
  rooms,
  name: r'roomsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomsRef = AutoDisposeStreamProviderRef<List<RoomEntity>>;
String _$roomsWithPlantsCountHash() =>
    r'aacf28325db24e5b291289352ba90dc78986b096';

/// See also [roomsWithPlantsCount].
@ProviderFor(roomsWithPlantsCount)
final roomsWithPlantsCountProvider =
    AutoDisposeProvider<Map<String, int>>.internal(
  roomsWithPlantsCount,
  name: r'roomsWithPlantsCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$roomsWithPlantsCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomsWithPlantsCountRef = AutoDisposeProviderRef<Map<String, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
