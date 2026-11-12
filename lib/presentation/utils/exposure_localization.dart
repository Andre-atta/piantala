import 'package:piantala/l10n/app_localizations.dart';

String localizedExposure(
  String exposure,
  AppLocalizations? localizations,
) {
  if (localizations == null) return exposure;
  return switch (exposure.toUpperCase()) {
    'NORTH' || 'NORD' || 'N' => localizations.exposureNorth,
    'NE' => localizations.exposureNorthEast,
    'SE' => localizations.exposureSouthEast,
    'SW' => localizations.exposureSouthWest,
    'NW' => localizations.exposureNorthWest,
    'SOUTH' || 'SUD' || 'S' => localizations.exposureSouth,
    'EAST' || 'EST' || 'E' => localizations.exposureEast,
    'WEST' || 'OVEST' || 'W' => localizations.exposureWest,
    _ => localizations.exposureUnknown,
  };
}
