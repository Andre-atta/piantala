import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/theme_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    final period = ref.watch(temporalPeriodProvider).valueOrNull ??
        TemporalPeriodX.fromHour(DateTime.now().hour);

    ref.listen<AsyncValue<void>>(
      authControllerProvider,
      (_, state) {
        if (!state.isLoading && state.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error.toString()),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: _iconBrightness(period),
      ),
      child: Scaffold(
        body: _LoginBody(period: period, isLoading: isLoading, ref: ref),
      ),
    );
  }

  Brightness _iconBrightness(TemporalPeriod period) =>
      (period == TemporalPeriod.night || period == TemporalPeriod.evening)
          ? Brightness.light
          : Brightness.dark;
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({
    required this.period,
    required this.isLoading,
    required this.ref,
  });

  final TemporalPeriod period;
  final bool isLoading;
  final WidgetRef ref;

  Color get _bgTop => switch (period) {
        TemporalPeriod.night => AppColors.nightBackground,
        TemporalPeriod.dawn => AppColors.dawnBackground,
        TemporalPeriod.day => const Color(0xFFF0F7F2),
        TemporalPeriod.dusk => AppColors.duskBackground,
        TemporalPeriod.evening => AppColors.eveningBackground,
      };

  Color get _bgBottom => switch (period) {
        TemporalPeriod.night => AppColors.nightSurface,
        TemporalPeriod.dawn => AppColors.dawnSurface,
        TemporalPeriod.day => AppColors.daySurface,
        TemporalPeriod.dusk => AppColors.duskSurface,
        TemporalPeriod.evening => AppColors.eveningSurface,
      };

  Color get _textColor => switch (period) {
        TemporalPeriod.night => AppColors.nightText,
        TemporalPeriod.dawn => AppColors.dawnText,
        TemporalPeriod.day => AppColors.dayText,
        TemporalPeriod.dusk => AppColors.duskText,
        TemporalPeriod.evening => AppColors.eveningText,
      };

  Color get _accentColor => switch (period) {
        TemporalPeriod.night => AppColors.nightAccent,
        TemporalPeriod.dawn => AppColors.dawnAccent,
        TemporalPeriod.day => AppColors.plantGreen,
        TemporalPeriod.dusk => AppColors.duskAccent,
        TemporalPeriod.evening => AppColors.eveningAccent,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_bgTop, _bgBottom],
          stops: const [0.0, 0.85],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // ── Logo & titolo ──────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 88,
                      height: 88,
                      decoration: BoxDecoration(
                        color: _accentColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: _accentColor.withAlpha(50),
                          width: 1.5,
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '🌿',
                          style: TextStyle(fontSize: 42),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Piantala',
                      style: TextStyle(
                        fontFamily: 'DMSerifDisplay',
                        fontSize: 42,
                        fontWeight: FontWeight.w400,
                        color: _textColor,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Il tuo giardino tascabile',
                      style: TextStyle(
                        fontSize: 15,
                        color: _textColor.withAlpha(153),
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 3),

              // ── Greeting contestuale ──────────────────────────────
              Center(
                child: Text(
                  '${period.icon}  ${period.greeting}',
                  style: TextStyle(
                    fontSize: 16,
                    color: _textColor.withAlpha(178),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // ── Bottone Google Sign-In ────────────────────────────
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isLoading
                    ? Center(
                        key: const ValueKey('loader'),
                        child: CircularProgressIndicator(color: _accentColor),
                      )
                    : _GoogleSignInButton(
                        key: const ValueKey('btn'),
                        accentColor: _accentColor,
                        textColor: _textColor,
                        onPressed: () {
                          ref
                              .read(authControllerProvider.notifier)
                              .signInWithGoogle();
                        },
                      ),
              ),

              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Accedendo accetti i Termini di servizio',
                  style: TextStyle(
                    fontSize: 11,
                    color: _textColor.withAlpha(100),
                  ),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({
    required this.accentColor,
    required this.textColor,
    required this.onPressed,
    super.key,
  });

  final Color accentColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Google semplificato con le 4 lettere colorate
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Center(
                child: Text(
                  'G',
                  style: TextStyle(
                    color: Color(0xFF4285F4),
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Continua con Google',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
