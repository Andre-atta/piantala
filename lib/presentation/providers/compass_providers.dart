import 'package:flutter_device_compass/flutter_device_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final AutoDisposeStreamProvider<double?> compassHeadingStreamProvider = StreamProvider.autoDispose<double?>(
  (ref) {
    final events = FlutterCompass.events;
    if (events == null) return const Stream<double?>.empty();
    return events.map((event) => event.heading);
  },
);
