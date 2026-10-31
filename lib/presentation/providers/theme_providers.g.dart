// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$temporalPeriodHash() => r'2a69888294181aa46c016275966cb440d7fb5ef5';

/// Provider reattivo per il periodo temporale corrente.
/// Si aggiorna ogni minuto via Stream.periodic, così il tema cambia
/// automaticamente al cambio dell'ora senza setState.
///
/// Copied from [temporalPeriod].
@ProviderFor(temporalPeriod)
final temporalPeriodProvider =
    AutoDisposeStreamProvider<TemporalPeriod>.internal(
  temporalPeriod,
  name: r'temporalPeriodProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$temporalPeriodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TemporalPeriodRef = AutoDisposeStreamProviderRef<TemporalPeriod>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
