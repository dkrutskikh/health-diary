import 'dart:async';

import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:elementary/elementary.dart';

class DebugSettingsScreenModel extends ElementaryModel {
  final DeviceInfoPluginTizen _deviceInfo;

  DebugSettingsScreenModel(this._deviceInfo);

  Future<String> fetchDeviceModel() async {
    final info = await _deviceInfo.tizenInfo;

    return '${info.manufacturer ?? ''}  ${info.modelName ?? ''}'.trim();
  }
}
