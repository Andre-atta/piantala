import 'package:piantala/data/services/notification_service.dart';
import 'package:piantala/presentation/providers/plant_providers.dart';
import 'package:piantala/presentation/providers/scheduling_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notification_providers.g.dart';

const _kReminderHourKey = 'reminder_hour';
const _kReminderMinuteKey = 'reminder_minute';

@Riverpod(keepAlive: true)
class ReminderHour extends _$ReminderHour {
  @override
  int build() => 9;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(_kReminderHourKey) ?? 9;
  }

  Future<void> set(int hour) async {
    state = hour;
    await (await SharedPreferences.getInstance())
        .setInt(_kReminderHourKey, hour);
  }
}

@Riverpod(keepAlive: true)
class ReminderMinute extends _$ReminderMinute {
  @override
  int build() => 0;

  Future<void> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getInt(_kReminderMinuteKey) ?? 0;
  }

  Future<void> set(int minute) async {
    state = minute;
    await (await SharedPreferences.getInstance())
        .setInt(_kReminderMinuteKey, minute);
  }
}

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) =>
    NotificationService.instance;

@riverpod
Future<void> notificationsSyncController(
  NotificationsSyncControllerRef ref,
) async {
  final service = ref.watch(notificationServiceProvider);
  final plants = ref.watch(plantsProvider).valueOrNull ?? [];
  final infos = <PlantSchedulingInfo>[];
  for (final plant in plants) {
    if (plant.isArchived) continue;
    final schedule = ref.watch(plantScheduleProvider(plant.id));
    if (schedule == null) return;
    infos.add(
      PlantSchedulingInfo(
        plantId: plant.id,
        plantName:
            plant.customName.isNotEmpty ? plant.customName : 'La tua pianta',
        cultivationMethod: plant.cultivationMethod,
        nextWateringAt: schedule.nextWateringAt,
        nextFertilizingAt: schedule.nextFertilizingAt,
      ),
    );
  }
  await service.syncAllNotificationsFromSchedule(
    schedulingInfos: infos,
    hour: ref.watch(reminderHourProvider),
    minute: ref.watch(reminderMinuteProvider),
  );
}
