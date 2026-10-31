import 'package:freezed_annotation/freezed_annotation.dart';

part 'opb_contribution_entity.freezed.dart';

/// Payload per contribuire a OpenPlantBook tramite le callable
/// [contributeSpecies] (POST /api/v1/plant/create) e
/// [updateSpecies] (PATCH /api/v1/plant/update).
///
/// Campi omessi (null) NON vengono inviati nel payload — diventano null
/// nel profilo OPB solo per i nuovi record (create). Per un update, i campi
/// omessi non vengono modificati.
///
/// Campi gestiti dal server e ignorati se inviati: pid, user, common_names.
/// NON includerli nel payload — questa entity non li ha.
///
/// Limiti di lunghezza rispettano il PlantCreateRequest / PatchedPlantUpdateRequest
/// dello schema OpenAPI 202606.
@freezed
class OpbContributionEntity with _$OpbContributionEntity {
  const factory OpbContributionEntity({
    /// OBBLIGATORIO per create. Il pid interno è derivato abbassando a minuscolo.
    /// Deve essere un binomio scientifico (es. "Monstera deliciosa").
    /// MaxLength: 100.
    required String displayPid,

    /// Nome comune / alias (es. "Swiss Cheese Plant"). MaxLength: 100.
    String? alias,

    /// Categoria tassonomica (es. "Aroid"). MaxLength: 100.
    String? category,

    /// Origine geografica (es. "Central America"). MaxLength: 100.
    String? origin,

    // ── Luce ────────────────────────────────────────────────────────
    /// Luce massima in mmol/m²/giorno.
    int? maxLightMmol,

    /// Luce minima in mmol/m²/giorno.
    int? minLightMmol,

    /// Luce massima in lux.
    int? maxLightLux,

    /// Luce minima in lux.
    int? minLightLux,

    // ── Temperatura ─────────────────────────────────────────────────
    /// Temperatura massima (°C).
    int? maxTemp,

    /// Temperatura minima (°C).
    int? minTemp,

    // ── Umidità ambientale ───────────────────────────────────────────
    /// Umidità ambientale massima (%).
    int? maxEnvHumid,

    /// Umidità ambientale minima (%).
    int? minEnvHumid,

    // ── Umidità del substrato ────────────────────────────────────────
    /// Umidità substrato massima (%).
    int? maxSoilMoist,

    /// Umidità substrato minima (%).
    int? minSoilMoist,

    // ── Conducibilità elettrica ──────────────────────────────────────
    /// EC massima (µS/cm).
    int? maxSoilEc,

    /// EC minima (µS/cm).
    int? minSoilEc,

    // ── Istruzioni di cura testuali ──────────────────────────────────
    /// Descrizione esposizione solare. MaxLength: 200.
    String? sunlight,

    /// Istruzioni di irrigazione. MaxLength: 200.
    String? watering,

    /// Istruzioni di concimazione. MaxLength: 250.
    String? fertilization,

    /// Istruzioni di potatura. MaxLength: 200.
    String? pruning,

    /// Tipo di substrato consigliato. MaxLength: 150.
    String? soil,
  }) = _OpbContributionEntity;

  // Nessun fromJson — questa entity viene costruita dalla UI e
  // serializzata direttamente nel payload della callable.
}

/// Risultato di un tentativo di contribuzione / aggiornamento.
@freezed
class OpbContributionResult with _$OpbContributionResult {
  /// Contribuzione accettata con successo.
  const factory OpbContributionResult.success({required String pid}) =
      OpbContributionSuccess;

  /// La specie esiste già (409). Suggerire il percorso updateSpecies.
  const factory OpbContributionResult.alreadyExists() =
      OpbContributionAlreadyExists;

  /// Rate limit OPB (429). Il client riproverà tramite la coda.
  const factory OpbContributionResult.rateLimited() =
      OpbContributionRateLimited;

  /// Errore di validazione lato API (400). Mostra il campo e il messaggio.
  const factory OpbContributionResult.validationError({
    required String field,
    required String message,
  }) = OpbContributionValidationError;

  /// Quota giornaliera utente esaurita.
  const factory OpbContributionResult.quotaExceeded() =
      OpbContributionQuotaExceeded;

  /// Errore generico.
  const factory OpbContributionResult.error({required String message}) =
      OpbContributionError;
}
