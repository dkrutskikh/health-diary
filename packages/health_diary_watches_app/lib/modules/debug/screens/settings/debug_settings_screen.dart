import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

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
  Widget build(DebugSettingsScreenWM wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Debug Settings',
          style: DebugSettingsScreenWM.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              Align(
                child: ValueListenableBuilder<String>(
                  valueListenable: wm.deviceName,
                  builder: (_, state, __) {
                    return Text('Device: $state');
                  },
                ),
              ),
              const SizedBox(height: 8),
              Align(
                child: ValueListenableBuilder<MediaQueryData>(
                  valueListenable: wm.deviceMediaQuery,
                  builder: (_, state, __) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'screen:\n'
                              '\n'
                              'width: ${state.size.width}\n'
                              'height: ${state.size.height}\n'
                              'pixel ratio: ${state.devicePixelRatio}\n'
                              'width in pix: ${state.size.width * state.devicePixelRatio}\n'
                              'height in pix: ${state.size.height * state.devicePixelRatio}',
                              softWrap: true,
                            ),
                            Text(
                              'screen safe area:\n'
                              '\n'
                              'left: ${state.padding.left}\n'
                              'top: ${state.padding.top}\n'
                              'right: ${state.padding.right}\n'
                              'bottom: ${state.padding.bottom}',
                              softWrap: true,
                              overflow: TextOverflow.clip,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text('text scale: ${state.textScaleFactor}'),
                      ],
                    );
                  },
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
