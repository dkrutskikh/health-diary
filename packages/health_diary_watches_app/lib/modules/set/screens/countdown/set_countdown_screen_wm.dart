import 'dart:math';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/services/haptic_feedback_service.dart';

import 'models/time_props.dart';
import 'set_countdown_screen.dart';
import 'set_countdown_screen_model.dart';

class SetCountdownScreenWM
    extends WidgetModel<SetCountdownScreen, SetCountdownScreenModel> {
  final HapticFeedbackService _feedback;
  final GoRouter _router;

  final _countdown = ValueNotifier<TimeProps>(
    const TimeProps(
      value: '',
      scale: 0.0,
      opacity: 0.0,
      duration: Duration.zero,
    ),
  );

  ValueListenable<TimeProps> get countdown => _countdown;

  SetCountdownScreenWM(this._feedback, this._router, super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    model.countdown.addListener(_update);
  }

  void _update() {
    final prevValue = _countdown.value.duration;
    final newValue = model.countdown.value;

    if (newValue.inSeconds <= 0) {
      _router.goNamed('workout');
    } else {
      final delta = sin(pi * (newValue.inMilliseconds % 1000) / 1000);

      _countdown.value = TimeProps(
        value: newValue.inSeconds.toString(),
        scale: delta * 10,
        opacity: min(delta * 1.5, 1),
        duration: newValue,
      );

      if (prevValue.inSeconds > 3 && newValue.inSeconds <= 3) {
        _feedback.feedback(HapticFeedbackType.light);
      } else if (prevValue.inSeconds > 2 && newValue.inSeconds <= 2) {
        _feedback.feedback();
      } else if (prevValue.inSeconds > 1 && newValue.inSeconds <= 1) {
        _feedback.feedback(HapticFeedbackType.heavy);
      }
    }
  }
}
