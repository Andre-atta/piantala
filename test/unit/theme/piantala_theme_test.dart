import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/core/theme/temporal_theme.dart';

void main() {
  group('PiantalaTheme.copyWith', () {
    test('sostituisce i campi richiesti e conserva gli altri', () {
      const replacementColor = Color(0xFF112233);
      const replacementStyle = TextStyle(fontSize: 20);
      final copied = PiantalaTheme.standard.copyWith(
        leafGreen: replacementColor,
        h1: replacementStyle,
      );

      expect(copied.leafGreen, replacementColor);
      expect(copied.deepGreen, PiantalaTheme.standard.deepGreen);
      expect(copied.h1, replacementStyle);
      expect(copied.h2, PiantalaTheme.standard.h2);
      expect(copied.body, PiantalaTheme.standard.body);
      expect(copied.label, PiantalaTheme.standard.label);
    });
  });

  group('PiantalaTheme.lerp', () {
    test('interpola tutti i colori e gli stili', () {
      const start = PiantalaTheme.standard;
      const replacementColor = Color(0xFF112233);
      const replacementStyle = TextStyle(fontSize: 20);
      final end = start.copyWith(
        leafGreen: replacementColor,
        deepGreen: replacementColor,
        sproutGreen: replacementColor,
        sage: replacementColor,
        terracotta: replacementColor,
        paper: replacementColor,
        cream: replacementColor,
        ink: replacementColor,
        softInk: replacementColor,
        meterTrack: replacementColor,
        postIt: replacementColor,
        floor: replacementColor,
        floorBorder: replacementColor,
        windowWood: replacementColor,
        darkWood: replacementColor,
        dayGlass: replacementColor,
        dawnGlass: replacementColor,
        sun: replacementColor,
        stickWoodAndReserveWall: replacementColor,
        skyDay: replacementColor,
        skyDawn: replacementColor,
        skyDusk: replacementColor,
        skyEvening: replacementColor,
        skyNight: replacementColor,
        h1: replacementStyle,
        h2: replacementStyle,
        body: replacementStyle,
        label: replacementStyle,
      );

      final halfway = start.lerp(end, 0.5);
      final startColors = [
        start.leafGreen,
        start.deepGreen,
        start.sproutGreen,
        start.sage,
        start.terracotta,
        start.paper,
        start.cream,
        start.ink,
        start.softInk,
        start.meterTrack,
        start.postIt,
        start.floor,
        start.floorBorder,
        start.windowWood,
        start.darkWood,
        start.dayGlass,
        start.dawnGlass,
        start.sun,
        start.stickWoodAndReserveWall,
        start.skyDay,
        start.skyDawn,
        start.skyDusk,
        start.skyEvening,
        start.skyNight,
      ];
      final halfwayColors = [
        halfway.leafGreen,
        halfway.deepGreen,
        halfway.sproutGreen,
        halfway.sage,
        halfway.terracotta,
        halfway.paper,
        halfway.cream,
        halfway.ink,
        halfway.softInk,
        halfway.meterTrack,
        halfway.postIt,
        halfway.floor,
        halfway.floorBorder,
        halfway.windowWood,
        halfway.darkWood,
        halfway.dayGlass,
        halfway.dawnGlass,
        halfway.sun,
        halfway.stickWoodAndReserveWall,
        halfway.skyDay,
        halfway.skyDawn,
        halfway.skyDusk,
        halfway.skyEvening,
        halfway.skyNight,
      ];
      for (var index = 0; index < startColors.length; index++) {
        expect(
          halfwayColors[index],
          Color.lerp(startColors[index], replacementColor, 0.5),
        );
      }

      expect(halfway.h1.fontSize, 26);
      expect(halfway.h2.fontSize, 16.5);
      expect(halfway.body.fontSize, 16.5);
      expect(halfway.label.fontSize, 15.5);
    });
  });

  test('tutti i cinque temi temporali espongono la stessa estensione', () {
    for (final period in TemporalPeriod.values) {
      expect(
        TemporalTheme.buildTheme(period).extension<PiantalaTheme>(),
        PiantalaTheme.standard,
      );
    }
  });
}
