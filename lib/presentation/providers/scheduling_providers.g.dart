// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduling_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$plantScheduleHash() => r'd2ac926b14448b99c5afdea0b1109ea684243582';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [plantSchedule].
@ProviderFor(plantSchedule)
const plantScheduleProvider = PlantScheduleFamily();

/// See also [plantSchedule].
class PlantScheduleFamily extends Family<SchedulingResult?> {
  /// See also [plantSchedule].
  const PlantScheduleFamily();

  /// See also [plantSchedule].
  PlantScheduleProvider call(
    String plantId,
  ) {
    return PlantScheduleProvider(
      plantId,
    );
  }

  @override
  PlantScheduleProvider getProviderOverride(
    covariant PlantScheduleProvider provider,
  ) {
    return call(
      provider.plantId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'plantScheduleProvider';
}

/// See also [plantSchedule].
class PlantScheduleProvider extends AutoDisposeProvider<SchedulingResult?> {
  /// See also [plantSchedule].
  PlantScheduleProvider(
    String plantId,
  ) : this._internal(
          (ref) => plantSchedule(
            ref as PlantScheduleRef,
            plantId,
          ),
          from: plantScheduleProvider,
          name: r'plantScheduleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$plantScheduleHash,
          dependencies: PlantScheduleFamily._dependencies,
          allTransitiveDependencies:
              PlantScheduleFamily._allTransitiveDependencies,
          plantId: plantId,
        );

  PlantScheduleProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.plantId,
  }) : super.internal();

  final String plantId;

  @override
  Override overrideWith(
    SchedulingResult? Function(PlantScheduleRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlantScheduleProvider._internal(
        (ref) => create(ref as PlantScheduleRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        plantId: plantId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<SchedulingResult?> createElement() {
    return _PlantScheduleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlantScheduleProvider && other.plantId == plantId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, plantId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlantScheduleRef on AutoDisposeProviderRef<SchedulingResult?> {
  /// The parameter `plantId` of this provider.
  String get plantId;
}

class _PlantScheduleProviderElement
    extends AutoDisposeProviderElement<SchedulingResult?>
    with PlantScheduleRef {
  _PlantScheduleProviderElement(super.provider);

  @override
  String get plantId => (origin as PlantScheduleProvider).plantId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
