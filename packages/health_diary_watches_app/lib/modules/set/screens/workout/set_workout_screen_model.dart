import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';

const _workoutDuration = Duration(seconds: 30);

class SetWorkoutScreenModel extends ElementaryModel {
  late final Timer _timer;
  late final DateTime _finishTime;

  final _countdown = ValueNotifier<Duration>(Duration.zero);

  ValueListenable<Duration> get countdown => _countdown;

  Duration get duration => _workoutDuration;

  @override
  void init() {
    super.init();

    _finishTime = DateTime.now().add(_workoutDuration);

    _timer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      if (timer.isActive) {
        _countdown.value = _finishTime.difference(DateTime.now());
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }
}
