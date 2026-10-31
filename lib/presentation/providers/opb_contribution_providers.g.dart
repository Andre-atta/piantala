// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'opb_contribution_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$opbContributionRepositoryHash() =>
    r'0e0626207571bd3da5fdc53b1cd733b32851e9e5';

/// See also [opbContributionRepository].
@ProviderFor(opbContributionRepository)
final opbContributionRepositoryProvider =
    AutoDisposeProvider<OpbContributionRepository>.internal(
  opbContributionRepository,
  name: r'opbContributionRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$opbContributionRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OpbContributionRepositoryRef
    = AutoDisposeProviderRef<OpbContributionRepository>;
String _$validateContributionHash() =>
    r'179ba020e85f6df60a64afdb44d8ec8ebc19c422';

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

/// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
///
/// Copied from [validateContribution].
@ProviderFor(validateContribution)
const validateContributionProvider = ValidateContributionFamily();

/// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
///
/// Copied from [validateContribution].
class ValidateContributionFamily
    extends Family<OpbContributionValidationResult> {
  /// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
  ///
  /// Copied from [validateContribution].
  const ValidateContributionFamily();

  /// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
  ///
  /// Copied from [validateContribution].
  ValidateContributionProvider call(
    OpbContributionEntity entity,
  ) {
    return ValidateContributionProvider(
      entity,
    );
  }

  @override
  ValidateContributionProvider getProviderOverride(
    covariant ValidateContributionProvider provider,
  ) {
    return call(
      provider.entity,
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
  String? get name => r'validateContributionProvider';
}

/// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
///
/// Copied from [validateContribution].
class ValidateContributionProvider
    extends AutoDisposeProvider<OpbContributionValidationResult> {
  /// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
  ///
  /// Copied from [validateContribution].
  ValidateContributionProvider(
    OpbContributionEntity entity,
  ) : this._internal(
          (ref) => validateContribution(
            ref as ValidateContributionRef,
            entity,
          ),
          from: validateContributionProvider,
          name: r'validateContributionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$validateContributionHash,
          dependencies: ValidateContributionFamily._dependencies,
          allTransitiveDependencies:
              ValidateContributionFamily._allTransitiveDependencies,
          entity: entity,
        );

  ValidateContributionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.entity,
  }) : super.internal();

  final OpbContributionEntity entity;

  @override
  Override overrideWith(
    OpbContributionValidationResult Function(ValidateContributionRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValidateContributionProvider._internal(
        (ref) => create(ref as ValidateContributionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        entity: entity,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<OpbContributionValidationResult> createElement() {
    return _ValidateContributionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateContributionProvider && other.entity == entity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, entity.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ValidateContributionRef
    on AutoDisposeProviderRef<OpbContributionValidationResult> {
  /// The parameter `entity` of this provider.
  OpbContributionEntity get entity;
}

class _ValidateContributionProviderElement
    extends AutoDisposeProviderElement<OpbContributionValidationResult>
    with ValidateContributionRef {
  _ValidateContributionProviderElement(super.provider);

  @override
  OpbContributionEntity get entity =>
      (origin as ValidateContributionProvider).entity;
}

String _$opbContributionControllerHash() =>
    r'681a0abdc759ef5703ff5e0df1cc4aa999fe4999';

/// Stato del controller di contribuzione.
///
/// [idle]    — nessuna operazione in corso.
/// Dopo [contribute] / [update]: lo stato mostra il risultato immediato
/// (l'operazione reale avviene in background via SyncService).
///
/// Copied from [OpbContributionController].
@ProviderFor(OpbContributionController)
final opbContributionControllerProvider = AutoDisposeNotifierProvider<
    OpbContributionController, AsyncValue<OpbContributionResult?>>.internal(
  OpbContributionController.new,
  name: r'opbContributionControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$opbContributionControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OpbContributionController
    = AutoDisposeNotifier<AsyncValue<OpbContributionResult?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
