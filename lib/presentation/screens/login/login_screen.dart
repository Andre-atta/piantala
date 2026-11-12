import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;
    const period = TemporalPeriod.day;

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

  String _localizedGreeting(TemporalPeriod p, AppLocalizations? l10n) {
    if (l10n == null) return p.greeting;
    return switch (p) {
      TemporalPeriod.night => l10n.greetingNight,
      TemporalPeriod.dawn => l10n.greetingDawn,
      TemporalPeriod.day => l10n.greetingDay,
      TemporalPeriod.dusk => l10n.greetingDusk,
      TemporalPeriod.evening => l10n.greetingEvening,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

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
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(flex: 2),

              // ── Logo & titolo ──────────────────────────────────────
              Center(
                child: Column(
                  children: [
                    Container(
                      width: AppSizes.avatarLg,
                      height: AppSizes.avatarLg,
                      decoration: BoxDecoration(
                        color: _accentColor.withAlpha(25),
                        borderRadius: BorderRadius.circular(AppRadius.xl),
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
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      l10n?.appName ?? 'Piantala',
                      style: TextStyle(
                        fontFamily: 'DMSerifDisplay',
                        fontSize: 42,
                        fontWeight: FontWeight.w400,
                        color: _textColor,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n?.appTagline ?? 'Il tuo giardino tascabile',
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
                  '${period.icon}  ${_localizedGreeting(period, l10n)}',
                  style: TextStyle(
                    fontSize: 16,
                    color: _textColor.withAlpha(178),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              // ── Metodi di accesso ─────────────────────────────────
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

              const SizedBox(height: AppSpacing.md),
              OutlinedButton(
                onPressed: isLoading
                    ? null
                    : () => showModalBottomSheet<void>(
                          context: context,
                          isScrollControlled: true,
                          showDragHandle: true,
                          builder: (_) => const _EmailAuthSheet(),
                        ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _textColor,
                  side: BorderSide(color: _textColor.withAlpha(70)),
                  minimumSize: const Size.fromHeight(AppSizes.buttonHeightMd),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
                child: Text(l10n?.authSignInWithEmail ?? 'Accedi con email'),
              ),

              const SizedBox(height: AppSpacing.md),
              Center(
                child: Text(
                  l10n?.appTosNotice ??
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

class _EmailAuthSheet extends ConsumerStatefulWidget {
  const _EmailAuthSheet();

  @override
  ConsumerState<_EmailAuthSheet> createState() => _EmailAuthSheetState();
}

class _EmailAuthSheetState extends ConsumerState<_EmailAuthSheet> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  bool _isRegistration = false;
  bool _isReset = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  Future<void> _submit(AppLocalizations? l10n) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final controller = ref.read(authControllerProvider.notifier);
    if (_isReset) {
      await controller.sendPasswordResetEmail(_emailController.text);
    } else if (_isRegistration) {
      await controller.createUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
        _displayNameController.text,
      );
    } else {
      await controller.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    }

    if (!mounted) return;
    final state = ref.read(authControllerProvider);
    if (state.hasError) return;

    final message = _isReset
        ? (l10n?.authResetEmailSent ??
            'Se l’indirizzo è associato a un account, riceverai le istruzioni.')
        : null;
    Navigator.of(context).pop();
    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        bottomInset + AppSpacing.lg,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _isReset
                    ? (l10n?.authSheetTitleReset ?? 'Recupera password')
                    : _isRegistration
                        ? (l10n?.authSheetTitleRegister ?? 'Crea account')
                        : (l10n?.authSheetTitleLogin ?? 'Accedi con email'),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontFamily: 'DMSerifDisplay',
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                _isReset
                    ? (l10n?.authSheetSubtitleReset ??
                        'Inserisci la tua email. Se è associata a un account, riceverai le istruzioni.')
                    : (l10n?.authSheetSubtitleLogin ??
                        'Usa un indirizzo email valido e una password sicura.'),
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.md),
              if (_isRegistration) ...[
                TextFormField(
                  controller: _displayNameController,
                  enabled: !authState.isLoading,
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  decoration: InputDecoration(
                    labelText: l10n?.authFieldName ?? 'Nome',
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                  validator: (value) => value?.trim().isEmpty ?? true
                      ? (l10n?.authValidationNameEmpty ?? 'Inserisci il tuo nome')
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
              TextFormField(
                controller: _emailController,
                enabled: !authState.isLoading,
                keyboardType: TextInputType.emailAddress,
                textInputAction:
                    _isReset ? TextInputAction.done : TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                decoration: InputDecoration(
                  labelText: l10n?.authFieldEmail ?? 'Email',
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';
                  if (email.isEmpty || !email.contains('@')) {
                    return l10n?.authValidationEmailInvalid ??
                        'Inserisci un indirizzo email valido';
                  }
                  return null;
                },
              ),
              if (!_isReset) ...[
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _passwordController,
                  enabled: !authState.isLoading,
                  obscureText: _obscurePassword,
                  textInputAction: _isRegistration
                      ? TextInputAction.next
                      : TextInputAction.done,
                  autofillHints: [
                    if (_isRegistration)
                      AutofillHints.newPassword
                    else
                      AutofillHints.password,
                  ],
                  decoration: InputDecoration(
                    labelText: l10n?.authFieldPassword ?? 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                        () => _obscurePassword = !_obscurePassword,
                      ),
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if ((value ?? '').length < 6) {
                      return l10n?.authValidationPasswordTooShort ??
                          'Usa almeno 6 caratteri';
                    }
                    return null;
                  },
                ),
              ],
              if (_isRegistration) ...[
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _confirmationController,
                  enabled: !authState.isLoading,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: l10n?.authFieldConfirmPassword ??
                        'Conferma password',
                    prefixIcon: const Icon(Icons.lock_reset_outlined),
                  ),
                  validator: (value) => value != _passwordController.text
                      ? (l10n?.authValidationPasswordMismatch ??
                          'Le password non coincidono')
                      : null,
                ),
              ],
              if (authState.hasError) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  authState.error.toString(),
                  style: TextStyle(color: theme.colorScheme.error),
                ),
              ],
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: authState.isLoading ? null : () => _submit(l10n),
                child: _submitChild(authState.isLoading, l10n),
              ),
              if (!_isReset && !_isRegistration)
                TextButton(
                  onPressed: authState.isLoading
                      ? null
                      : () => setState(() => _isReset = true),
                  child: Text(
                    l10n?.authButtonForgotPassword ?? 'Password dimenticata?',
                  ),
                ),
              TextButton(
                onPressed: authState.isLoading
                    ? null
                    : () => setState(() {
                          _isReset = false;
                          _isRegistration = !_isRegistration;
                        }),
                child: Text(
                  _isReset
                      ? (l10n?.authButtonBackToLogin ?? 'Torna all’accesso')
                      : _isRegistration
                          ? (l10n?.authButtonGoToLogin ??
                              'Hai già un account? Accedi')
                          : (l10n?.authButtonGoToRegister ??
                              'Non hai un account? Registrati'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitChild(bool isLoading, AppLocalizations? l10n) {
    if (isLoading) {
      return const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    final label = _isReset
        ? (l10n?.authButtonSendReset ?? 'Invia istruzioni')
        : _isRegistration
            ? (l10n?.authButtonRegister ?? 'Crea account')
            : (l10n?.authButtonLogin ?? 'Accedi');
    return Text(label);
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
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      height: AppSizes.buttonHeightLg,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: accentColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppSizes.iconMd,
              height: AppSizes.iconMd,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadius.xs),
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
            const SizedBox(width: AppSpacing.md),
            Text(
              l10n?.authSignInWithGoogle ?? 'Continua con Google',
              style: const TextStyle(
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
