// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$roomRepositoryHash() => r'c4203a93d25a7498929125fde35b6dba33bdc27d';

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
String _$roomsHash() => r'8ce9c8c999e6745f21bf5ed7b45b782d03e170dd';

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
