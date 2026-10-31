import 'package:flutter/material.dart';

abstract class AppTypography {
  // Font families
  static const sansFamily = 'DMSans';
  static const serifFamily = 'DMSerifDisplay';

  /// Costruisce un TextTheme completo per un colore di testo dato.
  static TextTheme textTheme(Color textColor) => TextTheme(
        // Display — usato per titoli hero e header di sezione
        displayLarge: TextStyle(
          fontFamily: serifFamily,
          fontSize: 48,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.1,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontFamily: serifFamily,
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.15,
        ),
        displaySmall: TextStyle(
          fontFamily: serifFamily,
          fontSize: 28,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.2,
        ),

        // Headline — usato per nome pianta, titoli card
        headlineLarge: TextStyle(
          fontFamily: serifFamily,
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        headlineMedium: TextStyle(
          fontFamily: sansFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        headlineSmall: TextStyle(
          fontFamily: sansFamily,
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),

        // Title — usato per sezioni, label principali
        titleLarge: TextStyle(
          fontFamily: sansFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleMedium: TextStyle(
          fontFamily: sansFamily,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        titleSmall: TextStyle(
          fontFamily: sansFamily,
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),

        // Body — testo corrente
        bodyLarge: TextStyle(
          fontFamily: sansFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          fontFamily: sansFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.5,
        ),
        bodySmall: TextStyle(
          fontFamily: sansFamily,
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: textColor.withValues(alpha: 0.7),
          height: 1.4,
        ),

        // Label — chip, badge, tag
        labelLarge: TextStyle(
          fontFamily: sansFamily,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.2,
        ),
        labelMedium: TextStyle(
          fontFamily: sansFamily,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontFamily: sansFamily,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: textColor,
          letterSpacing: 1,
        ),
      );
}
