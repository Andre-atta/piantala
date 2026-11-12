import 'package:flutter/material.dart';

/// Palette e tipografia della nuova direzione artistica.
@immutable
class PiantalaTheme extends ThemeExtension<PiantalaTheme> {
  const PiantalaTheme({
    required this.leafGreen,
    required this.deepGreen,
    required this.sproutGreen,
    required this.sage,
    required this.terracotta,
    required this.paper,
    required this.paperTan,
    required this.cream,
    required this.ink,
    required this.softInk,
    required this.meterTrack,
    required this.postIt,
    required this.floor,
    required this.floorBorder,
    required this.windowWood,
    required this.darkWood,
    required this.stickWoodAndReserveWall,
    required this.skyDay,
    required this.skyDawn,
    required this.skyDusk,
    required this.skyEvening,
    required this.skyNight,
    required this.h1,
    required this.h2,
    required this.body,
    required this.label,
  });

  static const standard = PiantalaTheme(
    leafGreen: Color(0xFF588157),
    deepGreen: Color(0xFF344E41),
    sproutGreen: Color(0xFFCDE7B0),
    sage: Color(0xFFA3B18A),
    terracotta: Color(0xFFBE6E46),
    paper: Color(0xFFF4EBD8),
    paperTan: Color(0xFFE8DABB),
    cream: Color(0xFFFAF7EF),
    ink: Color(0xFF292D25),
    softInk: Color(0xFF3A3E34),
    meterTrack: Color(0xFFE6DAC0),
    postIt: Color(0xFFEFD27A),
    floor: Color(0xFFC9A678),
    floorBorder: Color(0xFFA67C52),
    windowWood: Color(0xFF8A5535),
    darkWood: Color(0xFF5E3820),
    stickWoodAndReserveWall: Color(0xFFE8DABB),
    skyDay: Color(0xFFFBF1D3),
    skyDawn: Color(0xFFFDDDA0),
    skyDusk: Color(0xFFF6C67A),
    skyEvening: Color(0xFF3A4C66),
    skyNight: Color(0xFF2B3A52),
    h1: TextStyle(
      fontFamily: 'Sue Ellen Francisco',
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: Color(0xFF344E41),
    ),
    h2: TextStyle(
      fontFamily: 'Barriecito',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A3E34),
    ),
    body: TextStyle(
      fontFamily: 'Delius',
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: Color(0xFF292D25),
    ),
    label: TextStyle(
      fontFamily: 'Delius',
      fontSize: 11,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      color: Color(0xFF3A3E34),
    ),
  );

  final Color leafGreen;
  final Color deepGreen;
  final Color sproutGreen;
  final Color sage;
  final Color terracotta;
  final Color paper;
  final Color paperTan;
  final Color cream;
  final Color ink;
  final Color softInk;
  final Color meterTrack;
  final Color postIt;
  final Color floor;
  final Color floorBorder;
  final Color windowWood;
  final Color darkWood;
  final Color stickWoodAndReserveWall;
  final Color skyDay;
  final Color skyDawn;
  final Color skyDusk;
  final Color skyEvening;
  final Color skyNight;
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle body;
  final TextStyle label;

  @override
  PiantalaTheme copyWith({
    Color? leafGreen,
    Color? deepGreen,
    Color? sproutGreen,
    Color? sage,
    Color? terracotta,
    Color? paper,
    Color? paperTan,
    Color? cream,
    Color? ink,
    Color? softInk,
    Color? meterTrack,
    Color? postIt,
    Color? floor,
    Color? floorBorder,
    Color? windowWood,
    Color? darkWood,
    Color? stickWoodAndReserveWall,
    Color? skyDay,
    Color? skyDawn,
    Color? skyDusk,
    Color? skyEvening,
    Color? skyNight,
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? body,
    TextStyle? label,
  }) {
    return PiantalaTheme(
      leafGreen: leafGreen ?? this.leafGreen,
      deepGreen: deepGreen ?? this.deepGreen,
      sproutGreen: sproutGreen ?? this.sproutGreen,
      sage: sage ?? this.sage,
      terracotta: terracotta ?? this.terracotta,
      paper: paper ?? this.paper,
      paperTan: paperTan ?? this.paperTan,
      cream: cream ?? this.cream,
      ink: ink ?? this.ink,
      softInk: softInk ?? this.softInk,
      meterTrack: meterTrack ?? this.meterTrack,
      postIt: postIt ?? this.postIt,
      floor: floor ?? this.floor,
      floorBorder: floorBorder ?? this.floorBorder,
      windowWood: windowWood ?? this.windowWood,
      darkWood: darkWood ?? this.darkWood,
      stickWoodAndReserveWall:
          stickWoodAndReserveWall ?? this.stickWoodAndReserveWall,
      skyDay: skyDay ?? this.skyDay,
      skyDawn: skyDawn ?? this.skyDawn,
      skyDusk: skyDusk ?? this.skyDusk,
      skyEvening: skyEvening ?? this.skyEvening,
      skyNight: skyNight ?? this.skyNight,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      body: body ?? this.body,
      label: label ?? this.label,
    );
  }

  @override
  PiantalaTheme lerp(covariant PiantalaTheme other, double t) {
    return PiantalaTheme(
      leafGreen: Color.lerp(leafGreen, other.leafGreen, t)!,
      deepGreen: Color.lerp(deepGreen, other.deepGreen, t)!,
      sproutGreen: Color.lerp(sproutGreen, other.sproutGreen, t)!,
      sage: Color.lerp(sage, other.sage, t)!,
      terracotta: Color.lerp(terracotta, other.terracotta, t)!,
      paper: Color.lerp(paper, other.paper, t)!,
      paperTan: Color.lerp(paperTan, other.paperTan, t)!,
      cream: Color.lerp(cream, other.cream, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      softInk: Color.lerp(softInk, other.softInk, t)!,
      meterTrack: Color.lerp(meterTrack, other.meterTrack, t)!,
      postIt: Color.lerp(postIt, other.postIt, t)!,
      floor: Color.lerp(floor, other.floor, t)!,
      floorBorder: Color.lerp(floorBorder, other.floorBorder, t)!,
      windowWood: Color.lerp(windowWood, other.windowWood, t)!,
      darkWood: Color.lerp(darkWood, other.darkWood, t)!,
      stickWoodAndReserveWall: Color.lerp(
        stickWoodAndReserveWall,
        other.stickWoodAndReserveWall,
        t,
      )!,
      skyDay: Color.lerp(skyDay, other.skyDay, t)!,
      skyDawn: Color.lerp(skyDawn, other.skyDawn, t)!,
      skyDusk: Color.lerp(skyDusk, other.skyDusk, t)!,
      skyEvening: Color.lerp(skyEvening, other.skyEvening, t)!,
      skyNight: Color.lerp(skyNight, other.skyNight, t)!,
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      label: TextStyle.lerp(label, other.label, t)!,
    );
  }
}
