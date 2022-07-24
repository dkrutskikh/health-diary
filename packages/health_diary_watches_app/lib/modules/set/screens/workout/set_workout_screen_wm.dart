import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/services/haptic_feedback_service.dart';

import 'set_workout_screen.dart';
import 'set_workout_screen_model.dart';

class SetWorkoutScreenWM
    extends WidgetModel<SetWorkoutScreen, SetWorkoutScreenModel> {
  final HapticFeedbackService _feedback;
  final GoRouter _router;

  final _progress = ValueNotifier<double>(0);

  ValueListenable<double> get progress => _progress;
  Duration get duration => model.duration;

  SetWorkoutScreenWM(this._feedback, this._router, super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    model.countdown.addListener(_update);
  }

  void _update() {
    final newValue = model.countdown.value;

    if (newValue.isNegative) {
      _feedback.feedback(HapticFeedbackType.heavy);
      _router.goNamed('start');
    } else {
      _progress.value =
          1.0 - newValue.inMicroseconds / model.duration.inMicroseconds;
    }
  }
}
