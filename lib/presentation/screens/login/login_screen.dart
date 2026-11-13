import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:piantala/core/constants/app_links.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/screens/login/login_metrics.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/paper_text_field.dart';
import 'package:piantala/presentation/widgets/common/paper_text_link.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String? _googleError;

  Future<void> _signInWithGoogle(AppLocalizations l10n) async {
    setState(() => _googleError = null);
    await ref.read(authControllerProvider.notifier).signInWithGoogle();
    if (!mounted) return;

    final authState = ref.read(authControllerProvider);
    if (authState.hasError) {
      setState(() => _googleError = _localizedAuthError(authState.error, l10n));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final l10n = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Theme(
        data: TemporalTheme.buildTheme(TemporalPeriod.day),
        child: Scaffold(
          body: _LoginBody(
            isLoading: authState.isLoading,
            googleError: _googleError,
            onGoogleSignIn: () => _signInWithGoogle(l10n),
          ),
        ),
      ),
    );
  }
}

String _localizedAuthError(Object? error, AppLocalizations l10n) {
  final failure = error is AuthException ? error.failure : null;
  return switch (failure) {
    AuthFailure.invalidCredential => l10n.authErrorInvalidCredential,
    AuthFailure.invalidEmail => l10n.authErrorInvalidEmail,
    AuthFailure.weakPassword => l10n.authErrorWeakPassword,
    AuthFailure.emailAlreadyInUse => l10n.authErrorEmailAlreadyInUse,
    AuthFailure.tooManyRequests => l10n.authErrorTooManyRequests,
    AuthFailure.networkUnavailable => l10n.authErrorNetwork,
    AuthFailure.resetEmailSent => l10n.authResetEmailSent,
    AuthFailure.generic || null => l10n.authErrorGeneric,
  };
}

class _LoginBody extends StatefulWidget {
  const _LoginBody({
    required this.isLoading,
    required this.googleError,
    required this.onGoogleSignIn,
  });

  final bool isLoading;
  final String? googleError;
  final VoidCallback onGoogleSignIn;

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  String? _privacyError;

  Future<void> _openPrivacyPolicy(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    try {
      final opened = await launchUrl(
        Uri.parse(AppLinks.privacyPolicyUrl),
        mode: LaunchMode.externalApplication,
      );
      if (mounted) {
        setState(
          () => _privacyError = opened ? null : l10n.loginPrivacyOpenError,
        );
      }
    } on PlatformException {
      if (mounted) setState(() => _privacyError = l10n.loginPrivacyOpenError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                padding: const EdgeInsets.fromLTRB(
                  LoginMetrics.horizontalPadding,
                  LoginMetrics.contentTopPadding,
                  LoginMetrics.horizontalPadding,
                  LoginMetrics.contentBottomPadding,
                ),
                children: [
                  Column(
                    children: [
                      Text(
                        l10n.greetingDay,
                        style: theme.body.copyWith(
                          fontSize: LoginMetrics.greetingFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: LoginMetrics.greetingTitleSpacing,
                      ),
                      Semantics(
                        container: true,
                        header: true,
                        child: Text(
                          l10n.appName,
                          textAlign: TextAlign.center,
                          style: theme.display,
                        ),
                      ),
                      Text(
                        l10n.loginTagline,
                        textAlign: TextAlign.center,
                        style: theme.body,
                      ),
                    ],
                  ),
                  const SizedBox(height: LoginMetrics.titlePlantSpacing),
                  const _LoginPlantShelf(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: HangingTag(
                          key: const ValueKey('login-google'),
                          label: l10n.authSignInWithGoogle,
                          leading: ExcludeSemantics(
                            child: SvgPicture.asset(
                              'assets/svg/auth/google_g.svg',
                              width: LoginMetrics.googleLogoSize,
                              height: LoginMetrics.googleLogoSize,
                            ),
                          ),
                          onPressed:
                              widget.isLoading ? null : widget.onGoogleSignIn,
                        ),
                      ),
                      const SizedBox(width: LoginMetrics.actionSpacing),
                      Flexible(
                        child: HangingTag(
                          key: const ValueKey('login-email'),
                          label: l10n.authSignInWithEmail,
                          variant: HangingTagVariant.secondary,
                          onPressed: widget.isLoading
                              ? null
                              : () => showPaperDialog<void>(
                                    context: context,
                                    builder: (_) => Theme(
                                      data: TemporalTheme.buildTheme(
                                        TemporalPeriod.day,
                                      ),
                                      child: _EmailAuthSheet(
                                        onOpenPrivacyPolicy: () =>
                                            _openPrivacyPolicy(context, l10n),
                                      ),
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.googleError != null) ...[
                    const SizedBox(height: LoginMetrics.errorSpacing),
                    Semantics(
                      liveRegion: true,
                      child: Text(
                        widget.googleError!,
                        textAlign: TextAlign.center,
                        style: theme.body.copyWith(
                          color: theme.terracotta,
                          fontSize: LoginMetrics.errorFontSize,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              Positioned(
                left: LoginMetrics.privacyHorizontalInset,
                right: LoginMetrics.privacyHorizontalInset,
                bottom: LoginMetrics.privacyBottomInset,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '${l10n.loginPrivacyNotice} ',
                          textAlign: TextAlign.center,
                          style: theme.body.copyWith(
                            fontSize: LoginMetrics.privacyFontSize,
                            color: theme.softInk,
                          ),
                        ),
                        PaperTextLink(
                          label: l10n.loginPrivacyLink,
                          onPressed: () => _openPrivacyPolicy(context, l10n),
                        ),
                      ],
                    ),
                    if (_privacyError != null) ...[
                      const SizedBox(
                        height: LoginMetrics.privacyErrorSpacing,
                      ),
                      Text(
                        _privacyError!,
                        textAlign: TextAlign.center,
                        style: theme.body.copyWith(
                          color: theme.terracotta,
                          fontSize: LoginMetrics.errorFontSize,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _LoginPlantShelf extends StatelessWidget {
  const _LoginPlantShelf();

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return SizedBox(
      height: LoginMetrics.shelfHeight,
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
              width: LoginMetrics.plantWidth,
              height: LoginMetrics.plantHeight,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            left: LoginMetrics.shelfHorizontalOverhang,
            right: LoginMetrics.shelfHorizontalOverhang,
            bottom: 0,
            child: Container(
              height: LoginMetrics.shelfThickness,
              decoration: BoxDecoration(
                color: theme.sage,
                border: Border.all(
                  color: theme.ink,
                  width: LoginMetrics.shelfBorderWidth,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _EmailAuthMode { login, registration, reset }

class _EmailAuthSheet extends ConsumerStatefulWidget {
  const _EmailAuthSheet({required this.onOpenPrivacyPolicy});

  final VoidCallback onOpenPrivacyPolicy;

  @override
  ConsumerState<_EmailAuthSheet> createState() => _EmailAuthSheetState();
}

class _EmailAuthSheetState extends ConsumerState<_EmailAuthSheet> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  _EmailAuthMode _mode = _EmailAuthMode.login;
  String? _errorMessage;
  bool _resetEmailSent = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  void _changeMode(_EmailAuthMode mode) {
    if (_mode == mode || ref.read(authControllerProvider).isLoading) return;
    _formKey.currentState?.reset();
    _passwordController.clear();
    _confirmationController.clear();
    setState(() {
      _mode = mode;
      _errorMessage = null;
      _resetEmailSent = false;
    });
  }

  Future<void> _submit(AppLocalizations l10n) async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _errorMessage = null);
    final controller = ref.read(authControllerProvider.notifier);
    final email = _emailController.text.trim();

    switch (_mode) {
      case _EmailAuthMode.login:
        await controller.signInWithEmailAndPassword(
          email,
          _passwordController.text,
        );
      case _EmailAuthMode.registration:
        await controller.createUserWithEmailAndPassword(
          email,
          _passwordController.text,
          _displayNameController.text.trim(),
        );
      case _EmailAuthMode.reset:
        await controller.sendPasswordResetEmail(email);
    }

    if (!mounted) return;
    final authState = ref.read(authControllerProvider);
    if (authState.hasError) {
      final error = authState.error;
      if (_mode == _EmailAuthMode.reset &&
          error is AuthException &&
          error.failure == AuthFailure.resetEmailSent) {
        setState(() => _resetEmailSent = true);
        return;
      }
      setState(() => _errorMessage = _localizedAuthError(error, l10n));
      return;
    }

    if (_mode == _EmailAuthMode.reset) {
      setState(() => _resetEmailSent = true);
      return;
    }

    _passwordController.clear();
    _confirmationController.clear();
    Navigator.of(context).pop();
  }

  void _onEmailChanged(String value) {
    if (!_resetEmailSent && _errorMessage == null) return;
    setState(() {
      _resetEmailSent = false;
      _errorMessage = null;
    });
  }

  String? _validateEmail(String? value, AppLocalizations l10n) {
    final email = value?.trim() ?? '';
    if (email.isEmpty || !email.contains('@')) {
      return l10n.authValidationEmailInvalid;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.piantala;
    final isLoading = ref.watch(authControllerProvider).isLoading;
    final isRegistration = _mode == _EmailAuthMode.registration;
    final isReset = _mode == _EmailAuthMode.reset;
    final title = switch (_mode) {
      _EmailAuthMode.login => l10n.authSheetTitleLogin,
      _EmailAuthMode.registration => l10n.authSheetTitleRegister,
      _EmailAuthMode.reset => l10n.authSheetTitleReset,
    };
    final submitLabel = switch (_mode) {
      _EmailAuthMode.login => l10n.authButtonLogin,
      _EmailAuthMode.registration => l10n.authButtonRegister,
      _EmailAuthMode.reset => l10n.authButtonSendReset,
    };
    final topInset = switch (_mode) {
      _EmailAuthMode.login => LoginMetrics.loginDialogTopInset,
      _EmailAuthMode.registration => LoginMetrics.registerDialogTopInset,
      _EmailAuthMode.reset => LoginMetrics.resetDialogTopInset,
    };

    return PaperDialogScaffold(
      title: title,
      topInset: topInset,
      actions: [
        HangingTag(
          key: const ValueKey('email-auth-cancel'),
          label: l10n.commonCancel,
          variant: HangingTagVariant.secondary,
          mirrored: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HangingTag(
          key: const ValueKey('email-auth-submit'),
          label: submitLabel,
          onPressed: isLoading || _resetEmailSent ? null : () => _submit(l10n),
        ),
      ],
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(
                  bottom: LoginMetrics.formFieldSpacing,
                ),
                child: Semantics(
                  liveRegion: true,
                  child: Text(
                    _errorMessage!,
                    style: theme.body.copyWith(
                      color: theme.terracotta,
                      fontSize: LoginMetrics.errorFontSize,
                    ),
                  ),
                ),
              ),
            if (_mode == _EmailAuthMode.login) ...[
              Text(
                l10n.authSheetSubtitleLogin,
                style: theme.body,
              ),
              const SizedBox(height: LoginMetrics.formSectionSpacing),
            ] else if (isReset) ...[
              Text(
                l10n.authSheetSubtitleReset,
                style: theme.body,
              ),
              const SizedBox(height: LoginMetrics.formSectionSpacing),
            ],
            if (isRegistration) ...[
              PaperTextField(
                fieldKey: const ValueKey('auth-name-field'),
                label: l10n.authFieldName,
                hintText: '',
                controller: _displayNameController,
                enabled: !isLoading,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.name],
                validator: (value) => value?.trim().isNotEmpty ?? false
                    ? null
                    : l10n.authValidationNameEmpty,
              ),
              const SizedBox(height: LoginMetrics.formFieldSpacing),
            ],
            PaperTextField(
              fieldKey: const ValueKey('auth-email-field'),
              label: l10n.authFieldEmail,
              hintText: '',
              controller: _emailController,
              enabled: !isLoading,
              keyboardType: TextInputType.emailAddress,
              textInputAction:
                  isReset ? TextInputAction.done : TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              autocorrect: false,
              onChanged: _onEmailChanged,
              validator: (value) => _validateEmail(value, l10n),
            ),
            if (!isReset) ...[
              const SizedBox(height: LoginMetrics.formFieldSpacing),
              PaperTextField(
                fieldKey: const ValueKey('auth-password-field'),
                label: l10n.authFieldPassword,
                hintText: '',
                controller: _passwordController,
                enabled: !isLoading,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                textInputAction: isRegistration
                    ? TextInputAction.next
                    : TextInputAction.done,
                autofillHints: [
                  if (isRegistration)
                    AutofillHints.newPassword
                  else
                    AutofillHints.password,
                ],
                validator: (value) => (value ?? '').length >= 6
                    ? null
                    : l10n.authValidationPasswordTooShort,
              ),
            ],
            if (isRegistration) ...[
              const SizedBox(height: LoginMetrics.formFieldSpacing),
              PaperTextField(
                fieldKey: const ValueKey('auth-confirm-password-field'),
                label: l10n.authFieldConfirmPassword,
                hintText: '',
                controller: _confirmationController,
                enabled: !isLoading,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.newPassword],
                validator: (value) => value == _passwordController.text
                    ? null
                    : l10n.authValidationPasswordMismatch,
              ),
              const SizedBox(height: LoginMetrics.registerPrivacySpacing),
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '${l10n.authRegisterPrivacyNotice} ',
                    textAlign: TextAlign.center,
                    style: theme.body.copyWith(
                      fontSize: LoginMetrics.privacyFontSize,
                    ),
                  ),
                  PaperTextLink(
                    label: l10n.loginPrivacyLink,
                    onPressed: widget.onOpenPrivacyPolicy,
                  ),
                ],
              ),
            ],
            if (isReset && _resetEmailSent) ...[
              const SizedBox(height: LoginMetrics.formFieldSpacing),
              Text(
                l10n.authResetEmailSent,
                style: theme.body.copyWith(
                  fontSize: LoginMetrics.privacyFontSize,
                ),
              ),
            ],
            const SizedBox(height: LoginMetrics.formSectionSpacing),
            if (_mode == _EmailAuthMode.login)
              Center(
                child: PaperTextLink(
                  label: l10n.authButtonForgotPassword,
                  enabled: !isLoading,
                  onPressed: () => _changeMode(_EmailAuthMode.reset),
                ),
              ),
            if (isReset)
              Center(
                child: PaperTextLink(
                  label: l10n.authButtonBackToLogin,
                  enabled: !isLoading,
                  onPressed: () => _changeMode(_EmailAuthMode.login),
                ),
              ),
            if (isRegistration)
              Center(
                child: PaperTextLink(
                  label: l10n.authButtonGoToLogin,
                  enabled: !isLoading,
                  onPressed: () => _changeMode(_EmailAuthMode.login),
                ),
              ),
            if (_mode == _EmailAuthMode.login)
              Center(
                child: PaperTextLink(
                  label: l10n.authButtonGoToRegister,
                  enabled: !isLoading,
                  onPressed: () => _changeMode(_EmailAuthMode.registration),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
