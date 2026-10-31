import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

class PlantbookCloudService {
  PlantbookCloudService({FirebaseFunctions? functions})
      : _customFunctions = functions;
  final FirebaseFunctions? _customFunctions;

  FirebaseFunctions get _functions =>
      _customFunctions ?? FirebaseFunctions.instanceFor(region: 'europe-west1');

  /// Converte ricorsivamente Map<Object?, Object?> in Map<String, dynamic>
  /// — necessario perché Firebase restituisce il tipo raw del deserializzatore.
  static Map<String, dynamic> _toStringDynamic(dynamic raw) {
    if (raw is Map) {
      return raw.map(
        (k, v) => MapEntry(
          k.toString(),
          v is Map ? _toStringDynamic(v) : v,
        ),
      );
    }
    return {};
  }

  // ── Callable di lettura (invariate) ────────────────────────────────────────

  Future<List<Map<String, dynamic>>> searchSpecies(String query) async {
    try {
      final callable = _functions.httpsCallable('searchSpecies');
      final result = await callable.call<dynamic>({'query': query});

      final data = _toStringDynamic(result.data);
      final raw = data['results'];
      if (raw is List) {
        return raw
            .map((e) => e is Map ? _toStringDynamic(e) : <String, dynamic>{})
            .where((m) => m.isNotEmpty)
            .toList();
      }
      return [];
    } catch (e) {
      debugPrint('Errore durante searchSpecies su Cloud Functions: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getSpeciesDetail(String pid) async {
    try {
      final callable = _functions.httpsCallable('getSpeciesDetail');
      final result = await callable.call<dynamic>({'pid': pid});

      return _toStringDynamic(result.data);
    } catch (e) {
      debugPrint('Errore durante getSpeciesDetail su Cloud Functions: $e');
      return null;
    }
  }

  // ── Callable di scrittura (nuove — Feature 1) ──────────────────────────────

  /// Contribuisce una nuova specie al profilo OPB condiviso.
  ///
  /// Ritorna la risposta grezza della callable; la mappatura in
  /// [OpbContributionResult] è responsabilità di [OpbContributionRepository].
  ///
  /// Lancia [FirebaseFunctionsException] in caso di errore di rete o Firebase.
  Future<Map<String, dynamic>> contributeSpecies(
    Map<String, dynamic> payload,
  ) async {
    final callable = _functions.httpsCallable('contributeSpecies');
    final result = await callable.call<dynamic>(payload);
    return _toStringDynamic(result.data);
  }

  /// Aggiorna (o clona+aggiorna) una specie nel profilo OPB condiviso.
  ///
  /// [pid] deve essere il pid lowercase della specie.
  /// [partialPayload] deve contenere almeno un attributo oltre al pid.
  ///
  /// Lancia [FirebaseFunctionsException] in caso di errore di rete o Firebase.
  Future<Map<String, dynamic>> updateSpecies(
    String pid,
    Map<String, dynamic> partialPayload,
  ) async {
    final callable = _functions.httpsCallable('updateSpecies');
    final result = await callable.call<dynamic>({
      'pid': pid,
      ...partialPayload,
    });
    return _toStringDynamic(result.data);
  }
}
