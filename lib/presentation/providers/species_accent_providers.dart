import 'package:flutter/material.dart';
import 'package:piantala/core/catalogs/species_accent_catalog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'species_accent_providers.g.dart';

/// Restituisce il colore d'accento per una data specie (slug scientifico).
///
/// Il widget legge questo provider — MAI il catalogo direttamente.
/// Se la specie non è nel catalogo, restituisce `null`.
@riverpod
Color? speciesAccentColor(SpeciesAccentColorRef ref, String speciesSlug) {
  return SpeciesAccentCatalog.forSlug(speciesSlug);
}
