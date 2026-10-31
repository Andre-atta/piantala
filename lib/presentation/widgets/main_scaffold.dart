import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/presentation/providers/theme_providers.dart';

/// Shell principale dell'app autenticata con BottomNavigationBar.
/// Ogni tab è una sezione separata della navigazione.
class MainScaffold extends ConsumerStatefulWidget {
  const MainScaffold({required this.child, super.key});
  final Widget child;

  @override
  ConsumerState<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends ConsumerState<MainScaffold> {
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/rooms')) return 1;
    if (location.startsWith('/encyclopedia')) return 2;
    if (location.startsWith('/settings')) return 3;
    return 0;
  }

  static const _tabs = [
    _TabItem(
      label: 'Mensola',
      icon: Icons.local_florist_outlined,
      activeIcon: Icons.local_florist,
      route: '/',
    ),
    _TabItem(
      label: 'Stanze',
      icon: Icons.door_front_door_outlined,
      activeIcon: Icons.door_front_door,
      route: '/rooms',
    ),
    _TabItem(
      label: 'Enciclopedia',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book,
      route: '/encyclopedia',
    ),
    _TabItem(
      label: 'Impostazioni',
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings,
      route: '/settings',
    ),
  ];

  void _onTabTapped(int index) {
    context.go(_tabs[index].route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_plant_fab',
        onPressed: () => context.go('/plants/add'),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: _onTabTapped,
        backgroundColor: theme.scaffoldBackgroundColor,
        indicatorColor: accentColor.withAlpha(30),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: _tabs
            .map(
              (tab) => NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.activeIcon, color: accentColor),
                label: tab.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.route,
  });
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final String route;
}

/// TimeGreetingBanner — banner contestuale con saluto temporale.
/// Usato nella HomeScreen.
class TimeGreetingBanner extends ConsumerWidget {
  const TimeGreetingBanner({super.key, this.userName});
  final String? userName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(temporalPeriodProvider).valueOrNull ??
        TemporalPeriodX.fromHour(DateTime.now().hour);
    final theme = Theme.of(context);
    final textColor = theme.colorScheme.onSurface;
    final name = userName?.split(' ').first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name != null ? '${period.greeting}, $name!' : '${period.greeting}!',
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: 'DMSerifDisplay',
            color: textColor,
            height: 1.2,
          ),
        ),
        Text(
          _subtitle(period),
          style: theme.textTheme.bodySmall?.copyWith(
            color: textColor.withAlpha(153),
          ),
        ),
      ],
    );
  }

  String _subtitle(TemporalPeriod p) => switch (p) {
        TemporalPeriod.night => 'Anche di notte le tue piante crescono 🌙',
        TemporalPeriod.dawn => 'Buon inizio giornata con le tue piante',
        TemporalPeriod.day => 'Come stanno le tue piante oggi?',
        TemporalPeriod.dusk => 'Ottimo momento per controllare le tue piante',
        TemporalPeriod.evening => 'Pianifica la cura di domani',
      };
}
