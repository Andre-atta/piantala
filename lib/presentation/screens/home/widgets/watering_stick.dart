import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';

class WateringStick extends StatelessWidget {
  const WateringStick({
    required this.dueDate,
    super.key,
  });

  static const _asset = 'assets/svg/home/watering_stick.svg';

  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formattedDate = DateFormat.MMMd(locale).format(dueDate);

    return ExcludeSemantics(
      child: SizedBox(
        width: HomeMetrics.wateringStickWidth,
        height: HomeMetrics.wateringStickHeight,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SvgPicture.asset(
              _asset,
              width: HomeMetrics.wateringStickWidth,
              height: HomeMetrics.wateringStickHeight,
            ),
            Positioned(
              top: HomeMetrics.wateringStickDateTop,
              left: 0,
              right: 0,
              height: HomeMetrics.wateringStickDateFontSize,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formattedDate,
                  maxLines: 1,
                  style: theme.body.copyWith(
                    fontSize: HomeMetrics.wateringStickDateFontSize,
                    color: theme.cream,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
