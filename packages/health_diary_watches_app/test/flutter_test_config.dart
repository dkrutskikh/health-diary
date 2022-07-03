import 'dart:async';

import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

const _devices = [
  Device(
    size: Size(360, 360),
    devicePixelRatio: 1.25,
    name: 'Samsung SM-R850',
  ),
];

Future<void> testExecutable(FutureOr<void> Function() testMain) =>
    GoldenToolkit.runWithConfiguration(
      () async {
        await loadAppFonts();
        await testMain();
      },
      config: GoldenToolkitConfiguration(
        defaultDevices: _devices.map(_mapDevice).toList(),
        enableRealShadows: true,
      ),
    );

// Temporary downscale while bug not fixed https://github.com/eBay/flutter_glove_box/issues/119
Device _mapDevice(Device originalDevice) => originalDevice.copyWith(
      size: originalDevice.size / originalDevice.devicePixelRatio,
      devicePixelRatio: 1.0,
      name: originalDevice.name
          .toLowerCase()
          .replaceAll('+', ' plus')
          .replaceAll(' ', '_'),
      safeArea: originalDevice.safeArea / originalDevice.devicePixelRatio,
    );
