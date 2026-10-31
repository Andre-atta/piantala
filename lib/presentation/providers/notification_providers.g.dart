// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'542f3e97a87f09ca5c72830623878403759347f8';

/// See also [notificationService].
@ProviderFor(notificationService)
final notificationServiceProvider = Provider<NotificationService>.internal(
  notificationService,
  name: r'notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationServiceRef = ProviderRef<NotificationService>;
String _$notificationsSyncControllerHash() =>
    r'cac4cfe16991bdd3dffaafdbbb2b28e06120906b';

/// See also [notificationsSyncController].
@ProviderFor(notificationsSyncController)
final notificationsSyncControllerProvider =
    AutoDisposeFutureProvider<void>.internal(
  notificationsSyncController,
  name: r'notificationsSyncControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationsSyncControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationsSyncControllerRef = AutoDisposeFutureProviderRef<void>;
String _$reminderHourHash() => r'b14ffe1232ec81ead663025874ec48e77b0e7bd9';

/// See also [ReminderHour].
@ProviderFor(ReminderHour)
final reminderHourProvider = NotifierProvider<ReminderHour, int>.internal(
  ReminderHour.new,
  name: r'reminderHourProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$reminderHourHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReminderHour = Notifier<int>;
String _$reminderMinuteHash() => r'64e1e7e5588a16271de2ae951e3374c6e62d0d31';

/// See also [ReminderMinute].
@ProviderFor(ReminderMinute)
final reminderMinuteProvider = NotifierProvider<ReminderMinute, int>.internal(
  ReminderMinute.new,
  name: r'reminderMinuteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$reminderMinuteHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ReminderMinute = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
