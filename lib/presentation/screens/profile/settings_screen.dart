import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piantala/core/errors/app_exception.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/data/services/notification_service.dart';
import 'package:piantala/domain/entities/user_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/locale_providers.dart';
import 'package:piantala/presentation/providers/notification_providers.dart';
import 'package:piantala/presentation/screens/profile/profile_metrics.dart';
import 'package:piantala/presentation/screens/profile/widgets/profile_corkboard_painters.dart';
import 'package:piantala/presentation/screens/profile/widgets/profile_dialogs.dart';
import 'package:piantala/presentation/widgets/common/paper_component_metrics.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen>
    with WidgetsBindingObserver {
  static const _defaultAvatarAsset = 'assets/avatars/default_avatar.png';

  bool _notificationsGranted = false;
  bool _cameraGranted = false;
  bool _isUploadingAvatar = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_refreshPermissions());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_refreshPermissions());
    }
  }

  Future<void> _refreshPermissions() async {
    final notif = await NotificationService.instance.arePermissionsGranted();
    final camera = (await Permission.camera.status).isGranted;
    if (!mounted) return;
    setState(() {
      _notificationsGranted = notif;
      _cameraGranted = camera;
    });
  }

  String _resolveDisplayName(UserEntity? user, AppLocalizations l10n) {
    final name = user?.displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final email = user?.email?.trim();
    if (email != null && email.contains('@')) {
      final local = email.split('@').first.trim();
      if (local.isNotEmpty) return local;
    }
    return l10n.profilePolaroidDefaultName;
  }

  Future<void> _pickAndUploadAvatar(UserEntity? user) async {
    if (user == null || _isUploadingAvatar) return;
    final l10n = AppLocalizations.of(context)!;
    final theme = context.piantala;

    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: ProfileMetrics.avatarMaxDimensionPx.toDouble(),
        maxHeight: ProfileMetrics.avatarMaxDimensionPx.toDouble(),
        imageQuality: ProfileMetrics.avatarImageQuality,
      );
      if (picked == null) return;

      setState(() => _isUploadingAvatar = true);
      final bytes = await picked.readAsBytes();
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('users/${user.uid}/avatar.jpg');
      await storageRef.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final url = await storageRef.getDownloadURL();
      await ref.read(authControllerProvider.notifier).updatePhotoUrl(url);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.profileAvatarUpdated),
          behavior: SnackBarBehavior.floating,
          backgroundColor: theme.leafGreen,
        ),
      );
    } on Exception {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.profileAvatarUpdateError),
          behavior: SnackBarBehavior.floating,
          backgroundColor: theme.terracotta,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isUploadingAvatar = false);
      }
    }
  }

  Future<void> _editName(UserEntity? user, AppLocalizations l10n) async {
    if (user == null) return;
    final currentName = _resolveDisplayName(user, l10n);
    final updated = await showEditNameDialog(
      context: context,
      initialName: currentName,
    );
    if (updated == null || !mounted) return;
    await ref.read(authControllerProvider.notifier).updateDisplayName(updated);
  }

  Future<void> _pickReminderTime(
    int hour,
    int minute,
    AppLocalizations l10n,
  ) async {
    final picked = await showReminderTimeDialog(
      context: context,
      initialHour: hour,
      initialMinute: minute,
    );
    if (picked == null || !mounted) return;
    await ref.read(reminderHourProvider.notifier).set(picked.hour);
    await ref.read(reminderMinuteProvider.notifier).set(picked.minute);
    unawaited(ref.refresh(notificationsSyncControllerProvider.future));

    if (!mounted) return;
    final formatted = '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.settingsReminderUpdated(formatted)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: context.piantala.leafGreen,
      ),
    );
  }

  Future<void> _pickLanguage(Locale currentLocale) async {
    final selected = await showLanguageDialog(
      context: context,
      initialLocale: currentLocale,
    );
    if (selected == null || !mounted) return;
    await ref.read(appLocaleProvider.notifier).setLocale(selected);
  }

  Future<void> _confirmAndDeleteAccount(AppLocalizations l10n) async {
    final confirmed = await showDeleteAccountConfirmDialog(context: context);
    if (confirmed != true || !mounted) return;

    await ref.read(authControllerProvider.notifier).deleteAccount();
    if (!mounted) return;

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
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(currentUserProvider);
    final hour = ref.watch(reminderHourProvider);
    final minute = ref.watch(reminderMinuteProvider);
    final locale = ref.watch(appLocaleProvider);

    ref.watch(notificationsSyncControllerProvider);

    final timeText = '${hour.toString().padLeft(2, '0')}:'
        '${minute.toString().padLeft(2, '0')}';
    final displayName = _resolveDisplayName(user, l10n);
    final languageLabel = locale.languageCode == 'en'
        ? l10n.profileLanguageNativeEnglish
        : l10n.profileLanguageNativeItalian;

    return MainScaffold(
      backgroundColor: theme.cream,
      waveBackdrop: theme.cream,
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            ProfileMetrics.screenHorizontalPadding,
            ProfileMetrics.screenTopPadding,
            ProfileMetrics.screenHorizontalPadding,
            ProfileMetrics.screenBottomPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: ProfileMetrics.cordAreaHeight,
                child: CustomPaint(
                  painter: CorkboardCordPainter(
                    cordColor: theme.darkWood,
                    pinColor: theme.softInk,
                    inkColor: theme.ink,
                    highlightColor: theme.cream,
                  ),
                ),
              ),
              CustomPaint(
                painter: CorkboardFramePainter(
                  woodColor: theme.floorBorder,
                  bevelLightColor: theme.paperTan,
                  bevelDarkColor: theme.darkWood,
                  inkColor: theme.ink,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(ProfileMetrics.frameBorderWidth),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        ProfileMetrics.frameInnerRadius,
                      ),
                      border: Border.all(
                        color: theme.darkWood,
                        width: AppStroke.hairline,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        ProfileMetrics.frameInnerRadius,
                      ),
                      child: CustomPaint(
                        painter: CorkboardSurfacePainter(
                          baseColor: theme.floor,
                          speckColor: theme.darkWood,
                          accentSpeckColor: theme.windowWood,
                          insetShadowColor: theme.darkWood,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            ProfileMetrics.boardPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _PolaroidCard(
                                      photoUrl: user?.photoUrl,
                                      defaultAvatarAsset: _defaultAvatarAsset,
                                      displayName: displayName,
                                      isLoading: _isUploadingAvatar,
                                      onPhotoTap: () =>
                                          _pickAndUploadAvatar(user),
                                      onNameTap: () => _editName(user, l10n),
                                    ),
                                  ),
                                  const SizedBox(width: ProfileMetrics.rowGap),
                                  Expanded(
                                    child: _ReminderPostIt(
                                      title: l10n.profileReminderPostItTitle,
                                      timeText: timeText,
                                      subtitle:
                                          l10n.profileReminderEveryMorning,
                                      onTap: () => _pickReminderTime(
                                        hour,
                                        minute,
                                        l10n,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: ProfileMetrics.sectionGap),
                              _LanguageMapCard(
                                languageLabel: languageLabel,
                                onTap: () => _pickLanguage(locale),
                              ),
                              const SizedBox(height: ProfileMetrics.sectionGap),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: _PermissionsNoteCard(
                                      title: l10n.profilePermissionsTitle,
                                      notificationsGranted:
                                          _notificationsGranted,
                                      cameraGranted: _cameraGranted,
                                      onTap: () => showPermissionsDialog(
                                        context: context,
                                        notificationsGranted:
                                            _notificationsGranted,
                                        cameraGranted: _cameraGranted,
                                        onReturnedFromSettings:
                                            _refreshPermissions,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: ProfileMetrics.rowGap),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: AppSpacing.md,
                                    ),
                                    child: VersionHangingTag(
                                      title: l10n.settingsAboutVersion,
                                      version: l10n.settingsAboutVersionNumber,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: ProfileMetrics.sectionGap),
                              _AccountStrip(
                                title: l10n.profileAccountSectionTitle,
                                subtitle: l10n.profileAccountStripSubtitle,
                                onTap: () => showAccountDialog(
                                  context: context,
                                  email: user?.email,
                                  onSignOut: () => ref
                                      .read(authControllerProvider.notifier)
                                      .signOut(),
                                  onDeleteAccount: () =>
                                      _confirmAndDeleteAccount(l10n),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PolaroidCard extends StatelessWidget {
  const _PolaroidCard({
    required this.photoUrl,
    required this.defaultAvatarAsset,
    required this.displayName,
    required this.isLoading,
    required this.onPhotoTap,
    required this.onNameTap,
  });

  final String? photoUrl;
  final String defaultAvatarAsset;
  final String displayName;
  final bool isLoading;
  final VoidCallback onPhotoTap;
  final VoidCallback onNameTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final cacheWidth = (ProfileMetrics.polaroidAvatarSize *
            MediaQuery.devicePixelRatioOf(context))
        .round();

    final fallbackAvatar = Image.asset(
      defaultAvatarAsset,
      width: ProfileMetrics.polaroidAvatarSize,
      height: ProfileMetrics.polaroidAvatarSize,
      fit: BoxFit.cover,
      cacheWidth: cacheWidth,
      errorBuilder: (_, __, ___) => ColoredBox(
        color: theme.paperTan,
        child: SizedBox(
          width: ProfileMetrics.polaroidAvatarSize,
          height: ProfileMetrics.polaroidAvatarSize,
          child: Icon(Icons.eco, color: theme.deepGreen),
        ),
      ),
    );

    return Transform.rotate(
      angle: ProfileMetrics.polaroidRotationDegrees *
          ProfileMetrics.degreesToRadians,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            painter: SketchPaperBorderPainter(
              fillColor: theme.cream,
              inkColor: theme.ink,
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                ProfileMetrics.polaroidPadding,
                ProfileMetrics.polaroidPadding,
                ProfileMetrics.polaroidPadding,
                ProfileMetrics.polaroidBottomPadding,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(
                    button: true,
                    label: displayName,
                    child: GestureDetector(
                      onTap: onPhotoTap,
                      child: Container(
                        width: double.infinity,
                        color: theme.sproutGreen,
                        padding:
                            const EdgeInsets.all(ProfileMetrics.polaroidPhotoInset),
                        child: Center(
                          child: isLoading
                              ? SizedBox(
                                  width: ProfileMetrics.polaroidAvatarSize,
                                  height: ProfileMetrics.polaroidAvatarSize,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: theme.deepGreen,
                                    ),
                                  ),
                                )
                              : ClipOval(
                                  child: photoUrl != null && photoUrl!.isNotEmpty
                                      ? Image.network(
                                          photoUrl!,
                                          width:
                                              ProfileMetrics.polaroidAvatarSize,
                                          height:
                                              ProfileMetrics.polaroidAvatarSize,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              fallbackAvatar,
                                        )
                                      : fallbackAvatar,
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: ProfileMetrics.polaroidNameSpacing),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minHeight: ProfileMetrics.polaroidMinTouchTarget,
                    ),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: onNameTap,
                      child: Center(
                        child: Text(
                          displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.h1.copyWith(
                            fontSize: ProfileMetrics.polaroidNameFontSize,
                            color: theme.ink,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -PaperComponentMetrics.decorationTopInset,
            child: Transform.rotate(
              angle: PaperComponentMetrics.tapeRotationDegrees *
                  ProfileMetrics.degreesToRadians,
              child: Container(
                width: PaperComponentMetrics.tapeWidth,
                height: PaperComponentMetrics.tapeHeight,
                decoration: BoxDecoration(
                  color: theme.sproutGreen,
                  border: Border.all(
                    color: theme.deepGreen,
                    width: AppStroke.hairline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderPostIt extends StatelessWidget {
  const _ReminderPostIt({
    required this.title,
    required this.timeText,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String timeText;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return Transform.rotate(
      angle:
          ProfileMetrics.postItRotationDegrees * ProfileMetrics.degreesToRadians,
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            CustomPaint(
              painter: PostItCurlPainter(
                fillColor: theme.postIt,
                curlColor: theme.cabinetSide,
                inkColor: theme.ink,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(ProfileMetrics.postItPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        title,
                        style: theme.body.copyWith(
                          fontSize: ProfileMetrics.postItTitleFontSize,
                          color: theme.ink,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        timeText,
                        style: theme.body.copyWith(
                          fontSize: ProfileMetrics.postItTimeFontSize,
                          color: theme.ink,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        subtitle,
                        style: theme.label.copyWith(
                          fontSize: ProfileMetrics.postItSubtitleFontSize,
                          color: theme.softInk,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: ProfileMetrics.postItPinOffset,
              child: TactilePinDot(
                fillColor: theme.terracotta,
                radius: ProfileMetrics.postItPinRadius,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageMapCard extends StatelessWidget {
  const _LanguageMapCard({
    required this.languageLabel,
    required this.onTap,
  });

  final String languageLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: ProfileMetrics.mapHeight,
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: WorldMapPainter(
                  paperColor: theme.paper,
                  foldShadeColor: theme.cabinetSide,
                  landColor: theme.sage,
                  coastColor: theme.leafGreen,
                  inkColor: theme.ink,
                  accentColor: theme.terracotta,
                  leftPinColor: theme.terracotta,
                  rightPinColor: theme.deepGreen,
                  highlightColor: theme.cream,
                ),
              ),
            ),
            Positioned(
              right: ProfileMetrics.mapPillRightOffset,
              top: ProfileMetrics.mapPillTopOffset,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: ProfileMetrics.mapPillDotSize,
                    height: ProfileMetrics.mapPillDotSize,
                    decoration: BoxDecoration(
                      color: theme.terracotta,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: theme.ink,
                        width: AppStroke.hairline,
                      ),
                    ),
                  ),
                  const SizedBox(width: ProfileMetrics.mapPillGap),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ProfileMetrics.mapPillHorizontalPadding,
                      vertical: ProfileMetrics.mapPillVerticalPadding,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cream,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(
                        color: theme.ink,
                        width: AppStroke.hairline,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: theme.ink.withValues(
                            alpha: ProfileMetrics.itemDropShadowOpacity,
                          ),
                          offset: const Offset(
                            ProfileMetrics.itemDropShadowOffset,
                            ProfileMetrics.itemDropShadowOffset,
                          ),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          languageLabel,
                          style: theme.body.copyWith(
                            fontSize: ProfileMetrics.mapPillFontSize,
                            color: theme.ink,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: ProfileMetrics.chevronSize,
                          color: theme.ink,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionsNoteCard extends StatelessWidget {
  const _PermissionsNoteCard({
    required this.title,
    required this.notificationsGranted,
    required this.cameraGranted,
    required this.onTap,
  });

  final String title;
  final bool notificationsGranted;
  final bool cameraGranted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: SketchPaperBorderPainter(
          fillColor: theme.cream,
          inkColor: theme.ink,
        ),
        child: Padding(
          padding: const EdgeInsets.all(ProfileMetrics.permissionsCardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: theme.h1.copyWith(
                        fontSize: ProfileMetrics.permissionsTitleFontSize,
                        color: theme.ink,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    size: ProfileMetrics.chevronSize,
                    color: theme.ink,
                  ),
                ],
              ),
              const SizedBox(height: ProfileMetrics.permissionsTitleRowGap),
              _PermissionSummaryRow(
                active: notificationsGranted,
                name: l10n.profilePermissionNotificationsName,
                status: notificationsGranted
                    ? l10n.profilePermissionNotificationsActive
                    : l10n.profilePermissionNotificationsInactive,
              ),
              const SizedBox(height: ProfileMetrics.permissionsRowSpacing),
              _PermissionSummaryRow(
                active: cameraGranted,
                name: l10n.profilePermissionCameraName,
                status: cameraGranted
                    ? l10n.profilePermissionCameraGranted
                    : l10n.profilePermissionCameraNotAsked,
              ),
              const SizedBox(height: ProfileMetrics.permissionsRowSpacing),
              _PermissionSummaryRow(
                active: false,
                name: l10n.profilePermissionLocationName,
                status: l10n.profilePermissionLocationUnused,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PermissionSummaryRow extends StatelessWidget {
  const _PermissionSummaryRow({
    required this.active,
    required this.name,
    required this.status,
  });

  final bool active;
  final String name;
  final String status;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PermissionStatusDisc(active: active),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.body.copyWith(
                  fontSize: ProfileMetrics.permissionsLabelFontSize,
                  color: theme.ink,
                ),
              ),
              Text(
                status,
                style: theme.label.copyWith(
                  fontSize: ProfileMetrics.permissionsStatusFontSize,
                  color: theme.softInk,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountStrip extends StatelessWidget {
  const _AccountStrip({
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;

    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: SketchPaperBorderPainter(
          fillColor: theme.paper,
          inkColor: theme.ink,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ProfileMetrics.accountStripPaddingH,
            vertical: ProfileMetrics.accountStripPaddingV,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.label.copyWith(
                        fontSize: ProfileMetrics.accountStripTitleFontSize,
                        color: theme.softInk,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.body.copyWith(
                        fontSize: ProfileMetrics.accountStripSubtitleFontSize,
                        color: theme.ink,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: ProfileMetrics.chevronSize,
                color: theme.ink,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
