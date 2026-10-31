// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$plantRepositoryHash() => r'04f1be2f2f237df0cdc3418afa2e9f28c72df7ea';

/// See also [plantRepository].
@ProviderFor(plantRepository)
final plantRepositoryProvider = AutoDisposeProvider<IPlantRepository>.internal(
  plantRepository,
  name: r'plantRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$plantRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlantRepositoryRef = AutoDisposeProviderRef<IPlantRepository>;
String _$plantsHash() => r'b0c45e9a243d53a3f1cbe3c7121c0c8f50ff1bc8';

/// See also [plants].
@ProviderFor(plants)
final plantsProvider = AutoDisposeStreamProvider<List<PlantEntity>>.internal(
  plants,
  name: r'plantsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$plantsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlantsRef = AutoDisposeStreamProviderRef<List<PlantEntity>>;
String _$plantHash() => r'1126e459f906e4061088089477533b22c68f8931';

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

/// See also [plant].
@ProviderFor(plant)
const plantProvider = PlantFamily();

/// See also [plant].
class PlantFamily extends Family<AsyncValue<PlantEntity?>> {
  /// See also [plant].
  const PlantFamily();

  /// See also [plant].
  PlantProvider call(
    String plantId,
  ) {
    return PlantProvider(
      plantId,
    );
  }

  @override
  PlantProvider getProviderOverride(
    covariant PlantProvider provider,
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
  String? get name => r'plantProvider';
}

/// See also [plant].
class PlantProvider extends AutoDisposeStreamProvider<PlantEntity?> {
  /// See also [plant].
  PlantProvider(
    String plantId,
  ) : this._internal(
          (ref) => plant(
            ref as PlantRef,
            plantId,
          ),
          from: plantProvider,
          name: r'plantProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$plantHash,
          dependencies: PlantFamily._dependencies,
          allTransitiveDependencies: PlantFamily._allTransitiveDependencies,
          plantId: plantId,
        );

  PlantProvider._internal(
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
    Stream<PlantEntity?> Function(PlantRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PlantProvider._internal(
        (ref) => create(ref as PlantRef),
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
  AutoDisposeStreamProviderElement<PlantEntity?> createElement() {
    return _PlantProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlantProvider && other.plantId == plantId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, plantId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PlantRef on AutoDisposeStreamProviderRef<PlantEntity?> {
  /// The parameter `plantId` of this provider.
  String get plantId;
}

class _PlantProviderElement
    extends AutoDisposeStreamProviderElement<PlantEntity?> with PlantRef {
  _PlantProviderElement(super.provider);

  @override
  String get plantId => (origin as PlantProvider).plantId;
}

String _$overduePlantsHash() => r'f375e7051a51c4faf63ef6f42d78e112a48b49e3';

/// See also [overduePlants].
@ProviderFor(overduePlants)
final overduePlantsProvider = AutoDisposeProvider<List<PlantEntity>>.internal(
  overduePlants,
  name: r'overduePlantsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$overduePlantsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OverduePlantsRef = AutoDisposeProviderRef<List<PlantEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
