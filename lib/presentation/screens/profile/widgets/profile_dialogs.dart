import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piantala/core/constants/app_links.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/screens/profile/profile_metrics.dart';
import 'package:piantala/presentation/screens/profile/widgets/profile_corkboard_painters.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/paper_text_field.dart';
import 'package:piantala/presentation/widgets/common/paper_text_link.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String?> showEditNameDialog({
  required BuildContext context,
  required String initialName,
}) {
  final controller = TextEditingController(text: initialName);
  return showPaperDialog<String>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext)!;
      return PaperDialogScaffold(
        title: l10n.profileEditNameTitle,
        autofocus: true,
        shrinkWrap: true,
        actions: [
          HangingTag(
            label: l10n.commonCancel,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          HangingTag(
            label: l10n.commonSave,
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.of(dialogContext).pop(value);
              }
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.md),
          child: PaperTextField(
            controller: controller,
            label: l10n.profileEditNameLabel,
            hintText: l10n.profilePolaroidDefaultName,
            textInputAction: TextInputAction.done,
          ),
        ),
      );
    },
  );
}

Future<TimeOfDay?> showReminderTimeDialog({
  required BuildContext context,
  required int initialHour,
  required int initialMinute,
}) {
  return showPaperDialog<TimeOfDay>(
    context: context,
    builder: (dialogContext) => _ReminderTimeDialog(
      initialHour: initialHour,
      initialMinute: initialMinute,
    ),
  );
}

class _ReminderTimeDialog extends StatefulWidget {
  const _ReminderTimeDialog({
    required this.initialHour,
    required this.initialMinute,
  });

  final int initialHour;
  final int initialMinute;

  @override
  State<_ReminderTimeDialog> createState() => _ReminderTimeDialogState();
}

class _ReminderTimeDialogState extends State<_ReminderTimeDialog> {
  late int _hour;
  late int _minute;
  late final FixedExtentScrollController _hourController;
  late final FixedExtentScrollController _minuteController;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialHour;
    _minute = widget.initialMinute;
    _hourController = FixedExtentScrollController(initialItem: _hour);
    _minuteController = FixedExtentScrollController(initialItem: _minute);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.piantala;

    return PaperDialogScaffold(
      title: l10n.settingsReminderTitle,
      shrinkWrap: true,
      actions: [
        HangingTag(
          label: l10n.commonCancel,
          variant: HangingTagVariant.secondary,
          mirrored: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HangingTag(
          label: l10n.commonSave,
          onPressed: () => Navigator.of(context).pop(
            TimeOfDay(hour: _hour, minute: _minute),
          ),
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.md),
        child: SizedBox(
          height: ProfileMetrics.wheelPickerHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _TimeWheelColumn(
                controller: _hourController,
                itemCount: ProfileMetrics.hoursInDay,
                selectedValue: _hour,
                onSelectedItemChanged: (value) => setState(() => _hour = value),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  ':',
                  style: theme.h1.copyWith(
                    fontSize: ProfileMetrics.wheelSeparatorFontSize,
                    color: theme.deepGreen,
                  ),
                ),
              ),
              _TimeWheelColumn(
                controller: _minuteController,
                itemCount: ProfileMetrics.minutesInHour,
                selectedValue: _minute,
                onSelectedItemChanged: (value) =>
                    setState(() => _minute = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimeWheelColumn extends StatelessWidget {
  const _TimeWheelColumn({
    required this.controller,
    required this.itemCount,
    required this.selectedValue,
    required this.onSelectedItemChanged,
  });

  final FixedExtentScrollController controller;
  final int itemCount;
  final int selectedValue;
  final ValueChanged<int> onSelectedItemChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return SizedBox(
      width: ProfileMetrics.wheelColumnWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: ProfileMetrics.wheelDividerWidth,
                height: AppStroke.hairline,
                color: theme.deepGreen,
              ),
              const SizedBox(height: ProfileMetrics.wheelItemExtent),
              Container(
                width: ProfileMetrics.wheelDividerWidth,
                height: AppStroke.hairline,
                color: theme.deepGreen,
              ),
            ],
          ),
          ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: ProfileMetrics.wheelItemExtent,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onSelectedItemChanged,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: itemCount,
              builder: (context, index) {
                final isSelected = index == selectedValue;
                final label = index.toString().padLeft(2, '0');
                return Center(
                  child: Text(
                    label,
                    style: theme.body.copyWith(
                      fontSize: isSelected
                          ? ProfileMetrics.wheelSelectedFontSize
                          : ProfileMetrics.wheelUnselectedFontSize,
                      color: isSelected
                          ? theme.deepGreen
                          : theme.softInk.withValues(
                              alpha: ProfileMetrics.wheelUnselectedOpacity,
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<Locale?> showLanguageDialog({
  required BuildContext context,
  required Locale initialLocale,
}) {
  return showPaperDialog<Locale>(
    context: context,
    builder: (dialogContext) => _LanguageDialog(initialLocale: initialLocale),
  );
}

class _LanguageDialog extends StatefulWidget {
  const _LanguageDialog({required this.initialLocale});

  final Locale initialLocale;

  @override
  State<_LanguageDialog> createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<_LanguageDialog> {
  late Locale _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialLocale;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.piantala;

    return PaperDialogScaffold(
      title: l10n.settingsLanguageTitle,
      shrinkWrap: true,
      actions: [
        HangingTag(
          label: l10n.commonCancel,
          variant: HangingTagVariant.secondary,
          mirrored: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        HangingTag(
          label: l10n.commonSave,
          onPressed: () => Navigator.of(context).pop(_selected),
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.profileLanguageDialogSubtitle,
            style: theme.body.copyWith(color: theme.softInk),
          ),
          const SizedBox(height: AppSpacing.md),
          _LanguageChoiceRow(
            label: l10n.profileLanguageNativeItalian,
            selected: _selected.languageCode == 'it',
            onTap: () => setState(() => _selected = const Locale('it')),
          ),
          _LanguageChoiceRow(
            label: l10n.profileLanguageNativeEnglish,
            selected: _selected.languageCode == 'en',
            onTap: () => setState(() => _selected = const Locale('en')),
          ),
        ],
      ),
    );
  }
}

class _LanguageChoiceRow extends StatelessWidget {
  const _LanguageChoiceRow({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: ProfileMetrics.languageRowVerticalPadding,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected
                  ? theme.deepGreen
                  : theme.ink.withValues(alpha: ProfileMetrics.dividerOpacity),
              width: selected
                  ? ProfileMetrics.languageUnderlineWidth
                  : AppStroke.hairline,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.h1.copyWith(
                  fontSize: ProfileMetrics.languageOptionFontSize,
                  color: selected ? theme.deepGreen : theme.ink,
                ),
              ),
            ),
            PermissionStatusDisc(active: selected),
          ],
        ),
      ),
    );
  }
}

Future<void> showPermissionsDialog({
  required BuildContext context,
  required bool notificationsGranted,
  required bool cameraGranted,
  required Future<void> Function() onReturnedFromSettings,
}) {
  return showPaperDialog<void>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext)!;
      final theme = dialogContext.piantala;

      return PaperDialogScaffold(
        title: l10n.profilePermissionsTitle,
        shrinkWrap: true,
        actions: [
          HangingTag(
            label: l10n.commonButtonClose,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          HangingTag(
            label: l10n.profilePermissionsOpenSettings,
            onPressed: () async {
              await openAppSettings();
              await onReturnedFromSettings();
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            },
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.profilePermissionsSubtitle,
              style: theme.body.copyWith(color: theme.softInk),
            ),
            const SizedBox(height: AppSpacing.md),
            _PermissionDetailRow(
              active: notificationsGranted,
              name: l10n.profilePermissionNotificationsName,
              status: notificationsGranted
                  ? l10n.profilePermissionNotificationsActive
                  : l10n.profilePermissionNotificationsInactive,
              reason: l10n.profilePermissionNotificationsReason,
            ),
            const SizedBox(height: ProfileMetrics.permissionDialogRowGap),
            _PermissionDetailRow(
              active: cameraGranted,
              name: l10n.profilePermissionCameraName,
              status: cameraGranted
                  ? l10n.profilePermissionCameraGranted
                  : l10n.profilePermissionCameraNotAsked,
              reason: l10n.profilePermissionCameraReason,
            ),
            const SizedBox(height: ProfileMetrics.permissionDialogRowGap),
            _PermissionDetailRow(
              active: false,
              name: l10n.profilePermissionLocationName,
              status: l10n.profilePermissionLocationUnused,
              reason: l10n.profilePermissionLocationReason,
            ),
          ],
        ),
      );
    },
  );
}

class _PermissionDetailRow extends StatelessWidget {
  const _PermissionDetailRow({
    required this.active,
    required this.name,
    required this.status,
    required this.reason,
  });

  final bool active;
  final String name;
  final String status;
  final String reason;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppSpacing.xs),
          child: PermissionStatusDisc(active: active),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: theme.body.copyWith(
                      color: theme.ink,
                      fontSize: ProfileMetrics.permissionsLabelFontSize,
                    ),
                  ),
                  const SizedBox(width: ProfileMetrics.permissionTitleDotGap),
                  Text(
                    '· $status',
                    style: theme.label.copyWith(
                      color: theme.softInk,
                      fontSize: ProfileMetrics.permissionsStatusFontSize,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                reason,
                style: theme.body.copyWith(
                  color: theme.softInk,
                  fontSize: ProfileMetrics.permissionReasonFontSize,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> showAccountDialog({
  required BuildContext context,
  required String? email,
  required Future<void> Function() onSignOut,
  required Future<void> Function() onDeleteAccount,
}) {
  return showPaperDialog<void>(
    context: context,
    builder: (dialogContext) {
      final l10n = AppLocalizations.of(dialogContext)!;
      final theme = dialogContext.piantala;

      return PaperDialogScaffold(
        title: l10n.profileAccountDialogTitle,
        shrinkWrap: true,
        actions: [
          HangingTag(
            label: l10n.commonButtonClose,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          HangingTag(
            label: l10n.settingsDeleteAccountButton,
            variant: HangingTagVariant.danger,
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await onDeleteAccount();
            },
          ),
        ],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.profileAccountAccessLabel,
              style: theme.label.copyWith(color: theme.softInk),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              email ?? l10n.commonUnknown,
              style: theme.body.copyWith(color: theme.ink),
            ),
            const SizedBox(height: AppSpacing.md),
            Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: PaperTextLink(
                  label: l10n.profileAccountPrivacyLink,
                  onPressed: () {
                    launchUrl(
                      Uri.parse(AppLinks.privacyPolicyUrl),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: IntrinsicWidth(
                child: PaperTextLink(
                  label: l10n.settingsLogout,
                  onPressed: () async {
                    Navigator.of(dialogContext).pop();
                    await onSignOut();
                  },
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<bool?> showDeleteAccountConfirmDialog({
  required BuildContext context,
}) {
  return showPaperDialog<bool>(
    context: context,
    builder: (dialogContext) => const _DeleteAccountConfirmDialog(),
  );
}

class _DeleteAccountConfirmDialog extends StatefulWidget {
  const _DeleteAccountConfirmDialog();

  @override
  State<_DeleteAccountConfirmDialog> createState() =>
      _DeleteAccountConfirmDialogState();
}

class _DeleteAccountConfirmDialogState
    extends State<_DeleteAccountConfirmDialog> {
  final _controller = TextEditingController();
  String _typed = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = context.piantala;
    final matches =
        _typed.trim().toUpperCase() == l10n.profileDeleteConfirmWord;

    return PaperDialogScaffold(
      title: l10n.settingsDeleteAccountDialogTitle,
      shrinkWrap: true,
      actions: [
        HangingTag(
          label: l10n.commonCancel,
          variant: HangingTagVariant.secondary,
          mirrored: true,
          onPressed: () => Navigator.of(context).pop(false),
        ),
        HangingTag(
          label: l10n.settingsDeleteAccountConfirm,
          variant: HangingTagVariant.danger,
          onPressed: matches ? () => Navigator.of(context).pop(true) : null,
        ),
      ],
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.settingsDeleteAccountDialogBody,
            style: theme.body.copyWith(color: theme.ink),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.profileDeleteConfirmPrompt,
            style: theme.body.copyWith(color: theme.softInk),
          ),
          const SizedBox(height: AppSpacing.sm),
          PaperTextField(
            controller: _controller,
            label: l10n.profileDeleteConfirmLabel,
            hintText: l10n.profileDeleteConfirmWord,
            textCapitalization: TextCapitalization.characters,
            onChanged: (value) => setState(() => _typed = value),
          ),
        ],
      ),
    );
  }
}
