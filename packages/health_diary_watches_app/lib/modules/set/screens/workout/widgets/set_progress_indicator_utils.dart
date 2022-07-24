import 'dart:math';

String formatCountdownTime(Duration duration, double progress) {
  var leftTime = duration * max(min(1 - progress, 1.0), 0);

  final minutes = leftTime.inMinutes.toString().padLeft(2, '0');

  leftTime -= Duration(minutes: leftTime.inMinutes);

  final seconds = leftTime.inSeconds.toString().padLeft(2, '0');

  leftTime -= Duration(seconds: leftTime.inSeconds);

  return '$minutes:$seconds';
}
