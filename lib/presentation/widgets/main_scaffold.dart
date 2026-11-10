import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:piantala/presentation/screens/rooms/widgets/room_dialog.dart';
import 'package:piantala/presentation/widgets/common/piantala_navigation_bar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final isRoomsRoute = location == '/rooms';
    final selectedIndex = switch (true) {
      _ when location.startsWith('/rooms') => 1,
      _ when location.startsWith('/encyclopedia') => 2,
      _ when location.startsWith('/settings') => 3,
      _ => 0,
    };

    return Scaffold(
      body: child,
      bottomNavigationBar: PiantalaNavigationBar(
        selectedIndex: selectedIndex,
        isRoomsRoute: isRoomsRoute,
        onDestinationSelected: (index) {
          final route = switch (index) {
            0 => '/',
            1 => '/rooms',
            2 => '/encyclopedia',
            _ => '/settings',
          };
          context.go(route);
        },
        onCreatePressed: () {
          if (isRoomsRoute) {
            showDialog<void>(
              context: context,
              builder: (context) => const RoomDialog(),
            );
          } else {
            context.go('/plants/add');
          }
        },
      ),
    );
  }
}
