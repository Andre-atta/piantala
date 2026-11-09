import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/core/theme/app_colors.dart';
import 'package:piantala/core/theme/temporal_theme.dart';
import 'package:piantala/l10n/app_localizations.dart';
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

  List<_TabItem> _buildTabs(AppLocalizations? l10n) => [
        _TabItem(
          label: l10n?.navHome ?? 'Mensola',
          icon: Icons.local_florist_outlined,
          activeIcon: Icons.local_florist,
          route: '/',
        ),
        _TabItem(
          label: l10n?.navRooms ?? 'Stanze',
          icon: Icons.door_front_door_outlined,
          activeIcon: Icons.door_front_door,
          route: '/rooms',
        ),
        _TabItem(
          label: l10n?.navEncyclopedia ?? 'Enciclopedia',
          icon: Icons.menu_book_outlined,
          activeIcon: Icons.menu_book,
          route: '/encyclopedia',
        ),
        _TabItem(
          label: l10n?.navSettings ?? 'Impostazioni',
          icon: Icons.settings_outlined,
          activeIcon: Icons.settings,
          route: '/settings',
        ),
      ];

  void _onTabTapped(int index, List<_TabItem> tabs) {
    context.go(tabs[index].route);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;
    final l10n = AppLocalizations.of(context);
    final tabs = _buildTabs(l10n);

    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        heroTag: 'add_plant_fab',
        onPressed: () => context.go('/plants/add'),
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: const Icon(Icons.add, size: 28),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (i) => _onTabTapped(i, tabs),
        backgroundColor: theme.scaffoldBackgroundColor,
        indicatorColor: accentColor.withAlpha(30),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: tabs
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
    final l10n = AppLocalizations.of(context);

    final greeting = _localizedGreeting(period, l10n);
    final greetingText = name != null ? '$greeting, $name!' : '$greeting!';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          greetingText,
          style: theme.textTheme.titleLarge?.copyWith(
            fontFamily: 'DMSerifDisplay',
            color: textColor,
            height: 1.2,
          ),
        ),
        Text(
          _localizedSubtitle(period, l10n),
          style: theme.textTheme.bodySmall?.copyWith(
            color: textColor.withAlpha(153),
          ),
        ),
      ],
    );
  }

  String _localizedGreeting(TemporalPeriod p, AppLocalizations? l10n) {
    if (l10n == null) return p.greeting;
    return switch (p) {
      TemporalPeriod.night => l10n.greetingNight,
      TemporalPeriod.dawn => l10n.greetingDawn,
      TemporalPeriod.day => l10n.greetingDay,
      TemporalPeriod.dusk => l10n.greetingDusk,
      TemporalPeriod.evening => l10n.greetingEvening,
    };
  }

  String _localizedSubtitle(TemporalPeriod p, AppLocalizations? l10n) {
    if (l10n == null) return _defaultSubtitle(p);
    return switch (p) {
      TemporalPeriod.night => l10n.greetingSubtitleNight,
      TemporalPeriod.dawn => l10n.greetingSubtitleDawn,
      TemporalPeriod.day => l10n.greetingSubtitleDay,
      TemporalPeriod.dusk => l10n.greetingSubtitleDusk,
      TemporalPeriod.evening => l10n.greetingSubtitleEvening,
    };
  }

  String _defaultSubtitle(TemporalPeriod p) => switch (p) {
        TemporalPeriod.night => 'Anche di notte le tue piante crescono 🌙',
        TemporalPeriod.dawn => 'Buon inizio giornata con le tue piante',
        TemporalPeriod.day => 'Come stanno le tue piante oggi?',
        TemporalPeriod.dusk => 'Ottimo momento per controllare le tue piante',
        TemporalPeriod.evening => 'Pianifica la cura di domani',
      };
}
