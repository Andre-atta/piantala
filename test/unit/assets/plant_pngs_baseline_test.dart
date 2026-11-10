import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('plant PNGs have no substantial transparent strip under the art',
      () async {
    final directory = Directory(
      'assets${Platform.pathSeparator}illustrations'
      '${Platform.pathSeparator}plants',
    );
    final files = directory
        .listSync()
        .whereType<File>()
        .where((file) => file.path.toLowerCase().endsWith('.png'))
        .toList()
      ..sort((first, second) => first.path.compareTo(second.path));

    expect(files, isNotEmpty);
    for (final file in files) {
      final codec = await ui.instantiateImageCodec(await file.readAsBytes());
      final frame = await codec.getNextFrame();
      try {
        final image = frame.image;
        final pixels = (await image.toByteData())!;
        expect(
          _hasVisiblePixelInBottomRows(pixels, image.width, image.height),
          isTrue,
          reason: '${file.path} has too much transparent space at the bottom',
        );
      } finally {
        frame.image.dispose();
        codec.dispose();
      }
    }
  });
}

bool _hasVisiblePixelInBottomRows(
  ByteData pixels,
  int width,
  int height,
) {
  for (var y = height - 1; y >= height - 2 && y >= 0; y--) {
    for (var x = 0; x < width; x++) {
      if (pixels.getUint8((y * width + x) * 4 + 3) > 20) return true;
    }
  }
  return false;
}
