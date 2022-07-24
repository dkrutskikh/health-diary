import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'set_statistics_screen_builder.dart';
import 'set_statistics_screen_i18n.dart';
import 'set_statistics_screen_wm.dart';

class SetStatisticsScreen extends ElementaryWidget<SetStatisticsScreenWM> {
  const SetStatisticsScreen({
    Key? key,
    WidgetModelFactory<SetStatisticsScreenWM> wmFactory =
        createSetStatisticsScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(SetStatisticsScreenWM wm) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(SetStatisticsScreenI18n.title),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: wm.onStart,
                  child: Text(SetStatisticsScreenI18n.buttonTitle),
                ),
              ],
            ),
          ),
        ),
      );
}
