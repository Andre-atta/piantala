import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piantala/data/services/notification_service.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/screens/add_plant/add_plant_screen.dart';
import 'package:piantala/presentation/screens/encyclopedia/encyclopedia_screen.dart';
import 'package:piantala/presentation/screens/encyclopedia/species_detail_screen.dart';
import 'package:piantala/presentation/screens/home/home_screen.dart';
import 'package:piantala/presentation/screens/login/login_screen.dart';
import 'package:piantala/presentation/screens/plant_detail/plant_detail_screen.dart';
import 'package:piantala/presentation/screens/rooms/rooms_screen.dart';
import 'package:piantala/presentation/screens/settings/settings_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

// ─── Route names (costanti, usare SEMPRE questi) ─────────────────────────────
abstract class AppRoute {
  static const login = '/login';
  static const home = '/';
  static const plantDetail = '/plants/:plantId';
  static const addPlant = '/plants/add';
  static const encyclopedia = '/encyclopedia';
  static const settings = '/settings';
  static const rooms = '/rooms';
}

@riverpod
GoRouter router(RouterRef ref) {
  // Ascolta lo stato auth per i redirect
  final authState = ref.watch(authStateProvider);

  final router = GoRouter(
    initialLocation: AppRoute.home,
    debugLogDiagnostics: true,

    // ── Auth Guard ──────────────────────────────────────────────
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isLoggingIn = state.matchedLocation == AppRoute.login;

      if (!isLoggedIn && !isLoggingIn) return AppRoute.login;
      if (isLoggedIn && isLoggingIn) return AppRoute.home;
      return null;
    },

    // ── Routes ─────────────────────────────────────────────────
    routes: [
      // Login — fuori dallo shell
      GoRoute(
        path: AppRoute.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),

      // Shell principale con NavigationBar
      GoRoute(
        path: AppRoute.home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'plants/add',
            name: 'addPlant',
            pageBuilder: (context, state) => const MaterialPage(
              fullscreenDialog: true,
              child: AddPlantScreen(),
            ),
          ),
          GoRoute(
            path: 'plants/:plantId',
            name: 'plantDetail',
            builder: (context, state) => PlantDetailScreen(
              plantId: state.pathParameters['plantId']!,
            ),
          ),
          GoRoute(
            path: 'settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: 'encyclopedia',
            name: 'encyclopedia',
            builder: (context, state) => const EncyclopediaScreen(),
          ),
          GoRoute(
            path: 'encyclopedia/:apiId',
            name: 'speciesDetail',
            builder: (context, state) => SpeciesDetailScreen(
              apiId: state.pathParameters['apiId']!,
            ),
          ),
          GoRoute(
            path: 'rooms',
            name: 'rooms',
            builder: (context, state) => const RoomsScreen(),
          ),
        ],
      ),
    ],

    // ── Error page ─────────────────────────────────────────────
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Pagina non trovata')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🌵', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(
              'Oops, questa pagina non esiste',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    ),
  );

  // Collega il tap sulle notifiche urgenti al router
  NotificationService.instance.onNotificationTap = (plantId) {
    router.push('/plants/$plantId');
  };

  return router;
}
