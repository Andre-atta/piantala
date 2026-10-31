import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:isar/isar.dart';
import 'package:piantala/data/local/collections/pending_operation_collection.dart';
import 'package:piantala/data/local/isar_service.dart';
import 'package:piantala/data/services/plantbook_cloud_service.dart';
import 'package:piantala/domain/entities/opb_contribution_entity.dart';
import 'package:uuid/uuid.dart';

/// Repository per le contribuzioni a OpenPlantBook (Feature 1).
///
/// Le chiamate alle callable avvengono in modo asincrono tramite
/// [PendingOperationCollection]: il salvataggio locale è immediato e non blocca
/// l'esperienza utente; la chiamata di rete viene eseguita in background da
/// [SyncService] e ritentata in caso di fallimento.
class OpbContributionRepository {
  OpbContributionRepository({
    PlantbookCloudService? cloudService,
    Isar? isar,
  })  : _customCloudService = cloudService,
        _customIsar = isar;

  final PlantbookCloudService? _customCloudService;
  final Isar? _customIsar;

  PlantbookCloudService get _cloudService =>
      _customCloudService ?? PlantbookCloudService();
  Isar get _isar => _customIsar ?? IsarService.instance.db;

  final Uuid _uuid = const Uuid();

  /// Accoda una nuova contribuzione di specie.
  ///
  /// Salva l'operazione in [PendingOperationCollection] con
  /// `operation = 'opb_contribute'` e ritorna immediatamente.
  /// [SyncService] eseguirà la callable in background.
  Future<void> enqueueContribute({
    required String userId,
    required OpbContributionEntity entity,
  }) async {
    final payload = _entityToPayload(entity);

    final pendingOp = PendingOperationCollection()
      ..operationId = _uuid.v4()
      ..userId = userId
      ..collectionPath = 'opb'
      ..documentId = entity.displayPid.toLowerCase()
      ..operation = 'opb_contribute'
      ..payloadJson = jsonEncode(payload)
      ..createdAt = DateTime.now()
      ..attemptCount = 0;

    await _isar.writeTxn(() async {
      await _isar.pendingOperationCollections.put(pendingOp);
    });
  }

  /// Accoda un aggiornamento di specie esistente.
  ///
  /// [pid] deve essere il pid lowercase della specie (es. "monstera deliciosa").
  /// [partial] deve contenere almeno un campo valorizzato (oltre a displayPid).
  Future<void> enqueueUpdate({
    required String userId,
    required String pid,
    required OpbContributionEntity partial,
  }) async {
    final payload = _entityToPayload(partial);

    final pendingOp = PendingOperationCollection()
      ..operationId = _uuid.v4()
      ..userId = userId
      ..collectionPath = 'opb'
      ..documentId = pid
      ..operation = 'opb_update'
      ..payloadJson = jsonEncode({'pid': pid, ...payload})
      ..createdAt = DateTime.now()
      ..attemptCount = 0;

    await _isar.writeTxn(() async {
      await _isar.pendingOperationCollections.put(pendingOp);
    });
  }

  /// Esegue la contribuzione direttamente (usato da [SyncService] nel drain).
  ///
  /// Ritorna il risultato mappato. NON accoda — è chiamato dalla coda stessa.
  Future<OpbContributionResult> executeContribute(
    Map<String, dynamic> payload,
  ) async {
    return _callAndMap(() => _cloudService.contributeSpecies(payload));
  }

  /// Esegue l'aggiornamento direttamente (usato da [SyncService] nel drain).
  Future<OpbContributionResult> executeUpdate(
    String pid,
    Map<String, dynamic> partialPayload,
  ) async {
    return _callAndMap(() => _cloudService.updateSpecies(pid, partialPayload));
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  /// Converte [OpbContributionEntity] in Map per il payload della callable.
  ///
  /// I campi null vengono OMESSI (non inviati come 0 o stringa vuota).
  /// I campi gestiti dal server (pid, user, common_names) non esistono
  /// nell'entity e quindi non vengono mai inclusi.
  static Map<String, dynamic> _entityToPayload(OpbContributionEntity entity) {
    final map = <String, dynamic>{
      'display_pid': entity.displayPid,
    };
    if (entity.alias != null) map['alias'] = entity.alias;
    if (entity.category != null) map['category'] = entity.category;
    if (entity.origin != null) map['origin'] = entity.origin;
    if (entity.maxLightMmol != null)
      map['max_light_mmol'] = entity.maxLightMmol;
    if (entity.minLightMmol != null)
      map['min_light_mmol'] = entity.minLightMmol;
    if (entity.maxLightLux != null) map['max_light_lux'] = entity.maxLightLux;
    if (entity.minLightLux != null) map['min_light_lux'] = entity.minLightLux;
    if (entity.maxTemp != null) map['max_temp'] = entity.maxTemp;
    if (entity.minTemp != null) map['min_temp'] = entity.minTemp;
    if (entity.maxEnvHumid != null) map['max_env_humid'] = entity.maxEnvHumid;
    if (entity.minEnvHumid != null) map['min_env_humid'] = entity.minEnvHumid;
    if (entity.maxSoilMoist != null)
      map['max_soil_moist'] = entity.maxSoilMoist;
    if (entity.minSoilMoist != null)
      map['min_soil_moist'] = entity.minSoilMoist;
    if (entity.maxSoilEc != null) map['max_soil_ec'] = entity.maxSoilEc;
    if (entity.minSoilEc != null) map['min_soil_ec'] = entity.minSoilEc;
    if (entity.sunlight != null) map['sunlight'] = entity.sunlight;
    if (entity.watering != null) map['watering'] = entity.watering;
    if (entity.fertilization != null)
      map['fertilization'] = entity.fertilization;
    if (entity.pruning != null) map['pruning'] = entity.pruning;
    if (entity.soil != null) map['soil'] = entity.soil;
    return map;
  }

  Future<OpbContributionResult> _callAndMap(
    Future<Map<String, dynamic>> Function() call,
  ) async {
    try {
      final response = await call();

      if (response['success'] == true) {
        return OpbContributionResult.success(
          pid: response['pid'] as String? ?? '',
        );
      }
      if (response['alreadyExists'] == true) {
        return const OpbContributionResult.alreadyExists();
      }
      if (response['rateLimited'] == true) {
        return const OpbContributionResult.rateLimited();
      }
      if (response['validationError'] != null) {
        final ve = response['validationError'] as Map<String, dynamic>;
        return OpbContributionResult.validationError(
          field: ve['field'] as String? ?? 'unknown',
          message: ve['message'] as String? ?? 'Dati non validi.',
        );
      }

      return const OpbContributionResult.error(
        message: 'Risposta inattesa dal server.',
      );
    } on FirebaseFunctionsException catch (e) {
      if (e.code == 'resource-exhausted') {
        return const OpbContributionResult.quotaExceeded();
      }
      return OpbContributionResult.error(message: e.message ?? e.code);
    } catch (e) {
      return OpbContributionResult.error(message: e.toString());
    }
  }
}
