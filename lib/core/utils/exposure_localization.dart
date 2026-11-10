import 'package:piantala/l10n/app_localizations.dart';

String localizedExposure(
  String exposure,
  AppLocalizations? localizations,
) {
  if (localizations == null) return exposure;
  return switch (exposure.toUpperCase()) {
    'NORTH' || 'NORD' || 'N' || 'NE' || 'NW' => localizations.exposureNorth,
    'SOUTH' || 'SUD' || 'S' || 'SE' || 'SW' => localizations.exposureSouth,
    'EAST' || 'EST' || 'E' => localizations.exposureEast,
    'WEST' || 'OVEST' || 'W' => localizations.exposureWest,
    _ => localizations.exposureUnknown,
  };
}
