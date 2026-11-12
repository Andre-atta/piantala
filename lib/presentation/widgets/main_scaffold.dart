import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:piantala/presentation/widgets/common/piantala_navigation_bar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    required this.child,
    this.waveBackdrop,
    this.backgroundColor,
    this.onCreateRoom,
    super.key,
  });

  final Widget child;
  final Color? waveBackdrop;
  final Color? backgroundColor;
  final VoidCallback? onCreateRoom;

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final isRoomsRoute = onCreateRoom != null;
    final selectedIndex = switch (true) {
      _ when location.startsWith('/rooms') => 1,
      _ when location.startsWith('/encyclopedia') => 2,
      _ when location.startsWith('/settings') => 3,
      _ => 0,
    };

    return Scaffold(
      backgroundColor: backgroundColor,
      body: child,
      bottomNavigationBar: PiantalaNavigationBar(
        selectedIndex: selectedIndex,
        isRoomsRoute: isRoomsRoute,
        waveBackdrop: waveBackdrop,
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
            onCreateRoom?.call();
          } else {
            context.go('/plants/add');
          }
        },
      ),
    );
  }
}
