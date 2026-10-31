import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:piantala/data/services/fcm_service.dart';
import 'package:piantala/presentation/providers/auth_providers.dart';
import 'package:piantala/presentation/providers/notification_providers.dart';
import 'package:piantala/presentation/providers/theme_providers.dart';
import 'package:piantala/router.dart';

class PiantalaApp extends ConsumerWidget {
  const PiantalaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = ref.watch(appThemeDataProvider);
    final router = ref.watch(routerProvider);

    // Osserva lo stato di autenticazione per inizializzare FCM dopo il login
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser != null) {
      // Carica le impostazioni notifiche salvate (solo una volta)
      ref.read(reminderHourProvider.notifier).loadFromPrefs();
      ref.read(reminderMinuteProvider.notifier).loadFromPrefs();

      // Avvia FCM token management (idempotente, safe da richiamare)
      FcmService.instance.init();

      // Attiva il controller di sincronizzazione delle notifiche
      ref.watch(notificationsSyncControllerProvider);
    }

    return MaterialApp.router(
      title: 'Piantala',
      theme: themeData,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      // Localizzazione — italiano di default, predisposto per EN
      locale: const Locale('it'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('it'),
        Locale('en'),
      ],
    );
  }
}
