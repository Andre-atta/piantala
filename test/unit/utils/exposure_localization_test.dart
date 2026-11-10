import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/utils/exposure_localization.dart';
import 'package:piantala/l10n/app_localizations.dart';

void main() {
  test('uses the same localized compass mapping as the rooms list', () async {
    final italian = await AppLocalizations.delegate.load(const Locale('it'));
    final english = await AppLocalizations.delegate.load(const Locale('en'));

    expect(localizedExposure('N', italian), italian.exposureNorth);
    expect(localizedExposure('SOUTH', italian), italian.exposureSouth);
    expect(localizedExposure('E', english), english.exposureEast);
    expect(localizedExposure('OVEST', italian), italian.exposureWest);
    expect(localizedExposure('UNKNOWN', english), english.exposureUnknown);
    expect(localizedExposure('east', null), 'east');
  });
}
