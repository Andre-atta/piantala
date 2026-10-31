import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_device_compass/flutter_device_compass.dart';

class CompassScannerDialog extends StatefulWidget {
  const CompassScannerDialog({super.key});

  @override
  State<CompassScannerDialog> createState() => _CompassScannerDialogState();
}

class _CompassScannerDialogState extends State<CompassScannerDialog> {
  StreamSubscription<CompassEvent>? _compassSub;
  Timer? _stabilizationTimer;

  double? _currentHeading;
  double? _referenceHeading;

  bool _isLocked = false;
  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    _startListening();
  }

  @override
  void dispose() {
    _compassSub?.cancel();
    _stabilizationTimer?.cancel();
    super.dispose();
  }

  void _startListening() {
    _compassSub = FlutterCompass.events?.listen((event) {
      if (_isLocked || event.heading == null) return;

      final heading = event.heading!;
      setState(() => _currentHeading = heading);

      if (_referenceHeading == null ||
          _calculateDifference(heading, _referenceHeading!) > 10) {
        _referenceHeading = heading;
        _resetTimer();
      }
    });
  }

  double _calculateDifference(double h1, double h2) {
    final diff = (h1 - h2).abs();
    return diff > 180 ? 360 - diff : diff;
  }

  void _resetTimer() {
    _stabilizationTimer?.cancel();
    setState(() => _countdown = 3);

    _stabilizationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        setState(() => _isLocked = true);
      }
    });
  }

  String _getDirection(double heading) {
    final h = heading < 0 ? heading + 360 : heading;
    if (h >= 337.5 || h < 22.5) return 'N';
    if (h >= 22.5 && h < 67.5) return 'NE';
    if (h >= 67.5 && h < 112.5) return 'E';
    if (h >= 112.5 && h < 157.5) return 'SE';
    if (h >= 157.5 && h < 202.5) return 'S';
    if (h >= 202.5 && h < 247.5) return 'SW';
    if (h >= 247.5 && h < 292.5) return 'W';
    if (h >= 292.5 && h < 337.5) return 'NW';
    return 'UNKNOWN';
  }

  @override
  Widget build(BuildContext context) {
    final direction =
        _currentHeading != null ? _getDirection(_currentHeading!) : '--';

    return AlertDialog(
      title: const Text('Rilevamento Esposizione', textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_currentHeading == null)
            const CircularProgressIndicator()
          else ...[
            if (_isLocked)
              const Icon(Icons.check_circle, color: Colors.green, size: 60)
            else
              Transform.rotate(
                angle: _currentHeading! * (math.pi / 180) * -1,
                child: const Icon(
                  Icons.navigation,
                  size: 80,
                  color: Colors.deepPurple,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              _isLocked ? 'Direzione Rilevata' : 'Punta verso la finestra',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              direction,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            if (!_isLocked)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  'Tieni fermo per: $_countdown s',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ],
      ),
      actions: [
        if (!_isLocked)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annulla'),
          )
        else ...[
          TextButton(
            onPressed: () {
              setState(() {
                _isLocked = false;
                _referenceHeading = null;
              });
            },
            child: const Text('Riprova'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(direction),
            child: const Text('Salva Posizione'),
          ),
        ],
      ],
    );
  }
}
