import 'package:flutter/material.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_providers.g.dart';

/// Provider reattivo per il periodo temporale corrente.
/// Si aggiorna ogni minuto via Stream.periodic, così il tema cambia
/// automaticamente al cambio dell'ora senza setState.
@riverpod
Stream<TemporalPeriod> temporalPeriod(TemporalPeriodRef ref) async* {
  // Emette subito il valore corrente
  yield TemporalPeriodX.fromHour(DateTime.now().hour);

  // Poi aggiorna ogni 60 secondi
  await for (final _ in Stream<void>.periodic(const Duration(minutes: 1))) {
    yield TemporalPeriodX.fromHour(DateTime.now().hour);
  }
}

/// ThemeData calcolato dal periodo corrente.
final appThemeDataProvider = Provider<ThemeData>((ref) {
  final periodAsync = ref.watch(temporalPeriodProvider);
  final period =
      periodAsync.valueOrNull ?? TemporalPeriodX.fromHour(DateTime.now().hour);
  return TemporalTheme.buildTheme(period);
});
