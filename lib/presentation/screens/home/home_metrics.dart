import 'dart:math' as math;

abstract class HomeMetrics {
  static const headerHeight = 116.0;
  static const headerRoomNameSize = 46.0;
  static const headerRoomNameHeight = 48.0;
  static const headerMetaFontSize = 13.0;
  static const headerMetaLineHeight = 18.0;
  static const nextRoomNameSize = 28.0;
  static const nextRoomOpacity = 0.6;
  static const nextRoomWidth = 96.0;
  static const windowWidth = 64.0;
  static const windowHeight = 74.0;
  static const windowRight = 22.0;
  static const windowTop = 36.0;
  static const windowSunSize = 30.0;
  static const windowSunLeft = 40.0;
  static const windowSunTop = 6.0;
  static const windowViewBoxWidth = 76.0;
  static const windowViewBoxHeight = 88.0;
  static const windowGlassLeft = 3.0;
  static const windowGlassTop = 3.0;
  static const windowGlassWidth = 70.0;
  static const windowGlassHeight = 72.0;
  static const headerWindowReserveWidth = 86.0;
  static const pageIndicatorActiveWidth = 20.0;
  static const pageIndicatorInactiveWidth = 5.0;
  static const pageIndicatorHeight = 5.0;
  static const pageIndicatorTouchSize = 48.0;
  static const pageIndicatorGap = 6.0;
  static const pageIndicatorOverflow = 16.0;
  static const pageTransitionMilliseconds = 180;

  static const floorHeight = 72.0;
  static const floorBorderHeight = 8.0;
  static const floorJointSpacing = 72.0;

  static const cabinetSideMargin = 8.0;
  static const cabinetCrossbarHeight = 10.0;
  static const cabinetCrossbarOverhang = 4.0;
  static const cabinetPostWidth = 10.0;
  static const cabinetBottomCrossbarHeight = 12.0;
  static const cabinetFootWidth = 26.0;
  static const cabinetFootHeight = 8.0;
  static const cabinetFootInset = 12.0;
  static const shelfRowHeight = 138.0;
  static const shelfPlantZoneHeight = 116.0;
  static const shelfBoardHeight = 22.0;
  static const shelfOverlap = 3.0;
  static const shelfBoardBorderWidth = 1.5;
  static const plantsPerRow = 3;
  static const plantImageWidth = 96.0;
  static const plantImageHeight = 100.0;
  static const plantTagBottomGap = 5.0;
  static const plantTagHeight = 17.0;
  static const plantTagHorizontalPadding = 8.0;
  static const plantTagMaxWidth = 100.0;
  static const plantTagFontSize = 11.0;
  static const plantVariationMinScale = 0.95;
  static const plantVariationMaxScale = 1.05;
  static const plantVariationMaxRotationDegrees = 1.5;

  static const careSignalSize = 44.0;
  static const careSignalWateringLeft = 0.0;
  static const careSignalWateringTop = 0.0;
  static const careSignalFertilizingRight = 0.0;
  static const careSignalFertilizingTop = 2.0;

  static const degreesToRadians = math.pi / 180;
  static const vineWidth = 40.0;
  static const vineHeight = 200.0;
  static const vineRight = -14.0;
  static const vineTop = 8.0;
  static const booksWidth = 68.0;
  static const booksHeight = 84.0;
}
