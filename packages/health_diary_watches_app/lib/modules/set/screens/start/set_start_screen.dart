import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'set_start_screen_builder.dart';
import 'set_start_screen_i18n.dart';
import 'set_start_screen_wm.dart';

class SetStartScreen extends ElementaryWidget<SetStartScreenWM> {
  const SetStartScreen({
    Key? key,
    WidgetModelFactory<SetStartScreenWM> wmFactory = createSetStartScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(SetStartScreenWM wm) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: wm.onStart,
              child: Text(SetStartScreenI18n.buttonTitle),
            ),
          ),
        ),
      );
}
