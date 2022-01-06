import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:flutter/widgets.dart';

import 'debug_settings_screen_model.dart';
import 'debug_settings_screen_wm.dart';

DebugSettingsScreenWM createDebugSettingsScreenWM(BuildContext _) {
  return DebugSettingsScreenWM(
    DebugSettingsScreenModel(DeviceInfoPluginTizen()),
  );
}
