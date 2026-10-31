// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_accent_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$speciesAccentColorHash() =>
    r'e6f4a05f939955920c7ca254cf786ff2f01d4b57';

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

/// Restituisce il colore d'accento per una data specie (slug scientifico).
///
/// Il widget legge questo provider — MAI il catalogo direttamente.
/// Se la specie non è nel catalogo, restituisce `null`.
///
/// Copied from [speciesAccentColor].
@ProviderFor(speciesAccentColor)
const speciesAccentColorProvider = SpeciesAccentColorFamily();

/// Restituisce il colore d'accento per una data specie (slug scientifico).
///
/// Il widget legge questo provider — MAI il catalogo direttamente.
/// Se la specie non è nel catalogo, restituisce `null`.
///
/// Copied from [speciesAccentColor].
class SpeciesAccentColorFamily extends Family<Color?> {
  /// Restituisce il colore d'accento per una data specie (slug scientifico).
  ///
  /// Il widget legge questo provider — MAI il catalogo direttamente.
  /// Se la specie non è nel catalogo, restituisce `null`.
  ///
  /// Copied from [speciesAccentColor].
  const SpeciesAccentColorFamily();

  /// Restituisce il colore d'accento per una data specie (slug scientifico).
  ///
  /// Il widget legge questo provider — MAI il catalogo direttamente.
  /// Se la specie non è nel catalogo, restituisce `null`.
  ///
  /// Copied from [speciesAccentColor].
  SpeciesAccentColorProvider call(
    String speciesSlug,
  ) {
    return SpeciesAccentColorProvider(
      speciesSlug,
    );
  }

  @override
  SpeciesAccentColorProvider getProviderOverride(
    covariant SpeciesAccentColorProvider provider,
  ) {
    return call(
      provider.speciesSlug,
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
  String? get name => r'speciesAccentColorProvider';
}

/// Restituisce il colore d'accento per una data specie (slug scientifico).
///
/// Il widget legge questo provider — MAI il catalogo direttamente.
/// Se la specie non è nel catalogo, restituisce `null`.
///
/// Copied from [speciesAccentColor].
class SpeciesAccentColorProvider extends AutoDisposeProvider<Color?> {
  /// Restituisce il colore d'accento per una data specie (slug scientifico).
  ///
  /// Il widget legge questo provider — MAI il catalogo direttamente.
  /// Se la specie non è nel catalogo, restituisce `null`.
  ///
  /// Copied from [speciesAccentColor].
  SpeciesAccentColorProvider(
    String speciesSlug,
  ) : this._internal(
          (ref) => speciesAccentColor(
            ref as SpeciesAccentColorRef,
            speciesSlug,
          ),
          from: speciesAccentColorProvider,
          name: r'speciesAccentColorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$speciesAccentColorHash,
          dependencies: SpeciesAccentColorFamily._dependencies,
          allTransitiveDependencies:
              SpeciesAccentColorFamily._allTransitiveDependencies,
          speciesSlug: speciesSlug,
        );

  SpeciesAccentColorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.speciesSlug,
  }) : super.internal();

  final String speciesSlug;

  @override
  Override overrideWith(
    Color? Function(SpeciesAccentColorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SpeciesAccentColorProvider._internal(
        (ref) => create(ref as SpeciesAccentColorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        speciesSlug: speciesSlug,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<Color?> createElement() {
    return _SpeciesAccentColorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SpeciesAccentColorProvider &&
        other.speciesSlug == speciesSlug;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, speciesSlug.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SpeciesAccentColorRef on AutoDisposeProviderRef<Color?> {
  /// The parameter `speciesSlug` of this provider.
  String get speciesSlug;
}

class _SpeciesAccentColorProviderElement
    extends AutoDisposeProviderElement<Color?> with SpeciesAccentColorRef {
  _SpeciesAccentColorProviderElement(super.provider);

  @override
  String get speciesSlug => (origin as SpeciesAccentColorProvider).speciesSlug;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
