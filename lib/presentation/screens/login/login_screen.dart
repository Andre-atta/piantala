import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piantala/core/constants/app_links.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_text_link.dart';
import 'package:url_launcher/url_launcher.dart';

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
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Theme(
        data: TemporalTheme.buildTheme(period),
        child: Scaffold(
          body: _LoginBody(isLoading: isLoading, ref: ref),
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({
    required this.isLoading,
    required this.ref,
  });

  final bool isLoading;
  final WidgetRef ref;

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
    final theme = context.piantala;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          PlantAssetResolver.wallBackground(),
          fit: BoxFit.cover,
        ),
        SafeArea(
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(20, 84, 20, 112),
                children: [
                  Column(
                    children: [
                      Text(
                        _localizedGreeting(TemporalPeriod.day, l10n),
                        style: theme.body.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
                      Semantics(
                        container: true,
                        header: true,
                        child: Text(
                          l10n?.appName ?? 'Piantala',
                          textAlign: TextAlign.center,
                          style: theme.display,
                        ),
                      ),
                      Text(
                        l10n?.loginTagline ??
                            'Le tue piante, una mensola alla volta.',
                        textAlign: TextAlign.center,
                        style: theme.body,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const _LoginPlantShelf(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: HangingTag(
                          key: const ValueKey('login-google'),
                          label: l10n?.authSignInWithGoogle ??
                              'Continua con Google',
                          leading: SvgPicture.asset(
                            'assets/svg/auth/google_g.svg',
                            width: 18,
                            height: 18,
                          ),
                          onPressed: isLoading
                              ? null
                              : () => ref
                                  .read(authControllerProvider.notifier)
                                  .signInWithGoogle(),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Flexible(
                        child: HangingTag(
                          key: const ValueKey('login-email'),
                          label:
                              l10n?.authSignInWithEmail ?? 'Accedi con email',
                          variant: HangingTagVariant.secondary,
                          onPressed: isLoading
                              ? null
                              : () => showModalBottomSheet<void>(
                                    context: context,
                                    isScrollControlled: true,
                                    showDragHandle: true,
                                    builder: (_) => const _EmailAuthSheet(),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 32,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${l10n?.loginPrivacyNotice ?? 'Continuando accetti'} ',
                      textAlign: TextAlign.center,
                      style: theme.body.copyWith(
                        fontSize: 11,
                        color: theme.softInk,
                      ),
                    ),
                    PaperTextLink(
                      label: l10n?.loginPrivacyLink ??
                          "l'Informativa sulla privacy",
                      onPressed: () => _openPrivacyPolicy(context, l10n),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openPrivacyPolicy(
    BuildContext context,
    AppLocalizations? l10n,
  ) async {
    final opened = await launchUrl(
      Uri.parse(AppLinks.privacyPolicyUrl),
      mode: LaunchMode.externalApplication,
    );
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n?.loginPrivacyOpenError ??
                'Impossibile aprire l’informativa sulla privacy.',
          ),
        ),
      );
    }
  }
}

class _LoginPlantShelf extends StatelessWidget {
  const _LoginPlantShelf();

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return SizedBox(
      height: 190,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              PlantAssetResolver.plantAsset(
                    'epipremnum_aureum',
                    water: true,
                  ) ??
                  'assets/illustrations/plants/epipremnum_aureum_water.png',
              width: 172,
              height: 182,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: -16,
            right: -16,
            bottom: 0,
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: theme.sage,
                border: Border.all(
                  color: theme.ink,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
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
                        'Inserisci la tua email. Se è associata a un account, '
                            'riceverai le istruzioni.')
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
                      ? (l10n?.authValidationNameEmpty ??
                          'Inserisci il tuo nome')
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
                    labelText:
                        l10n?.authFieldConfirmPassword ?? 'Conferma password',
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
