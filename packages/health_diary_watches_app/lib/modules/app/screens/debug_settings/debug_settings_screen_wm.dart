import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'debug_settings_screen.dart';
import 'debug_settings_screen_model.dart';

/// Widget model for Debug Screen
class DebugSettingsScreenWM
    extends WidgetModel<DebugSettingsScreen, DebugSettingsScreenModel>
    with WidgetsBindingObserver {
  /// Text style for title debug settings screen
  static const titleTextStyle = TextStyle(
    color: Color(0xFF000000),
    fontSize: 16,
    fontFamily: 'Roboto',
  );

  final _deviceName = ValueNotifier<String>('');
  final _deviceOS = ValueNotifier<String>('');
  final _isPhysicalDevice = ValueNotifier<bool?>(null);
  final _deviceMediaQuery =
      ValueNotifier<MediaQueryData>(const MediaQueryData());
  final _packageVersion = ValueNotifier<String?>(null);

  String get branchName => model.branchName;

  ValueListenable<String> get deviceName => _deviceName;

  ValueListenable<String> get deviceOS => _deviceOS;

  ValueListenable<bool?> get isPhysicalDevice => _isPhysicalDevice;

  ValueListenable<MediaQueryData> get deviceMediaQuery => _deviceMediaQuery;

  ValueListenable<String?> get packageVersion => _packageVersion;

  DebugSettingsScreenWM(super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    model.fetchDeviceModel().then((model) {
      _deviceName.value = model;
    });
    model.fetchDeviceOS().then((osVersion) {
      _deviceOS.value = osVersion;
    });
    model.isPhysicalDevice().then((isPhysical) {
      _isPhysicalDevice.value = isPhysical;
    });
    model.fetchPackageInfo().then((info) {
      _packageVersion.value = info.version;
    });

    WidgetsBinding.instance.addObserver(this);

    _updateMediaQueryData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    _updateMediaQueryData();
  }

  double trimNumber(num value) => (value * 1000).ceilToDouble() / 1000;

  void _updateMediaQueryData() {
    _deviceMediaQuery.value =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window);
  }
}
