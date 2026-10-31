import 'package:flutter/material.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/app_typography.dart';

/// I cinque periodi temporali della giornata.
enum TemporalPeriod {
  night, // 00–05
  dawn, // 06–08
  day, // 09–17
  dusk, // 18–20
  evening, // 21–23
}

extension TemporalPeriodX on TemporalPeriod {
  String get greeting => switch (this) {
        TemporalPeriod.night => 'Buonanotte',
        TemporalPeriod.dawn => 'Buongiorno',
        TemporalPeriod.day => 'Ciao',
        TemporalPeriod.dusk => 'Buon pomeriggio',
        TemporalPeriod.evening => 'Buonasera',
      };

  String get icon => switch (this) {
        TemporalPeriod.night => '🌙',
        TemporalPeriod.dawn => '🌅',
        TemporalPeriod.day => '☀️',
        TemporalPeriod.dusk => '🌇',
        TemporalPeriod.evening => '🌆',
      };

  /// Restituisce il periodo corretto per un'ora data (0–23).
  static TemporalPeriod fromHour(int hour) => switch (hour) {
        >= 0 && < 6 => TemporalPeriod.night,
        >= 6 && < 9 => TemporalPeriod.dawn,
        >= 9 && < 18 => TemporalPeriod.day,
        >= 18 && < 21 => TemporalPeriod.dusk,
        _ => TemporalPeriod.evening,
      };
}

/// Costruisce il ThemeData completo per ciascun periodo temporale.
abstract class TemporalTheme {
  static ThemeData buildTheme(TemporalPeriod period) => switch (period) {
        TemporalPeriod.night => _night,
        TemporalPeriod.dawn => _dawn,
        TemporalPeriod.day => _day,
        TemporalPeriod.dusk => _dusk,
        TemporalPeriod.evening => _evening,
      };

  // ── DAY (tema di riferimento) ───────────────────────────────
  static final _day = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.plantGreen,
      surface: AppColors.daySurface,
      onSurface: AppColors.dayText,
    ).copyWith(
      primary: AppColors.plantGreen,
      secondary: AppColors.plantGreenLight,
      surface: AppColors.daySurface,
      onSurface: AppColors.dayText,
    ),
    scaffoldBackgroundColor: AppColors.dayBackground,
    textTheme: AppTypography.textTheme(AppColors.dayText),
    appBarTheme: _appBarTheme(AppColors.dayBackground, AppColors.dayText),
  );

  // ── DAWN ────────────────────────────────────────────────────
  static final _dawn = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.dawnAccent,
    ).copyWith(
      primary: AppColors.dawnAccent,
      surface: AppColors.dawnSurface,
      onSurface: AppColors.dawnText,
    ),
    scaffoldBackgroundColor: AppColors.dawnBackground,
    textTheme: AppTypography.textTheme(AppColors.dawnText),
    appBarTheme: _appBarTheme(AppColors.dawnBackground, AppColors.dawnText),
  );

  // ── DUSK ────────────────────────────────────────────────────
  static final _dusk = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.duskAccent,
    ).copyWith(
      primary: AppColors.duskAccent,
      surface: AppColors.duskSurface,
      onSurface: AppColors.duskText,
    ),
    scaffoldBackgroundColor: AppColors.duskBackground,
    textTheme: AppTypography.textTheme(AppColors.duskText),
    appBarTheme: _appBarTheme(AppColors.duskBackground, AppColors.duskText),
  );

  // ── EVENING ─────────────────────────────────────────────────
  static final _evening = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.eveningAccent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.eveningAccent,
      surface: AppColors.eveningSurface,
      onSurface: AppColors.eveningText,
    ),
    scaffoldBackgroundColor: AppColors.eveningBackground,
    textTheme: AppTypography.textTheme(AppColors.eveningText),
    appBarTheme:
        _appBarTheme(AppColors.eveningBackground, AppColors.eveningText),
  );

  // ── NIGHT ───────────────────────────────────────────────────
  static final _night = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.nightAccent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: AppColors.nightAccent,
      surface: AppColors.nightSurface,
      onSurface: AppColors.nightText,
    ),
    scaffoldBackgroundColor: AppColors.nightBackground,
    textTheme: AppTypography.textTheme(AppColors.nightText),
    appBarTheme: _appBarTheme(AppColors.nightBackground, AppColors.nightText),
  );

  // ── Helpers ─────────────────────────────────────────────────

  static AppBarTheme _appBarTheme(Color bg, Color fg) => AppBarTheme(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'DMSerifDisplay',
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: fg,
        ),
      );
}
