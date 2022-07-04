import 'dart:io' as io;

import 'package:flutter/foundation.dart';

import 'platform.dart';

class PlatformService {
  const PlatformService();

  Platform current() {
    final isTizen = io.Platform.environment.containsKey('TIZEN_API_VERSION');

    if (kIsWeb) {
      return Platform.pwa;
    } else if (isTizen) {
      return Platform.tizen;
    } else if (io.Platform.isAndroid) {
      return Platform.android;
    } else if (io.Platform.isIOS) {
      return Platform.iOS;
    } else if (io.Platform.isLinux) {
      return Platform.linux;
    } else {
      throw io.OSError('${io.Platform.operatingSystem} not supported');
    }
  }
}
