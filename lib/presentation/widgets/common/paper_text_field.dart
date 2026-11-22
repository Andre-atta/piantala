import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';

class PaperTextField extends StatefulWidget {
  const PaperTextField({
    required this.label,
    required this.hintText,
    this.controller,
    this.fieldKey,
    this.validator,
    this.onChanged,
    this.autofillHints,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.textCapitalization = TextCapitalization.none,
    this.autofocus = false,
    this.obscureText = false,
    super.key,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Key? fieldKey;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool enabled;
  final bool enableSuggestions;
  final bool autocorrect;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool obscureText;

  @override
  State<PaperTextField> createState() => _PaperTextFieldState();
}

class _PaperTextFieldState extends State<PaperTextField> {
  late bool _isObscured = widget.obscureText;

  @override
  void didUpdateWidget(covariant PaperTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.obscureText != widget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;
    final underline = UnderlineInputBorder(
      borderSide: BorderSide(
        color: theme.deepGreen,
        width: PaperComponentMetrics.paperFieldUnderlineWidth,
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.label.toUpperCase(),
          style: theme.label.copyWith(color: theme.deepGreen),
        ),
        const SizedBox(height: PaperComponentMetrics.paperFieldLabelSpacing),
        TextFormField(
          key: widget.fieldKey,
          controller: widget.controller,
          validator: widget.validator,
          onChanged: widget.onChanged,
          autofillHints: widget.autofillHints,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          enableSuggestions: widget.enableSuggestions,
          autocorrect: widget.autocorrect,
          textCapitalization: widget.textCapitalization,
          autofocus: widget.autofocus,
          obscureText: _isObscured,
          style: theme.body.copyWith(
            color: theme.ink,
            fontSize: PaperComponentMetrics.paperFieldFontSize,
          ),
          cursorColor: theme.deepGreen,
          decoration: InputDecoration(
            constraints: const BoxConstraints(
              minHeight: PaperComponentMetrics.paperFieldMinimumHeight,
            ),
            hintText: widget.hintText,
            hintStyle: theme.body.copyWith(
              color: theme.softInk,
              fontSize: PaperComponentMetrics.paperFieldFontSize,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 8),
            border: underline,
            enabledBorder: underline,
            focusedBorder: underline,
            errorBorder: underline,
            focusedErrorBorder: underline,
            errorStyle: theme.body.copyWith(
              color: theme.terracotta,
              fontSize: PaperComponentMetrics.paperFieldErrorFontSize,
            ),
            suffixIcon: widget.obscureText
                ? Semantics(
                    button: true,
                    label: _isObscured
                        ? l10n.paperTextFieldShowPassword
                        : l10n.paperTextFieldHidePassword,
                    onTap: () => setState(() => _isObscured = !_isObscured),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() => _isObscured = !_isObscured),
                      child: SizedBox(
                        width: PaperComponentMetrics.paperFieldEyeTargetSize,
                        height: PaperComponentMetrics.paperFieldEyeTargetSize,
                        child: ExcludeSemantics(
                          child: Center(
                            child: SvgPicture.asset(
                              _isObscured
                                  ? 'assets/svg/common/eye.svg'
                                  : 'assets/svg/common/eye_closed.svg',
                              width:
                                  PaperComponentMetrics.paperFieldEyeIconSize,
                              height:
                                  PaperComponentMetrics.paperFieldEyeIconSize,
                              colorFilter: ColorFilter.mode(
                                theme.deepGreen,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
