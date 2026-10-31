import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/rooms/widgets/room_dialog.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

class RoomsScreen extends ConsumerWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final roomsAsync = ref.watch(roomsProvider);
    final counts = ref.watch(roomsWithPlantsCountProvider);

    return MainScaffold(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              'Stanze',
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
              child: Center(child: Text('Errore: $err')),
            ),
            data: (rooms) {
              if (rooms.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.door_front_door_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nessuna stanza creata.',
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            showDialog<void>(
                              context: context,
                              builder: (context) => const RoomDialog(),
                            );
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Aggiungi Stanza'),
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
                            'Esposizione: ${room.exposure} • '
                            'Piante: $plantCount',
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
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Modifica'),
                              ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  'Elimina',
                                  style: TextStyle(color: AppColors.error),
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
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Elimina Stanza'),
          content: Text(
            plantCount > 0
                ? 'Questa stanza contiene $plantCount piante! Eliminandola, '
                    'le piante diventeranno "Senza Stanza". Vuoi procedere?'
                : 'Sei sicuro di voler eliminare la stanza "${room.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annulla'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
              child:
                  const Text('Elimina', style: TextStyle(color: Colors.white)),
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
