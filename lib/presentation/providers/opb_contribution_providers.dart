import 'package:piantala/data/repositories/opb_contribution_repository.dart';
import 'package:piantala/domain/entities/opb_contribution_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'opb_contribution_providers.g.dart';

// ── Repository provider ───────────────────────────────────────────────────────

@riverpod
OpbContributionRepository opbContributionRepository(
  OpbContributionRepositoryRef ref,
) {
  return OpbContributionRepository();
}

// ── Controller (enqueue + stato UI) ──────────────────────────────────────────

/// Stato del controller di contribuzione.
///
/// [idle]    — nessuna operazione in corso.
/// Dopo [contribute] / [update]: lo stato mostra il risultato immediato
/// (l'operazione reale avviene in background via SyncService).
@riverpod
class OpbContributionController extends _$OpbContributionController {
  @override
  AsyncValue<OpbContributionResult?> build() => const AsyncData(null);

  /// Accoda una nuova contribuzione e aggiorna lo stato con il risultato
  /// dell'operazione di accodamento (NON il risultato della callable — quello
  /// arriverà in background).
  Future<void> contribute({
    required String userId,
    required OpbContributionEntity entity,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(opbContributionRepositoryProvider);
      await repo.enqueueContribute(userId: userId, entity: entity);
      // L'operazione è stata accodata con successo — lo stato "pending"
      // è il massimo che possiamo sapere in questo momento.
      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  /// Accoda un aggiornamento di specie esistente.
  Future<void> update({
    required String userId,
    required String pid,
    required OpbContributionEntity partial,
  }) async {
    state = const AsyncLoading();
    try {
      final repo = ref.read(opbContributionRepositoryProvider);
      await repo.enqueueUpdate(userId: userId, pid: pid, partial: partial);
      state = const AsyncData(null);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  void reset() {
    state = const AsyncData(null);
  }
}

// ── Validazione form (sincrona, senza I/O) ────────────────────────────────────

/// Risultato della validazione del form di contribuzione.
class OpbContributionValidationResult {
  const OpbContributionValidationResult({
    required this.isValid,
    required this.errors,
    required this.filledNumericFieldCount,
  });

  /// True se il form è pronto per il submit.
  final bool isValid;

  /// Mappa campo → messaggio di errore. Vuota se non ci sono errori.
  final Map<String, String> errors;

  /// Numero di campi numerici valorizzati. Submit abilitato se ≥ 3.
  final int filledNumericFieldCount;
}

/// Provider di validazione — ricalcolato ogni volta che [entity] cambia.
@riverpod
OpbContributionValidationResult validateContribution(
  ValidateContributionRef ref,
  OpbContributionEntity entity,
) {
  final errors = <String, String>{};

  // ── display_pid ──────────────────────────────────────────────────────────
  final pidPattern = RegExp(r'^[A-Za-z]+ [A-Za-z]+$');
  if (entity.displayPid.isEmpty) {
    errors['displayPid'] = 'Il nome scientifico è obbligatorio.';
  } else if (!pidPattern.hasMatch(entity.displayPid.trim())) {
    errors['displayPid'] =
        'Inserisci un binomio scientifico valido (es. "Monstera deliciosa"). '
        'Solo lettere latine, due parole.';
  } else if (entity.displayPid.length > 100) {
    errors['displayPid'] = 'Massimo 100 caratteri.';
  }

  // ── Coppie min/max ────────────────────────────────────────────────────────
  void checkMinMax(
    String key,
    int? minVal,
    int? maxVal,
    int minAllowed,
    int maxAllowed,
  ) {
    if (minVal != null && (minVal < minAllowed || minVal > maxAllowed)) {
      errors['${key}Min'] = 'Valore fuori range ($minAllowed–$maxAllowed).';
    }
    if (maxVal != null && (maxVal < minAllowed || maxVal > maxAllowed)) {
      errors['${key}Max'] = 'Valore fuori range ($minAllowed–$maxAllowed).';
    }
    if (minVal != null && maxVal != null && minVal >= maxVal) {
      errors['${key}Min'] =
          'Il valore minimo deve essere inferiore al massimo.';
    }
  }

  checkMinMax('temp', entity.minTemp, entity.maxTemp, -20, 60);
  checkMinMax('envHumid', entity.minEnvHumid, entity.maxEnvHumid, 0, 100);
  checkMinMax('soilMoist', entity.minSoilMoist, entity.maxSoilMoist, 0, 100);
  checkMinMax('lightMmol', entity.minLightMmol, entity.maxLightMmol, 0, 10000);
  checkMinMax('lightLux', entity.minLightLux, entity.maxLightLux, 0, 200000);
  checkMinMax('soilEc', entity.minSoilEc, entity.maxSoilEc, 0, 5000);

  // ── Lunghezze massime campi testuali ──────────────────────────────────────
  if ((entity.alias?.length ?? 0) > 100) {
    errors['alias'] = 'Massimo 100 caratteri.';
  }
  if ((entity.category?.length ?? 0) > 100) {
    errors['category'] = 'Massimo 100 caratteri.';
  }
  if ((entity.origin?.length ?? 0) > 100) {
    errors['origin'] = 'Massimo 100 caratteri.';
  }
  if ((entity.fertilization?.length ?? 0) > 250) {
    errors['fertilization'] = 'Massimo 250 caratteri.';
  }
  if ((entity.soil?.length ?? 0) > 150) {
    errors['soil'] = 'Massimo 150 caratteri.';
  }

  // ── Conta campi numerici valorizzati ─────────────────────────────────────
  final filledCount = [
    entity.maxLightMmol,
    entity.minLightMmol,
    entity.maxLightLux,
    entity.minLightLux,
    entity.maxTemp,
    entity.minTemp,
    entity.maxEnvHumid,
    entity.minEnvHumid,
    entity.maxSoilMoist,
    entity.minSoilMoist,
    entity.maxSoilEc,
    entity.minSoilEc,
  ].whereType<int>().length;

  // Submit abilitato: nessun errore + displayPid valido + ≥ 3 campi numerici.
  final isValid = errors.isEmpty && filledCount >= 3;

  return OpbContributionValidationResult(
    isValid: isValid,
    errors: errors,
    filledNumericFieldCount: filledCount,
  );
}
