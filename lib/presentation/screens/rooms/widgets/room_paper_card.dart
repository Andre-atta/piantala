import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_paper_card_metrics.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_pin_button.dart';
import 'package:piantala/presentation/utils/exposure_localization.dart';
import 'package:piantala/presentation/widgets/common/torn_paper_sheet.dart';

class RoomPaperCard extends StatelessWidget {
  const RoomPaperCard({
    required this.room,
    required this.plantCount,
    required this.onOptionsPressed,
    super.key,
  });

  final RoomEntity room;
  final int plantCount;
  final VoidCallback onOptionsPressed;

  static int appearanceIndexForRoomId(String roomId) {
    const fnvOffsetBasis = 0x811C9DC5;
    const fnvPrime = 0x01000193;
    const uint32Mask = 0xFFFFFFFF;
    var hash = fnvOffsetBasis;
    for (final codeUnit in roomId.codeUnits) {
      hash = ((hash ^ codeUnit) * fnvPrime) & uint32Mask;
    }
    return hash % 3;
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;
    final appearanceIndex = appearanceIndexForRoomId(room.id);
    final (paperColor, decoration, rotation) = switch (appearanceIndex) {
      0 => (
          TornPaperColor.cream,
          TornPaperDecoration.tape,
          RoomPaperCardMetrics.cardRotationCream,
        ),
      1 => (
          TornPaperColor.paperTan,
          TornPaperDecoration.pin,
          RoomPaperCardMetrics.cardRotationPaperTan,
        ),
      _ => (
          TornPaperColor.paper,
          TornPaperDecoration.tape,
          RoomPaperCardMetrics.cardRotationPaper,
        ),
    };
    final exposure = localizedExposure(room.exposure, l10n);

    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: RoomPaperCardMetrics.minimumCardHeight,
      ),
      child: TornPaperSheet(
        color: paperColor,
        decoration: decoration,
        ruled: appearanceIndex == 2,
        rotationDegrees: rotation,
        padding: RoomPaperCardMetrics.cardPadding,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: theme.sproutGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.deepGreen,
                  width: RoomPaperCardMetrics.roomDiscStroke,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.ink.withValues(alpha: 0.2),
                    offset: const Offset(0, AppSpacing.xs / 2),
                    blurRadius: AppSpacing.xs / 2,
                  ),
                ],
              ),
              child: SizedBox(
                width: RoomPaperCardMetrics.roomDiscSize,
                height: RoomPaperCardMetrics.roomDiscSize,
                child: Icon(
                  Icons.door_front_door_outlined,
                  size: RoomPaperCardMetrics.roomIconSize,
                  color: theme.deepGreen,
                ),
              ),
            ),
            const SizedBox(width: RoomPaperCardMetrics.contentGap),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.h1.copyWith(
                      color: theme.deepGreen,
                      fontSize: RoomPaperCardMetrics.nameFontSize,
                    ),
                  ),
                  const SizedBox(height: RoomPaperCardMetrics.metadataGap),
                  Text(
                    l10n.roomsExposure(exposure),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.body.copyWith(
                      color: theme.ink,
                      fontSize: RoomPaperCardMetrics.metadataFontSize,
                    ),
                  ),
                  Text(
                    l10n.roomsPlants(plantCount),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.body.copyWith(
                      color: theme.ink,
                      fontSize: RoomPaperCardMetrics.metadataFontSize,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: RoomPaperCardMetrics.contentGap),
            RoomPinButton(
              label: l10n.roomsOptionsSemantics(room.name),
              onPressed: onOptionsPressed,
              showOptionsDots: true,
            ),
          ],
        ),
      ),
    );
  }
}
