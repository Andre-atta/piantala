import 'dart:math' as math;

abstract class ProfileMetrics {
  static const double degreesToRadians = math.pi / 180;

  static const double screenHorizontalPadding = 12.0;
  static const double screenTopPadding = 4.0;
  static const double screenBottomPadding = 8.0;

  static const double cordAreaHeight = 20.0;
  static const double cordPinRadius = 4.5;
  static const double cordPinTopOffset = 5.0;
  static const double cordAnchorInset = 42.0;
  static const double cordStrokeWidth = 1.5;

  static const double frameBorderWidth = 10.0;
  static const double frameDepthWidth = 3.0;
  static const double frameDropShadowOffset = 3.5;
  static const double frameDropShadowOpacity = 0.22;
  static const double itemDropShadowOffset = 2.5;
  static const double itemDropShadowOpacity = 0.20;
  static const double pinHighlightRadius = 1.6;
  static const double pinHighlightOffset = -1.6;
  static const double pinHighlightOpacity = 0.72;
  static const double frameRadius = 8.0;
  static const double frameInnerRadius = 2.0;
  static const double boardPadding = 10.0;
  static const double sectionGap = 10.0;
  static const double rowGap = 10.0;

  static const double corkSpeckSpacing = 22.0;
  static const double corkSpeckRadius = 1.0;
  static const double corkSpeckLargeRadius = 1.8;
  static const double corkSpeckOpacity = 0.24;
  static const double corkInnerShadowWidth = 4.0;
  static const double corkInnerShadowOpacity = 0.22;

  static const double sketchCornerOverhang = 3.5;

  static const double polaroidRotationDegrees = -1.3;
  static const double polaroidPadding = 8.0;
  static const double polaroidBottomPadding = 8.0;
  static const double polaroidPhotoInset = 6.0;
  static const double polaroidAvatarSize = 74.0;
  static const double polaroidNameSpacing = 4.0;
  static const double polaroidNameFontSize = 20.0;
  static const double polaroidMinTouchTarget = 34.0;
  static const int avatarMaxDimensionPx = 512;
  static const int avatarImageQuality = 85;

  static const double postItRotationDegrees = 1.2;
  static const double postItPadding = 10.0;
  static const double postItPinRadius = 5.5;
  static const double postItPinOffset = -4.0;
  static const double postItCurlSize = 12.0;
  static const double postItTitleFontSize = 13.0;
  static const double postItTimeFontSize = 28.0;
  static const double postItSubtitleFontSize = 11.0;

  static const double mapHeight = 106.0;
  static const double mapPinInset = 10.0;
  static const double mapPinRadius = 5.0;
  static const double mapFoldOpacity = 0.14;
  static const double mapCompassRadius = 12.0;
  static const double mapCompassRightOffset = 22.0;
  static const double mapCompassTopOffset = 26.0;
  static const double mapPillHorizontalPadding = 10.0;
  static const double mapPillVerticalPadding = 6.0;
  static const double mapPillFontSize = 13.0;
  static const double mapPillDotSize = 7.0;
  static const double mapPillGap = 5.0;
  static const double mapPillRightOffset = 26.0;
  static const double mapPillTopOffset = 34.0;
  static const double mapGridOpacity = 0.18;
  static const double mapRouteDash = 3.5;
  static const double mapRouteGap = 3.5;

  static const double permissionsCardPadding = 10.0;
  static const double permissionsTitleFontSize = 20.0;
  static const double permissionsRowSpacing = 5.0;
  static const double permissionsDiscSize = 19.0;
  static const double permissionsDiscCheckSize = 12.0;
  static const double permissionsDashLength = 3.0;
  static const double permissionsDashGap = 2.4;
  static const double permissionsTitleRowGap = 6.0;
  static const double permissionsLabelFontSize = 12.0;
  static const double permissionsStatusFontSize = 11.0;

  static const double versionTagWidth = 86.0;
  static const double versionTagHeight = 68.0;
  static const double versionTagTopCut = 10.0;
  static const double versionTagHoleOffset = 14.0;
  static const double versionTagHoleRadius = 2.4;
  static const double versionTagPaddingTop = 18.0;
  static const double versionTagPinRadius = 5.0;
  static const double versionTagRotationDegrees = 2.0;
  static const double versionTagTitleFontSize = 11.0;
  static const double versionTagNumberFontSize = 15.0;

  static const double accountStripPaddingH = 12.0;
  static const double accountStripPaddingV = 7.0;
  static const double accountStripTitleFontSize = 11.0;
  static const double accountStripSubtitleFontSize = 13.0;
  static const double chevronSize = 16.0;

  static const double languageOptionFontSize = 30.0;
  static const double languageRowVerticalPadding = 10.0;
  static const double languageUnderlineWidth = 1.6;
  static const double dividerOpacity = 0.28;

  static const double wheelPickerHeight = 156.0;
  static const double wheelItemExtent = 42.0;
  static const double wheelColumnWidth = 74.0;
  static const double wheelSelectedFontSize = 32.0;
  static const double wheelUnselectedFontSize = 20.0;
  static const double wheelSeparatorFontSize = 28.0;
  static const double wheelUnselectedOpacity = 0.4;
  static const double wheelDividerWidth = 54.0;

  static const double permissionReasonFontSize = 13.0;
  static const double permissionDialogRowGap = 12.0;
  static const double permissionTitleDotGap = 6.0;

  static const int hoursInDay = 24;
  static const int minutesInHour = 60;
}
