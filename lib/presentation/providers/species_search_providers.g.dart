// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$plantbookCloudServiceHash() =>
    r'de54fd324048f37270c1753a0e97358ecc425937';

/// See also [plantbookCloudService].
@ProviderFor(plantbookCloudService)
final plantbookCloudServiceProvider =
    AutoDisposeProvider<PlantbookCloudService>.internal(
  plantbookCloudService,
  name: r'plantbookCloudServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$plantbookCloudServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlantbookCloudServiceRef
    = AutoDisposeProviderRef<PlantbookCloudService>;
String _$localCatalogServiceHash() =>
    r'ef82ab8b7b31807ab0b4d2c5c7fff244fc1907cb';

/// See also [localCatalogService].
@ProviderFor(localCatalogService)
final localCatalogServiceProvider =
    AutoDisposeProvider<LocalCatalogService>.internal(
  localCatalogService,
  name: r'localCatalogServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$localCatalogServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalCatalogServiceRef = AutoDisposeProviderRef<LocalCatalogService>;
String _$speciesRepositoryHash() => r'0f316cfb2534c65ec94997e7bfe9d7f903110eab';

/// See also [speciesRepository].
@ProviderFor(speciesRepository)
final speciesRepositoryProvider =
    AutoDisposeProvider<SpeciesRepositoryImpl>.internal(
  speciesRepository,
  name: r'speciesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$speciesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SpeciesRepositoryRef = AutoDisposeProviderRef<SpeciesRepositoryImpl>;
String _$speciesDetailsHash() => r'50ba2817a1ff50f574325a68c06a5f9f3397bcb5';

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

/// See also [speciesDetails].
@ProviderFor(speciesDetails)
const speciesDetailsProvider = SpeciesDetailsFamily();

/// See also [speciesDetails].
class SpeciesDetailsFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [speciesDetails].
  const SpeciesDetailsFamily();

  /// See also [speciesDetails].
  SpeciesDetailsProvider call(
    String apiId,
  ) {
    return SpeciesDetailsProvider(
      apiId,
    );
  }

  @override
  SpeciesDetailsProvider getProviderOverride(
    covariant SpeciesDetailsProvider provider,
  ) {
    return call(
      provider.apiId,
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
  String? get name => r'speciesDetailsProvider';
}

/// See also [speciesDetails].
class SpeciesDetailsProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [speciesDetails].
  SpeciesDetailsProvider(
    String apiId,
  ) : this._internal(
          (ref) => speciesDetails(
            ref as SpeciesDetailsRef,
            apiId,
          ),
          from: speciesDetailsProvider,
          name: r'speciesDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$speciesDetailsHash,
          dependencies: SpeciesDetailsFamily._dependencies,
          allTransitiveDependencies:
              SpeciesDetailsFamily._allTransitiveDependencies,
          apiId: apiId,
        );

  SpeciesDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.apiId,
  }) : super.internal();

  final String apiId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SpeciesDetailsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpeciesDetailsProvider._internal(
        (ref) => create(ref as SpeciesDetailsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        apiId: apiId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SpeciesDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpeciesDetailsProvider && other.apiId == apiId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, apiId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SpeciesDetailsRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `apiId` of this provider.
  String get apiId;
}

class _SpeciesDetailsProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SpeciesDetailsRef {
  _SpeciesDetailsProviderElement(super.provider);

  @override
  String get apiId => (origin as SpeciesDetailsProvider).apiId;
}

String _$speciesSearchHash() => r'682f86c1fe19524a4088e26883f13435b6bb95fb';

/// See also [SpeciesSearch].
@ProviderFor(SpeciesSearch)
final speciesSearchProvider = NotifierProvider<SpeciesSearch,
    AsyncValue<List<Map<String, dynamic>>>>.internal(
  SpeciesSearch.new,
  name: r'speciesSearchProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$speciesSearchHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SpeciesSearch = Notifier<AsyncValue<List<Map<String, dynamic>>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
