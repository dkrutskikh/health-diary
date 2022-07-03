import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:health_diary_watches_app/widgets/ui_kit/stub_widget.dart';

import 'debug_settings_screen_builder.dart';
import 'debug_settings_screen_wm.dart';

/// Application Debug Settings Screen
class DebugSettingsScreen extends ElementaryWidget<DebugSettingsScreenWM> {
  const DebugSettingsScreen({
    Key? key,
    WidgetModelFactory<DebugSettingsScreenWM> wmFactory =
        createDebugSettingsScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(DebugSettingsScreenWM wm) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Debug Settings',
            style: DebugSettingsScreenWM.titleTextStyle,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Branch name: ${wm.branchName}'),
                ValueListenableBuilder<String?>(
                  valueListenable: wm.packageVersion,
                  builder: (_, version, __) => version != null
                      ? Text('App version: $version')
                      : const StubWidget(),
                ),
                ValueListenableBuilder<String>(
                  valueListenable: wm.deviceName,
                  builder: (_, state, __) => Text('Device: $state'),
                ),
                ValueListenableBuilder<String>(
                  valueListenable: wm.deviceOS,
                  builder: (_, state, __) => Text('Operation system: $state'),
                ),
                ValueListenableBuilder<bool?>(
                  valueListenable: wm.isPhysicalDevice,
                  builder: (_, state, __) => state != null
                      ? Text('Physical device: $state')
                      : const StubWidget(),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<MediaQueryData>(
                  valueListenable: wm.deviceMediaQuery,
                  builder: (_, state, __) {
                    final deviceSize = state.size;

                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'screen:\n'
                              '\n'
                              'width: ${wm.trimNumber(deviceSize.width)}\n'
                              'height: ${wm.trimNumber(deviceSize.height)}\n'
                              'pixel ratio: ${wm.trimNumber(state.devicePixelRatio)}\n'
                              'width in pix: ${wm.trimNumber(deviceSize.width * state.devicePixelRatio)}\n'
                              'height in pix: ${wm.trimNumber(deviceSize.height * state.devicePixelRatio)}',
                            ),
                            Text(
                              'screen safe area:\n'
                              '\n'
                              'left: ${wm.trimNumber(state.padding.left)}\n'
                              'top: ${wm.trimNumber(state.padding.top)}\n'
                              'right: ${wm.trimNumber(state.padding.right)}\n'
                              'bottom: ${wm.trimNumber(state.padding.bottom)}',
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
