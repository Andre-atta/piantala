import 'package:flutter/material.dart';

/// Palette completa di Piantala.
/// REGOLA: nessun widget usa Color() o Colors.* direttamente.
/// Usare sempre queste costanti o Theme.of(context).colorScheme.*
abstract class AppColors {
  // ── Brand / Plant greens ──────────────────────────────────────
  static const plantGreen = Color(0xFF3A6B4A);
  static const plantGreenLight = Color(0xFF6B9E7A);
  static const plantGreenPale = Color(0xFFEBF3ED);

  // ── Neutrals (base chiara) ────────────────────────────────────
  static const canvas = Color(0xFFF7F4EF); // sfondo principale
  static const surface = Color(0xFFFFFFFF);
  static const surfaceVariant = Color(0xFFF0EDE6);
  static const border = Color(0xFFE8E2D9);
  static const textPrimary = Color(0xFF1A1814);
  static const textSecondary = Color(0xFF7A7166);
  static const textTertiary = Color(0xFFB0A89E);

  // ── Accenti funzionali ────────────────────────────────────────
  static const warning = Color(0xFFB85C1A);
  static const warningLight = Color(0xFFFDF0E6);
  static const error = Color(0xFF8B2E2E);
  static const errorLight = Color(0xFFFAEAEA);
  static const success = Color(0xFF2A6B3A);
  static const successLight = Color(0xFFE8F3EB);
  static const info = Color(0xFF2B4C7E);
  static const infoLight = Color(0xFFEBF0F9);

  // ── Temporal palette: NIGHT (00–05) ──────────────────────────
  static const nightBackground = Color(0xFF0D1B2A);
  static const nightSurface = Color(0xFF1A2D40);
  static const nightAccent = Color(0xFF4A7FA0);
  static const nightText = Color(0xFFD4E8F4);
  static const nightTextMuted = Color(0xFF7A9BB0);

  // ── Temporal palette: DAWN (06–08) ───────────────────────────
  static const dawnBackground = Color(0xFFFDF6F0);
  static const dawnSurface = Color(0xFFFFF9F5);
  static const dawnAccent = Color(0xFFD4845A);
  static const dawnText = Color(0xFF2A1F1A);
  static const dawnTextMuted = Color(0xFF8A6E60);

  // ── Temporal palette: DAY (09–17) ────────────────────────────
  static const dayBackground = Color(0xFFF7F4EF); // = canvas
  static const daySurface = Color(0xFFFFFFFF);
  static const dayAccent = Color(0xFF3A6B4A); // = plantGreen
  static const dayText = Color(0xFF1A1814); // = textPrimary
  static const dayTextMuted = Color(0xFF7A7166); // = textSecondary

  // ── Temporal palette: DUSK (18–20) ───────────────────────────
  static const duskBackground = Color(0xFFF2EDF8);
  static const duskSurface = Color(0xFFF8F4FC);
  static const duskAccent = Color(0xFF7B5EA7);
  static const duskText = Color(0xFF1E1828);
  static const duskTextMuted = Color(0xFF7A6E8A);

  // ── Temporal palette: EVENING (21–23) ────────────────────────
  static const eveningBackground = Color(0xFF1E1E2A);
  static const eveningSurface = Color(0xFF2C2C3A);
  static const eveningAccent = Color(0xFF7A9E7A);
  static const eveningText = Color(0xFFE8E4DC);
  static const eveningTextMuted = Color(0xFF8A8890);
}

/// Costanti di spaziatura. Usare SEMPRE queste invece di valori numerici
/// hardcodati.
abstract class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
}

/// Border radius standard.
abstract class AppRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;
}
