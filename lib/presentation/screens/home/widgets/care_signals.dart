import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/home/care_type.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';

typedef _CareSignalPresentation = ({
  String asset,
  Alignment alignment,
  String semanticsLabel,
});

Map<CareType, _CareSignalPresentation> _careSignalPresentations(
  AppLocalizations localizations,
) =>
    {
      CareType.watering: (
        asset: 'assets/svg/home/care_watering_can.svg',
        alignment: Alignment.topLeft,
        semanticsLabel: localizations.homeCareWateringSemantics,
      ),
      CareType.fertilizing: (
        asset: 'assets/svg/home/care_fertilizer_bag.svg',
        alignment: Alignment.topRight,
        semanticsLabel: localizations.homeCareFertilizingSemantics,
      ),
    };

String careSemanticsValue(
  List<CareType> cares,
  AppLocalizations localizations,
) {
  final presentations = _careSignalPresentations(localizations);
  return cares.map((care) => presentations[care]!.semanticsLabel).join(', ');
}

class CareSignals extends StatelessWidget {
  const CareSignals({
    required this.cares,
    super.key,
  });

  final List<CareType> cares;

  @override
  Widget build(BuildContext context) {
    final presentations =
        _careSignalPresentations(AppLocalizations.of(context)!);

    return ExcludeSemantics(
      child: IgnorePointer(
        child: SizedBox(
          width: HomeMetrics.plantImageWidth,
          height: HomeMetrics.plantImageHeight,
          child: Stack(
            children: [
              for (final care in cares)
                _buildSignal(care, presentations[care]!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignal(
    CareType care,
    _CareSignalPresentation presentation,
  ) {
    final isWatering = presentation.alignment == Alignment.topLeft;
    return Positioned(
      left: isWatering ? HomeMetrics.careSignalWateringLeft : null,
      right: isWatering ? null : HomeMetrics.careSignalFertilizingRight,
      top: isWatering
          ? HomeMetrics.careSignalWateringTop
          : HomeMetrics.careSignalFertilizingTop,
      child: SvgPicture.asset(
        presentation.asset,
        key: ValueKey('care-signal-${care.name}'),
        width: HomeMetrics.careSignalSize,
        height: HomeMetrics.careSignalSize,
      ),
    );
  }
}
