import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_info_plus_tizen/device_info_plus_tizen.dart';
import 'package:flutter/widgets.dart';
import 'package:health_diary_watches_app/services/device_info_service/device_info_service.dart';
import 'package:health_diary_watches_app/services/platform_service/platform_service.dart';

import 'debug_settings_screen_model.dart';
import 'debug_settings_screen_wm.dart';

DebugSettingsScreenWM createDebugSettingsScreenWM(BuildContext _) =>
    DebugSettingsScreenWM(
      DebugSettingsScreenModel(
        DeviceInfoService(
          DeviceInfoPlugin(),
          DeviceInfoPluginTizen(),
          const PlatformService(),
        ),
      ),
    );
