import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/data/services/notification_service.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/locale_providers.dart';
import 'package:piantala/presentation/providers/notification_providers.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/paper_text_link.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hour = ref.watch(reminderHourProvider);
    final minute = ref.watch(reminderMinuteProvider);
    final locale = ref.watch(appLocaleProvider);
    final l10n = AppLocalizations.of(context)!;

    // Forza la valutazione del controller del sync notifiche ogni volta
    // che questa schermata è aperta (per aggiornarlo se l'ora è cambiata)
    ref.watch(notificationsSyncControllerProvider);

    final timeStr = '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';

    return MainScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              l10n.settingsScreenTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'DMSerifDisplay',
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.md),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SectionHeader(
                  title: l10n.settingsSectionGeneral,
                  theme: theme,
                ),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    side: BorderSide(color: theme.dividerColor.withAlpha(20)),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.language),
                    title: Text(l10n.settingsLanguageTitle),
                    subtitle: Text(l10n.settingsLanguageSubtitle),
                    trailing: DropdownButton<Locale>(
                      value: locale,
                      underline: const SizedBox.shrink(),
                      items: [
                        DropdownMenuItem(
                          value: const Locale('it'),
                          child: Text(l10n.settingsLanguageItalian),
                        ),
                        DropdownMenuItem(
                          value: const Locale('en'),
                          child: Text(l10n.settingsLanguageEnglish),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          ref.read(appLocaleProvider.notifier).setLocale(value);
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                // ── Sezione Notifiche ───────────────────────────────────
                _SectionHeader(
                  title: l10n.settingsSectionNotifications,
                  theme: theme,
                ),
                const SizedBox(height: AppSpacing.sm),

                // Permesso notifiche
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    side: BorderSide(
                      color: theme.dividerColor.withAlpha(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.settingsNotifPermissionTitle,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          l10n.settingsNotifPermissionSubtitle,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ElevatedButton.icon(
                          onPressed: () async {
                            final granted = await NotificationService.instance
                                .requestPermissions();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    granted
                                        ? l10n.settingsNotifPermissionGranted
                                        : l10n.settingsNotifPermissionDenied,
                                  ),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                          icon: const Icon(Icons.notifications_active),
                          label: const Text('Richiedi Permesso'),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Orario daily reminder
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    side: BorderSide(
                      color: theme.dividerColor.withAlpha(20),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.xs,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withAlpha(20),
                      child: Icon(
                        Icons.alarm,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    title: Text(l10n.settingsReminderTitle),
                    subtitle: Text(
                      l10n.settingsReminderSubtitle(timeStr),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Text(
                      timeStr,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: hour, minute: minute),
                        helpText: l10n.settingsReminderPickerHelpText,
                      );
                      if (picked != null && context.mounted) {
                        await ref
                            .read(reminderHourProvider.notifier)
                            .set(picked.hour);
                        await ref
                            .read(reminderMinuteProvider.notifier)
                            .set(picked.minute);
                        // Ri-schedula immediatamente
                        unawaited(
                          ref.refresh(
                            notificationsSyncControllerProvider.future,
                          ),
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                l10n.settingsReminderUpdated(
                                  '${picked.hour.toString().padLeft(2, '0')}:'
                                  '${picked.minute.toString().padLeft(2, '0')}',
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.success,
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.xl),

                // ── Sezione About ───────────────────────────────────────
                _SectionHeader(title: l10n.settingsSectionAbout, theme: theme),
                const SizedBox(height: AppSpacing.sm),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    side: BorderSide(
                      color: theme.dividerColor.withAlpha(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.info_outline),
                          title: Text(l10n.settingsAboutVersion),
                          trailing: const Text('0.1.0'),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.eco),
                          title: Text(l10n.settingsAboutDataSource),
                          subtitle: Text(l10n.settingsAboutDataSourceSubtitle),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Logout e Elimina account ────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PaperTextLink(
                      label: l10n.settingsLogout,
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider.notifier)
                            .signOut();
                      },
                    ),
                    PaperTextLink(
                      label: l10n.settingsDeleteAccountButton,
                      onPressed: () =>
                          _confirmAndDeleteAccount(context, ref, l10n),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxl),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  /// Mostra il dialog di conferma (design system: PaperDialogScaffold con
  /// HangingTag) e, se l'utente conferma, avvia la cancellazione account.
  Future<void> _confirmAndDeleteAccount(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showPaperDialog<bool>(
      context: context,
      builder: (dialogContext) => PaperDialogScaffold(
        title: l10n.settingsDeleteAccountDialogTitle,
        actions: [
          HangingTag(
            label: l10n.commonCancel,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          HangingTag(
            label: l10n.settingsDeleteAccountConfirm,
            variant: HangingTagVariant.danger,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(top: AppSpacing.sm),
          child: Text(
            l10n.settingsDeleteAccountDialogBody,
            style: dialogContext.piantala.body.copyWith(
              color: dialogContext.piantala.ink,
            ),
          ),
        ),
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await ref.read(authControllerProvider.notifier).deleteAccount();

    if (!context.mounted) return;

    final authState = ref.read(authControllerProvider);
    if (authState.hasError) {
      final error = authState.error;
      final message = error is DeleteAccountException
          ? error.message
          : l10n.settingsDeleteAccountDialogTitle;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    // Se va a buon fine: il logout locale dentro deleteAccount() fa scattare
    // authStateChanges → null e GoRouter reindirizza automaticamente al Login.
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.theme});

  final String title;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    );
  }
}
