import 'package:flutter/material.dart';

/// Torn-edge coordinates use a 360 dp reference width; vertical values stay dp.
const kTornEdgePoints = <Offset>[
  Offset.zero,
  Offset(0, 4),
  Offset(14, 8),
  Offset(28, 3),
  Offset(42, 7),
  Offset(56, 5),
  Offset(70, 8),
  Offset(84, 4),
  Offset(98, 6),
  Offset(112, 4),
  Offset(126, 8),
  Offset(140, 3),
  Offset(154, 7),
  Offset(168, 5),
  Offset(182, 8),
  Offset(196, 4),
  Offset(210, 6),
  Offset(224, 4),
  Offset(238, 8),
  Offset(252, 3),
  Offset(266, 7),
  Offset(280, 5),
  Offset(294, 8),
  Offset(308, 4),
  Offset(322, 6),
  Offset(336, 4),
  Offset(350, 8),
  Offset(360, 0),
];

abstract class PaperComponentMetrics {
  static const tornReferenceWidth = 360.0;
  static const defaultSheetRotationDegrees = 0.0;
  static const minimumRotationDegrees = -1.5;
  static const maximumRotationDegrees = 1.5;
  static const tornBandHeight = 9.0;
  static const decorationTopInset = 9.0;
  static const ruledOpacity = 0.35;
  static const dialogBarrierOpacity = 0.68;
  static const tapeWidth = 56.0;
  static const tapeHeight = 18.0;
  static const tapeRotationDegrees = -3.0;
  static const pinDiameter = 14.0;
  static const pinProtrusion = 6.0;
  static const ruledSpacing = 24.0;
  static const defaultSheetPadding = EdgeInsets.fromLTRB(22, 26, 22, 8);

  static const tagWidth = 112.0;
  static const tagHeight = 72.0;
  static const tagWireStart = Offset(56, 6);
  static const tagWireEnd = Offset(56, 22);
  static const tagPinCenter = Offset(56, 5);
  static const tagHoleCenter = Offset(56, 29);
  static const tagBodyTop = 22.0;
  static const tagBodyBottom = 70.0;
  static const tagBodyLeft = 14.0;
  static const tagBodyRightInset = 1.5;
  static const tagNotchX = 1.5;
  static const tagNotchTop = 34.0;
  static const tagNotchTipY = 57.0;
  static const tagLabelLeft = 14.0;
  static const tagLabelRight = 8.0;
  static const tagLabelMirroredLeft = 8.0;
  static const tagLabelMirroredRight = 14.0;
  static const tagLabelTop = 30.0;
  static const tagLabelHeight = 40.0;
  static const tagWireWidth = 2.0;
  static const tagPinRadius = 4.2;
  static const tagPinStroke = 1.3;
  static const tagOutlineWidth = 1.5;
  static const tagHoleRadius = 2.6;
  static const tagHoleStroke = 1.1;
  static const tagPressedRotationDegrees = 1.2;
  static const tagFontSize = 12.0;
  static const tagLetterSpacing = 1.2;
  static const disabledDashLength = 4.0;
  static const disabledDashGap = 3.0;
  static const disabledFillOpacity = 0.5;
  static const disabledInkOpacity = 0.45;

  static const dialogHorizontalMargin = 20.0;
  static const dialogTopInset = 84.0;
  static const dialogSheetRotationDegrees = -0.8;
  static const dialogActionOverlap = 8.0;
  static const dialogActionSpacing = 16.0;
  static const dialogMinimumSheetHeight = 180.0;
  static const dialogTitleFontSize = 38.0;
  static const dialogFadeMilliseconds = 150;
  static const rotationAssertionMessage =
      'rotationDegrees must be between -1.5 and 1.5 degrees';
  static const actionCountAssertionMessage =
      'Paper dialogs require one or two actions';
}
