import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/presentation/widgets/common/navigation_metrics.dart';

abstract class RoomPaperCardMetrics {
  static const listHorizontalPadding = 16.0;
  static const listTopPadding = 60.0;
  static const listCardSpacing = 26.0;
  static const listBottomPadding = NavigationMetrics.barHeight + AppSpacing.xl;
  static const minimumCardHeight = 112.0;
  static const cardPadding = EdgeInsets.fromLTRB(16, 20, 14, 10);
  static const cardRotationCream = -1.1;
  static const cardRotationPaperTan = 1.0;
  static const cardRotationPaper = -0.6;
  static const roomDiscSize = 60.0;
  static const roomDiscStroke = 1.2;
  static const roomIconSize = 26.0;
  static const nameFontSize = 34.0;
  static const metadataFontSize = 13.0;
  static const metadataGap = 6.0;
  static const contentGap = 12.0;
  static const optionsWidth = 52.0;
  static const optionsHeight = 56.0;
  static const optionsRadius = 21.0;
  static const optionsOutlineWidth = 1.5;
  static const optionsShadowOffset = 4.0;
  static const optionsLightRadius = 5.0;
  static const optionsLightOpacity = 0.25;
  static const optionsDotRadius = 2.0;
  static const optionsDotSpacing = 3.0;
  static const optionsPressOffset = 2.0;
  static const optionsPressMilliseconds = 120;
  static const optionsDialogTop = 84.0;
  static const optionsDialogHorizontalMargin = 20.0;
  static const optionsDialogMaxWidth = 360.0;
  static const optionsDialogTitleFontSize = 34.0;
  static const optionsDialogRowHeight = 52.0;
  static const emptySheetMaxWidth = 360.0;
  static const emptyTitleFontSize = 34.0;
  static const loadingDotSize = 8.0;
  static const loadingDotSpacing = 8.0;
  static const loadingAnimationMilliseconds = 900;
}
