import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class LocalCatalogService {
  List<Map<String, dynamic>>? _catalog;

  Future<void> _loadCatalog() async {
    if (_catalog != null) return;
    try {
      final jsonString =
          await rootBundle.loadString('assets/data/plants_catalog.json');
      final jsonList = json.decode(jsonString) as List<dynamic>;
      _catalog = List<Map<String, dynamic>>.from(jsonList);
    } catch (e) {
      debugPrint('Errore durante il caricamento del catalogo locale: $e');
      _catalog = [];
    }
  }

  Future<List<Map<String, dynamic>>> searchSpecies(
    String query,
    String locale,
  ) async {
    await _loadCatalog();
    if (_catalog == null || _catalog!.isEmpty) return [];

    final q = query.toLowerCase().trim();
    if (q.isEmpty) return [];

    return _catalog!.where((plant) {
      final pid = (plant['pid'] as String?)?.toLowerCase() ?? '';
      final scientificName =
          (plant['scientificName'] as String?)?.toLowerCase() ?? '';

      final commonNameMap = plant['commonName'] as Map<String, dynamic>?;

      final commonNameIt =
          (commonNameMap?['it'] as String?)?.toLowerCase() ?? '';
      final commonNameEn =
          (commonNameMap?['en'] as String?)?.toLowerCase() ?? '';

      return pid.contains(q) ||
          scientificName.contains(q) ||
          commonNameIt.contains(q) ||
          commonNameEn.contains(q);
    }).toList();
  }

  Future<Map<String, dynamic>?> getSpeciesDetail(String pid) async {
    await _loadCatalog();
    if (_catalog == null || _catalog!.isEmpty) return null;

    try {
      return _catalog!.firstWhere(
        (plant) => plant['pid'] == pid,
      );
    } catch (e) {
      // firstWhere throws StateError if not found
      return null;
    }
  }
}
