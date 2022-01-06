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
  final _deviceMediaQuery =
      ValueNotifier<MediaQueryData>(const MediaQueryData());

  ValueListenable<String> get deviceName => _deviceName;
  ValueListenable<MediaQueryData> get deviceMediaQuery => _deviceMediaQuery;

  DebugSettingsScreenWM(DebugSettingsScreenModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    model.fetchDeviceModel().then((model) {
      _deviceName.value = model;
    });

    WidgetsBinding.instance?.addObserver(this);

    _updateMediaQueryData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    _updateMediaQueryData();
  }

  void _updateMediaQueryData() {
    final bindings = WidgetsBinding.instance;

    if (bindings != null) {
      _deviceMediaQuery.value = MediaQueryData.fromWindow(bindings.window);
    }
  }
}
