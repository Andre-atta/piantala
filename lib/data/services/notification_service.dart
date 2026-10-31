import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:piantala/presentation/providers/scheduling_providers.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class NotifChannel {
  static const urgent = 'urgent';
  static const dailyReminder = 'daily_reminder';
}

const _kDailyReminderId = 0;

int plantNotifId(String plantId) => plantId.hashCode.abs() % 2147483647;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  void Function(String plantId)? onNotificationTap;

  Future<void> initialize() async {
    if (_initialized) return;
    tz.initializeTimeZones();
    try {
      final localName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (error) {
      debugPrint('Unable to set local timezone: $error');
    }

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onTap,
      onDidReceiveBackgroundNotificationResponse: _onBackgroundTap,
    );
    if (Platform.isAndroid) {
      final android = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          NotifChannel.urgent,
          'Piante urgenti',
          description: 'Notifiche per piante da innaffiare',
          importance: Importance.high,
        ),
      );
      await android?.createNotificationChannel(
        const AndroidNotificationChannel(
          NotifChannel.dailyReminder,
          'Promemoria giornaliero',
          description: 'Promemoria per le piante da innaffiare',
        ),
      );
    }
    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      return (await Permission.notification.request()).isGranted;
    }
    return await _plugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true) ??
        false;
  }

  Future<void> syncAllNotificationsFromSchedule({
    required List<PlantSchedulingInfo> schedulingInfos,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    final today = tz.TZDateTime(tz.local, now.year, now.month, now.day);
    for (var i = 0; i < 14; i++) {
      final date = today.add(Duration(days: i));
      final scheduled = tz.TZDateTime(
        tz.local,
        date.year,
        date.month,
        date.day,
        hour,
        minute,
      );
      if (scheduled.isBefore(now)) {
        await _plugin.cancel(_kDailyReminderId + i);
        continue;
      }
      final count = schedulingInfos
          .where((info) => _sameDay(info.nextWateringAt, scheduled))
          .length;
      if (count == 0) {
        await _plugin.cancel(_kDailyReminderId + i);
        continue;
      }
      await _plugin.zonedSchedule(
        _kDailyReminderId + i,
        '🌿 Momento di innaffiare!',
        count == 1
            ? '1 pianta ha bisogno di acqua oggi.'
            : '$count piante hanno bisogno di acqua oggi.',
        scheduled,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            NotifChannel.dailyReminder,
            'Promemoria giornaliero',
            channelDescription: 'Promemoria per le piante da innaffiare',
            color: Color(0xFF4CAF50),
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'daily_reminder',
      );
    }

    final activeIds = schedulingInfos.map((info) => plantNotifId(info.plantId));
    for (final info in schedulingInfos) {
      final next = tz.TZDateTime.from(info.nextWateringAt, tz.local);
      final urgent = tz.TZDateTime(
        tz.local,
        next.year,
        next.month,
        next.day,
        10,
      ).add(const Duration(days: 2));
      if (urgent.isBefore(now)) continue;
      final body = info.cultivationMethod == 'hydro'
          ? 'È ora di controllare l’acqua di ${info.plantName}.'
          : '${info.plantName} ha bisogno di acqua.';
      await _plugin.zonedSchedule(
        plantNotifId(info.plantId),
        info.cultivationMethod == 'hydro'
            ? 'Controlla l’acqua'
            : '🌵 ${info.plantName} ha sete!',
        body,
        urgent,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            NotifChannel.urgent,
            'Piante urgenti',
            channelDescription: 'Notifiche per piante da innaffiare',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: info.plantId,
      );
    }

    final pending = await _plugin.pendingNotificationRequests();
    for (final request in pending) {
      if (request.id >= _kDailyReminderId &&
          request.id < _kDailyReminderId + 14) {
        continue;
      }
      if (!activeIds.contains(request.id)) await _plugin.cancel(request.id);
    }
  }

  bool _sameDay(DateTime event, tz.TZDateTime scheduled) {
    final local = tz.TZDateTime.from(event, tz.local);
    return local.year == scheduled.year &&
        local.month == scheduled.month &&
        local.day == scheduled.day;
  }

  void _onTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty && payload != 'daily_reminder') {
      onNotificationTap?.call(payload);
    }
  }
}

@pragma('vm:entry-point')
void _onBackgroundTap(NotificationResponse response) {
  debugPrint('Background notification tap: ${response.payload}');
}
