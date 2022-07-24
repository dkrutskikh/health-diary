import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'models/time_props.dart';
import 'set_countdown_screen_builder.dart';
import 'set_countdown_screen_wm.dart';

class SetCountdownScreen extends ElementaryWidget<SetCountdownScreenWM> {
  const SetCountdownScreen({
    Key? key,
    WidgetModelFactory<SetCountdownScreenWM> wmFactory =
        createSetCountdownScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(SetCountdownScreenWM wm) => Scaffold(
        body: SafeArea(
          child: Center(
            child: ValueListenableBuilder<TimeProps>(
              valueListenable: wm.countdown,
              builder: (_, state, __) => Transform.scale(
                scale: state.scale,
                child:
                    Opacity(opacity: state.opacity, child: Text(state.value)),
              ),
            ),
          ),
        ),
      );
}
