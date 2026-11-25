import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:piantala/core/theme/piantala_theme.dart';
import 'package:piantala/core/theme/temporal_theme.dart';

void main() {
  test('espone i token della mensola con i valori richiesti', () {
    expect(PiantalaTheme.standard.cabinetBack, const Color(0xFFE8DABB));
    expect(PiantalaTheme.standard.cabinetSide, const Color(0xFFD3C29A));
    expect(PiantalaTheme.standard.shelfTop, const Color(0xFFC5D1AE));
  });

  group('PiantalaTheme.copyWith', () {
    test('sostituisce i campi richiesti e conserva gli altri', () {
      const replacementColor = Color(0xFF112233);
      const replacementStyle = TextStyle(fontSize: 20);
      final copied = PiantalaTheme.standard.copyWith(
        leafGreen: replacementColor,
        paperTan: replacementColor,
        cabinetBack: replacementColor,
        cabinetSide: replacementColor,
        shelfTop: replacementColor,
        h1: replacementStyle,
      );

      expect(copied.leafGreen, replacementColor);
      expect(copied.deepGreen, PiantalaTheme.standard.deepGreen);
      expect(copied.paperTan, replacementColor);
      expect(copied.cabinetBack, replacementColor);
      expect(copied.cabinetSide, replacementColor);
      expect(copied.shelfTop, replacementColor);
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
        paperTan: replacementColor,
        cabinetBack: replacementColor,
        cabinetSide: replacementColor,
        shelfTop: replacementColor,
        cream: replacementColor,
        ink: replacementColor,
        softInk: replacementColor,
        meterTrack: replacementColor,
        postIt: replacementColor,
        floor: replacementColor,
        floorBorder: replacementColor,
        windowWood: replacementColor,
        darkWood: replacementColor,
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
        start.paperTan,
        start.cabinetBack,
        start.cabinetSide,
        start.shelfTop,
        start.cream,
        start.ink,
        start.softInk,
        start.meterTrack,
        start.postIt,
        start.floor,
        start.floorBorder,
        start.windowWood,
        start.darkWood,
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
        halfway.paperTan,
        halfway.cabinetBack,
        halfway.cabinetSide,
        halfway.shelfTop,
        halfway.cream,
        halfway.ink,
        halfway.softInk,
        halfway.meterTrack,
        halfway.postIt,
        halfway.floor,
        halfway.floorBorder,
        halfway.windowWood,
        halfway.darkWood,
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
