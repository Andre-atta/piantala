import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/home/widgets/plant_shelf_view.dart';
import 'package:piantala/presentation/widgets/main_scaffold.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final plantsAsync = ref.watch(plantsProvider);
    final roomsAsync = ref.watch(roomsProvider);

    return MainScaffold(
      child: Column(
        children: [
          // ── Header: saluto temporale + badge meteo + pulsante profilo ──
          _HomeHeader(
            userName: user?.displayName,
            onProfileTap: () =>
                ref.read(authControllerProvider.notifier).signOut(),
          ),

          // ── Contenuto: stanze con swipe ─────────────────────────────────
          Expanded(
            child: plantsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text(
                  'Errore: $error',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
              data: (plants) {
                return roomsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, __) => plants.isEmpty
                      ? const _EmptyShelfPlaceholder()
                      : PlantShelfView(plants: plants),
                  data: (rooms) {
                    // Tutte le stanze + eventuale "Senza stanza"
                    final pages = _buildPages(rooms, plants);

                    if (pages.isEmpty) {
                      return const _EmptyShelfPlaceholder();
                    }

                    if (pages.length == 1) {
                      return _ShelfPage(page: pages.first);
                    }

                    return Column(
                      children: [
                        // PageView swipeable
                        Expanded(
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: pages.length,
                            onPageChanged: (i) =>
                                setState(() => _currentPage = i),
                            itemBuilder: (context, index) =>
                                _ShelfPage(page: pages[index]),
                          ),
                        ),

                        // Indicatore pallini + nome stanza corrente
                        _RoomIndicator(
                          pages: pages,
                          current: _currentPage,
                          onDotTap: (i) {
                            _pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Costruisce una pagina per OGNI stanza (anche vuota) + eventuale
  /// pagina "Senza stanza" se esistono piante non assegnate.
  List<_ShelfPageData> _buildPages(
    List<RoomEntity> rooms,
    List<PlantEntity> plants,
  ) {
    final pages = <_ShelfPageData>[];

    // Una pagina per ogni stanza — anche se non ha piante
    for (final room in rooms) {
      final roomPlants = plants.where((p) => p.roomId == room.id).toList();
      pages.add(
        _ShelfPageData(label: room.name, plants: roomPlants, room: room),
      );
    }

    // Piante non assegnate a nessuna stanza
    final unassigned = plants
        .where((p) => p.roomId == 'unassigned' || p.roomId.isEmpty)
        .toList();
    if (unassigned.isNotEmpty) {
      pages.add(
        _ShelfPageData(label: 'Senza stanza', plants: unassigned, room: null),
      );
    }

    // Nessuna stanza e nessuna pianta non assegnata:
    // mostra tutte le piante su un'unica pagina generica
    if (pages.isEmpty && plants.isNotEmpty) {
      pages.add(
        _ShelfPageData(label: 'Tutte le piante', plants: plants, room: null),
      );
    }

    return pages;
  }
}

// ── _HomeHeader ────────────────────────────────────────────────────────────
// Gestisce correttamente la status bar con SafeArea.

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({
    required this.userName,
    required this.onProfileTap,
  });

  final String? userName;
  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.sm,
          AppSpacing.sm, // ridotto per far spazio al pulsante profilo
          AppSpacing.sm,
        ),
        child: Row(
          children: [
            // Testo saluto
            Expanded(
              child: TimeGreetingBanner(userName: userName),
            ),

            // Pulsante profilo/logout
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: onProfileTap,
              tooltip: 'Logout',
            ),
          ],
        ),
      ),
    );
  }
}

// ── _ShelfPageData ─────────────────────────────────────────────────────────

class _ShelfPageData {
  const _ShelfPageData({
    required this.label,
    required this.plants,
    required this.room,
  });

  final String label;
  final List<PlantEntity> plants;
  final RoomEntity? room;
}

// ── _ShelfPage ─────────────────────────────────────────────────────────────

class _ShelfPage extends ConsumerWidget {
  const _ShelfPage({required this.page});
  final _ShelfPageData page;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Alert esposizione S.04
        if (page.room != null && page.room!.exposure != 'UNKNOWN')

          // Mensola
          if (page.plants.isEmpty)
            Expanded(child: _EmptyRoomPlaceholder(roomName: page.label))
          else
            Expanded(child: PlantShelfView(plants: page.plants)),
      ],
    );
  }
}

// ── _RoomIndicator ─────────────────────────────────────────────────────────
// Pallini + label del nome stanza corrente con tappabili.

class _RoomIndicator extends StatelessWidget {
  const _RoomIndicator({
    required this.pages,
    required this.current,
    required this.onDotTap,
  });

  final List<_ShelfPageData> pages;
  final int current;
  final ValueChanged<int> onDotTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = theme.colorScheme.primary;
    final inactiveColor = theme.colorScheme.onSurface.withAlpha(60);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Nome della stanza corrente
        Text(
          pages[current].label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(180),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),

        // Pallini
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(pages.length, (i) {
            final isActive = i == current;
            return GestureDetector(
              onTap: () => onDotTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: isActive ? 20 : 7,
                height: 7,
                decoration: BoxDecoration(
                  color: isActive ? activeColor : inactiveColor,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

// ── _EmptyRoomPlaceholder ─────────────────────────────────────────────────
// Mostrato quando una stanza esiste ma non ha piante.

class _EmptyRoomPlaceholder extends StatelessWidget {
  const _EmptyRoomPlaceholder({required this.roomName});
  final String roomName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.door_front_door_outlined,
            size: 56,
            color: theme.colorScheme.onSurface.withAlpha(60),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '$roomName è vuota',
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'DMSerifDisplay',
              color: theme.colorScheme.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Aggiungi una pianta e assegnala\na questa stanza',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(120),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton.icon(
            onPressed: () => context.go('/plants/add'),
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Aggiungi pianta'),
          ),
        ],
      ),
    );
  }
}

// ── _EmptyShelfPlaceholder ────────────────────────────────────────────────
// Mostrato quando non ci sono piante in tutta l'app.

class _EmptyShelfPlaceholder extends StatelessWidget {
  const _EmptyShelfPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.local_florist_outlined,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'La tua mensola è vuota',
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'DMSerifDisplay',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Aggiungi la tua prima pianta\ncon il bottone +',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withAlpha(153),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          FilledButton.icon(
            onPressed: () => context.go('/plants/add'),
            icon: const Icon(Icons.add),
            label: const Text('Aggiungi pianta'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
