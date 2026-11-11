import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_dialog.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_paper_card.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_paper_card_metrics.dart';
import 'package:piantala/presentation/widgets/common/hanging_tag.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog.dart';
import 'package:piantala/presentation/widgets/common/paper_dialog_scaffold.dart';
import 'package:piantala/presentation/widgets/common/torn_paper_sheet.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

enum _RoomAction { edit, delete }

class RoomsScreen extends ConsumerWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.piantala;
    final roomsAsync = ref.watch(roomsProvider);
    final counts = ref.watch(roomsWithPlantsCountProvider);
    final l10n = AppLocalizations.of(context)!;

    return MainScaffold(
      backgroundColor: theme.cream,
      onCreateRoom: () => showPaperDialog<void>(
        context: context,
        builder: (context) => const RoomDialog(),
      ),
      child: SafeArea(
        child: roomsAsync.when(
          loading: () => const Center(child: _LoadingDots()),
          error: (error, stackTrace) => Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: TornPaperSheet(
                color: TornPaperColor.cream,
                decoration: TornPaperDecoration.tape,
                child: Text(
                  l10n.homeErrorLoading(error.toString()),
                  textAlign: TextAlign.center,
                  style: theme.body.copyWith(color: theme.ink),
                ),
              ),
            ),
          ),
          data: (rooms) {
            if (rooms.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: RoomPaperCardMetrics.listHorizontalPadding,
                  ),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: RoomPaperCardMetrics.emptySheetMaxWidth,
                    ),
                    child: TornPaperSheet(
                      color: TornPaperColor.cream,
                      decoration: TornPaperDecoration.tape,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            l10n.roomsEmptyTitle,
                            textAlign: TextAlign.center,
                            style: theme.h1.copyWith(
                              color: theme.deepGreen,
                              fontSize: RoomPaperCardMetrics.emptyTitleFontSize,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            l10n.roomsEmptyHint,
                            textAlign: TextAlign.center,
                            style: theme.body.copyWith(color: theme.ink),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(
                RoomPaperCardMetrics.listHorizontalPadding,
                RoomPaperCardMetrics.listTopPadding,
                RoomPaperCardMetrics.listHorizontalPadding,
                RoomPaperCardMetrics.listBottomPadding,
              ),
              itemCount: rooms.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: RoomPaperCardMetrics.listCardSpacing),
              itemBuilder: (context, index) {
                final room = rooms[index];
                final plantCount = counts[room.id] ?? 0;
                return RoomPaperCard(
                  room: room,
                  plantCount: plantCount,
                  onOptionsPressed: () async {
                    final action = await showPaperDialog<_RoomAction>(
                      context: context,
                      builder: (dialogContext) => _RoomOptionsDialog(
                        roomName: room.name,
                        onEdit: () =>
                            Navigator.of(dialogContext).pop(_RoomAction.edit),
                        onDelete: () =>
                            Navigator.of(dialogContext).pop(_RoomAction.delete),
                      ),
                    );
                    if (!context.mounted) return;
                    switch (action) {
                      case _RoomAction.edit:
                        await showPaperDialog<void>(
                          context: context,
                          builder: (context) => RoomDialog(room: room),
                        );
                      case _RoomAction.delete:
                        await _confirmDelete(
                          context,
                          ref,
                          room,
                          plantCount,
                        );
                      case null:
                        break;
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    RoomEntity room,
    int plantCount,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showPaperDialog<bool>(
      context: context,
      builder: (dialogContext) => PaperDialogScaffold(
        title: l10n.roomsDeleteDialogTitle,
        actions: [
          HangingTag(
            label: l10n.commonCancel,
            variant: HangingTagVariant.secondary,
            mirrored: true,
            onPressed: () => Navigator.of(dialogContext).pop(false),
          ),
          HangingTag(
            label: l10n.commonDelete,
            variant: HangingTagVariant.danger,
            onPressed: () => Navigator.of(dialogContext).pop(true),
          ),
        ],
        child: Text(
          plantCount > 0
              ? l10n.roomsDeleteWarning(plantCount)
              : l10n.roomsDeleteConfirm(room.name),
          style: context.piantala.body.copyWith(color: context.piantala.ink),
        ),
      ),
    );

    if (confirm != true) return;

    final roomRepo = ref.read(roomRepositoryProvider);
    if (plantCount > 0) {
      final plantRepo = ref.read(plantRepositoryProvider);
      final plants = ref.read(plantsProvider).valueOrNull ?? [];
      for (final plant in plants.where((plant) => plant.roomId == room.id)) {
        await plantRepo.updatePlant(plant.copyWith(roomId: 'unassigned'));
      }
    }

    await roomRepo.deleteRoom(room.id);
  }
}

class _RoomOptionsDialog extends StatelessWidget {
  const _RoomOptionsDialog({
    required this.roomName,
    required this.onEdit,
    required this.onDelete,
  });

  final String roomName;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      container: true,
      label: roomName,
      child: Material(
        type: MaterialType.transparency,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: RoomPaperCardMetrics.optionsDialogTop,
              left: RoomPaperCardMetrics.optionsDialogHorizontalMargin,
              right: RoomPaperCardMetrics.optionsDialogHorizontalMargin,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: RoomPaperCardMetrics.optionsDialogMaxWidth,
                ),
                child: TornPaperSheet(
                  color: TornPaperColor.cream,
                  decoration: TornPaperDecoration.tape,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        roomName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.h1.copyWith(
                          color: theme.deepGreen,
                          fontSize:
                              RoomPaperCardMetrics.optionsDialogTitleFontSize,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      _RoomOptionRow(
                        label: l10n.commonEdit,
                        onPressed: onEdit,
                      ),
                      Divider(
                        height: AppStroke.hairline,
                        thickness: AppStroke.hairline,
                        color: theme.ink.withValues(alpha: 0.4),
                      ),
                      _RoomOptionRow(
                        label: l10n.commonDelete,
                        color: theme.terracotta,
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoomOptionRow extends StatelessWidget {
  const _RoomOptionRow({
    required this.label,
    required this.onPressed,
    this.color,
  });

  final String label;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      onTap: onPressed,
      child: ExcludeSemantics(
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            height: RoomPaperCardMetrics.optionsDialogRowHeight,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                label,
                style: context.piantala.body.copyWith(
                  color: color ?? context.piantala.ink,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingDots extends StatefulWidget {
  const _LoadingDots();

  @override
  State<_LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<_LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: RoomPaperCardMetrics.loadingAnimationMilliseconds,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _controller
        ..stop()
        ..value = 0;
    } else {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.piantala;
    final disableAnimations = MediaQuery.of(context).disableAnimations;

    return Semantics(
      label: AppLocalizations.of(context)!.commonLoading,
      child: ExcludeSemantics(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final activeDot = disableAnimations
                ? null
                : (_controller.value * 3).floor().clamp(0, 2);
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var index = 0; index < 3; index++) ...[
                  if (index > 0)
                    const SizedBox(
                      width: RoomPaperCardMetrics.loadingDotSpacing,
                    ),
                  Opacity(
                    opacity: activeDot == null || activeDot == index ? 1 : 0.25,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.leafGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const SizedBox(
                        width: RoomPaperCardMetrics.loadingDotSize,
                        height: RoomPaperCardMetrics.loadingDotSize,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
