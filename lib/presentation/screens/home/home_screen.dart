import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/build_context_extensions.dart';
import 'package:piantala/core/utils/exposure_localization.dart';
import 'package:piantala/core/utils/plant_asset_resolver.dart';
import 'package:piantala/domain/entities/plant_entity.dart';
import 'package:piantala/domain/entities/room_entity.dart';
import 'package:piantala/l10n/app_localizations.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/room_providers.dart';
import 'package:piantala/presentation/screens/home/home_metrics.dart';
import 'package:piantala/presentation/screens/home/widgets/home_floor.dart';
import 'package:piantala/presentation/screens/home/widgets/home_header.dart';
import 'package:piantala/presentation/screens/home/widgets/shelf_cabinet.dart';
import 'package:piantala/presentation/screens/home/widgets/window_indicator.dart';
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
    final plantsAsync = ref.watch(plantsProvider);
    final roomsAsync = ref.watch(roomsProvider);
    final localizations = AppLocalizations.of(context)!;
    final plants = plantsAsync.valueOrNull ?? <PlantEntity>[];
    final rooms = roomsAsync.valueOrNull ?? <RoomEntity>[];
    final pages = _buildPages(rooms, plants, localizations);
    if (pages.isEmpty) {
      pages.add(
        _ShelfPageData(
          label: localizations.homeLabelAllPlants,
          plants: const [],
          room: null,
        ),
      );
    }
    final currentPage = _currentPage.clamp(0, pages.length - 1);
    final activePage = pages[currentPage];
    final nextPage =
        pages.length > 1 ? pages[(currentPage + 1) % pages.length] : null;
    final isLoading = plantsAsync.isLoading || roomsAsync.isLoading;
    final plantsFailedWithoutData =
        plantsAsync.hasError && plantsAsync.valueOrNull == null;

    return MainScaffold(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            PlantAssetResolver.wallBackground(),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => ColoredBox(
              color: context.piantala.stickWoodAndReserveWall,
            ),
          ),
          Column(
            children: [
              HomeHeader(
                roomName: activePage.label,
                nextRoomName: nextPage?.label,
                plantCount: activePage.plants.length,
                exposure: localizedExposure(
                  activePage.room?.exposure ?? 'UNKNOWN',
                  localizations,
                ),
                currentPage: currentPage,
                pageCount: pages.length,
                onNextRoomTap: () => _selectPage(
                  context,
                  (currentPage + 1) % pages.length,
                ),
                onPageSelected: (index) => _selectPage(context, index),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: HomeMetrics.floorHeight,
                  ),
                  child: _buildPageContent(
                    context: context,
                    pages: pages,
                    isLoading: isLoading,
                    plantsFailedWithoutData: plantsFailedWithoutData,
                    plantsError: plantsAsync.error,
                  ),
                ),
              ),
            ],
          ),
          const Positioned(
            top: HomeMetrics.windowTop,
            right: HomeMetrics.windowRight,
            child: WindowIndicator(),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: HomeFloor(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required BuildContext context,
    required List<_ShelfPageData> pages,
    required bool isLoading,
    required bool plantsFailedWithoutData,
    required Object? plantsError,
  }) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(context.piantala.leafGreen),
        ),
      );
    }

    if (plantsFailedWithoutData) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.homeErrorLoading(
            plantsError.toString(),
          ),
          style: context.piantala.body.copyWith(
            color: context.piantala.ink,
          ),
        ),
      );
    }

    if (pages.length == 1) {
      return _ShelfPage(
        page: pages.first,
        onPlantTap: _openPlant,
      );
    }

    return PageView.builder(
      controller: _pageController,
      itemCount: pages.length,
      onPageChanged: (index) => setState(() => _currentPage = index),
      itemBuilder: (context, index) => _ShelfPage(
        page: pages[index],
        onPlantTap: _openPlant,
      ),
    );
  }

  void _selectPage(BuildContext context, int page) {
    if (page == _currentPage) return;
    final duration = MediaQuery.of(context).disableAnimations
        ? Duration.zero
        : const Duration(
            milliseconds: HomeMetrics.pageTransitionMilliseconds,
          );
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: duration,
        curve: Curves.easeInOut,
      );
    } else {
      setState(() => _currentPage = page);
    }
  }

  void _openPlant(PlantEntity plant) => context.go('/plants/${plant.id}');

  List<_ShelfPageData> _buildPages(
    List<RoomEntity> rooms,
    List<PlantEntity> plants,
    AppLocalizations localizations,
  ) {
    final pages = <_ShelfPageData>[];
    for (final room in rooms) {
      pages.add(
        _ShelfPageData(
          label: room.name,
          plants: plants.where((plant) => plant.roomId == room.id).toList(),
          room: room,
        ),
      );
    }

    final knownRoomIds = rooms.map((room) => room.id).toSet();
    final unassigned = plants
        .where(
          (plant) =>
              plant.roomId == 'unassigned' ||
              plant.roomId.isEmpty ||
              !knownRoomIds.contains(plant.roomId),
        )
        .toList();
    if (unassigned.isNotEmpty) {
      pages.add(
        _ShelfPageData(
          label: localizations.homeLabelUnassigned,
          plants: unassigned,
          room: null,
        ),
      );
    }

    if (pages.isEmpty && plants.isNotEmpty) {
      pages.add(
        _ShelfPageData(
          label: localizations.homeLabelAllPlants,
          plants: plants,
          room: null,
        ),
      );
    }
    return pages;
  }
}

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

class _ShelfPage extends StatelessWidget {
  const _ShelfPage({
    required this.page,
    required this.onPlantTap,
  });

  final _ShelfPageData page;
  final ValueChanged<PlantEntity> onPlantTap;

  @override
  Widget build(BuildContext context) {
    if (page.plants.isEmpty) {
      return page.room == null
          ? const _EmptyShelfPlaceholder()
          : _EmptyRoomPlaceholder(roomName: page.label);
    }

    return ShelfCabinet(
      plants: page.plants,
      now: DateTime.now(),
      onPlantTap: onPlantTap,
    );
  }
}

class _EmptyRoomPlaceholder extends StatelessWidget {
  const _EmptyRoomPlaceholder({required this.roomName});
  final String roomName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

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
            localizations?.homeEmptyRoomTitle(roomName) ?? '$roomName è vuota',
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'DMSerifDisplay',
              color: theme.colorScheme.onSurface.withAlpha(180),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            localizations?.homeEmptyRoomSubtitle ??
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
            label: Text(localizations?.homeButtonAddPlant ?? 'Aggiungi pianta'),
          ),
        ],
      ),
    );
  }
}

class _EmptyShelfPlaceholder extends StatelessWidget {
  const _EmptyShelfPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(AppRadius.xl),
            ),
            child: Icon(
              Icons.local_florist_outlined,
              size: 40,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            localizations?.homeEmptyShelfTitle ?? 'La tua mensola è vuota',
            style: theme.textTheme.titleMedium?.copyWith(
              fontFamily: 'DMSerifDisplay',
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            localizations?.homeEmptyShelfSubtitle ??
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
            label: Text(localizations?.homeButtonAddPlant ?? 'Aggiungi pianta'),
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
