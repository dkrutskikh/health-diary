import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

import 'set_workout_screen_builder.dart';
import 'set_workout_screen_wm.dart';
import 'widgets/set_progress_indicator.dart';

class SetWorkoutScreen extends ElementaryWidget<SetWorkoutScreenWM> {
  const SetWorkoutScreen({
    Key? key,
    WidgetModelFactory<SetWorkoutScreenWM> wmFactory = createSetWorkoutScreenWM,
  }) : super(wmFactory, key: key);

  @override
  Widget build(SetWorkoutScreenWM wm) => Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: ValueListenableBuilder<double>(
                      valueListenable: wm.progress,
                      builder: (_, state, __) => SetProgressIndicator(
                        progress: state,
                        duration: wm.duration,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
}
