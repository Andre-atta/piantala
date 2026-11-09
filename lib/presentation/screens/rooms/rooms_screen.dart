import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_dialog.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

class RoomsScreen extends ConsumerWidget {
  const RoomsScreen({super.key});

  String _localizedExposure(String exposure, AppLocalizations? l10n) {
    if (l10n == null) return exposure;
    return switch (exposure.toUpperCase()) {
      'NORTH' || 'NORD' => l10n.exposureNorth,
      'SOUTH' || 'SUD' => l10n.exposureSouth,
      'EAST' || 'EST' => l10n.exposureEast,
      'WEST' || 'OVEST' => l10n.exposureWest,
      _ => l10n.exposureUnknown,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final roomsAsync = ref.watch(roomsProvider);
    final counts = ref.watch(roomsWithPlantsCountProvider);
    final l10n = AppLocalizations.of(context);

    return MainScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              l10n?.roomsTitle ?? 'Stanze',
              style: theme.textTheme.titleLarge?.copyWith(
                fontFamily: 'DMSerifDisplay',
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog<void>(
                    context: context,
                    builder: (context) => const RoomDialog(),
                  );
                },
              ),
            ],
          ),
          roomsAsync.when(
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverFillRemaining(
              child: Center(
                child: Text(
                  l10n?.homeErrorLoading(err.toString()) ?? 'Errore: $err',
                ),
              ),
            ),
            data: (rooms) {
              if (rooms.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.door_front_door_outlined,
                          size: 64,
                          color: theme.colorScheme.onSurface.withAlpha(60),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          l10n?.roomsEmptyTitle ?? 'Nessuna stanza creata.',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) => const RoomDialog(),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: Text(l10n?.roomsAddButton ?? 'Aggiungi Stanza'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.all(AppSpacing.md),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final room = rooms[index];
                      final plantCount = counts[room.id] ?? 0;
                      final exposureStr = _localizedExposure(room.exposure, l10n);

                      return Card(
                        elevation: 0,
                        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
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
                            backgroundColor:
                                theme.colorScheme.primary.withAlpha(20),
                            child: Icon(
                              Icons.door_front_door,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          title: Text(
                            room.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            l10n?.roomsSubtitle(exposureStr, plantCount) ??
                                'Esposizione: $exposureStr • Piante: $plantCount',
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value == 'edit') {
                                await showDialog<void>(
                                   context: context,
                                  builder: (context) => RoomDialog(room: room),
                                );
                              } else if (value == 'delete') {
                                await _confirmDelete(
                                  context,
                                  ref,
                                  room,
                                  plantCount,
                                );
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text(l10n?.commonEdit ?? 'Modifica'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  l10n?.commonDelete ?? 'Elimina',
                                  style: const TextStyle(color: AppColors.error),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    childCount: rooms.length,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    WidgetRef ref,
    RoomEntity room,
    int plantCount,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n?.roomsDeleteDialogTitle ?? 'Elimina Stanza'),
          content: Text(
            plantCount > 0
                ? (l10n?.roomsDeleteWarning(plantCount) ??
                    'Questa stanza contiene $plantCount piante! Eliminandola, '
                    'le piante diventeranno "Senza Stanza". Vuoi procedere?')
                : (l10n?.roomsDeleteConfirm(room.name) ??
                    'Sei sicuro di voler eliminare la stanza "${room.name}"?'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n?.commonCancel ?? 'Annulla'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              child: Text(
                l10n?.commonDelete ?? 'Elimina',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );

    if (confirm ?? false) {
      final roomRepo = ref.read(roomRepositoryProvider);

      if (plantCount > 0) {
        final plantRepo = ref.read(plantRepositoryProvider);
        final plants = ref.read(plantsProvider).valueOrNull ?? [];
        for (final p in plants.where((p) => p.roomId == room.id)) {
          await plantRepo.updatePlant(p.copyWith(roomId: 'unassigned'));
        }
      }

      await roomRepo.deleteRoom(room.id);
    }
  }
}
