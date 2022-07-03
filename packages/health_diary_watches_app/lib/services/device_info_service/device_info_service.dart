import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';

import '../platform_service/platform.dart';
import '../platform_service/platform_service.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfo;
  final DeviceInfoPluginTizen _deviceInfoTizen;
  final PlatformService _platformService;

  const DeviceInfoService(
    this._deviceInfo,
    this._deviceInfoTizen,
    this._platformService,
  );

  Future<String> fetchDeviceModel() async {
    switch (_platformService.current()) {
      case Platform.android:
        final info = await _deviceInfo.androidInfo;

        return '${info.brand ?? ''} ${info.model ?? ''}'.trim();
      case Platform.iOS:
        final info = await _deviceInfo.iosInfo;

        return info.name ?? '';
      case Platform.pwa:
        final info = await _deviceInfo.webBrowserInfo;

        return '${info.vendor ?? ''} ${info.userAgent ?? ''}'.trim();
      case Platform.linux:
        return 'Laptop';
      case Platform.tizen:
        final info = await _deviceInfoTizen.tizenInfo;

        return '${info.manufacturer ?? ''} ${info.modelName ?? ''}'.trim();
    }
  }

  Future<String> fetchDeviceOS() async {
    switch (_platformService.current()) {
      case Platform.android:
        final info = await _deviceInfo.androidInfo;

        return 'Android ${info.version.release} (SDK ${info.version.sdkInt})';
      case Platform.iOS:
        final info = await _deviceInfo.iosInfo;

        return '${info.systemName} ${info.systemVersion}'.trim();
      case Platform.pwa:
        final info = await _deviceInfo.webBrowserInfo;

        return '${info.appName ?? ''} ${info.appVersion ?? ''}'.trim();
      case Platform.linux:
        final info = await _deviceInfo.linuxInfo;

        return info.prettyName;
      case Platform.tizen:
        final info = await _deviceInfoTizen.tizenInfo;

        return '${info.platformName} ${info.platformVersion ?? ''}'.trim();
    }
  }

  Future<bool?> isPhysicalDevice() async {
    switch (_platformService.current()) {
      case Platform.android:
        final info = await _deviceInfo.androidInfo;

        return info.isPhysicalDevice ?? false;
      case Platform.iOS:
        final info = await _deviceInfo.iosInfo;

        return info.isPhysicalDevice;
      case Platform.pwa:
      case Platform.linux:
      case Platform.tizen:
        return null;
    }
  }
}
