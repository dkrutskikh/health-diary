import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class HapticFeedbackService {
  var _hasVibrator = false;
  var _hasCustomAmplitude = false;
  var _hasCustomDuration = false;

  HapticFeedbackService() {
    Vibration.hasVibrator().then((value) {
      _hasVibrator = value ?? false;

      Vibration.hasAmplitudeControl().then((value) {
        _hasCustomAmplitude = value ?? false;
      });
      Vibration.hasCustomVibrationsSupport().then((value) {
        _hasCustomDuration = value ?? false;
      });
    });
  }

  void feedback([HapticFeedbackType type = HapticFeedbackType.medium]) {
    if (_hasVibrator) {
      _vibrateApiFeedBack(type);
    } else {
      _hapticApiFeedBack(type);
    }
  }

  void _hapticApiFeedBack(HapticFeedbackType type) {
    const apiMapping = {
      HapticFeedbackType.light: HapticFeedback.mediumImpact,
      HapticFeedbackType.medium: HapticFeedback.mediumImpact,
      HapticFeedbackType.heavy: HapticFeedback.mediumImpact,
    };

    apiMapping[type]?.call();
  }

  void _vibrateApiFeedBack(HapticFeedbackType type) {
    const amplitudeMapping = {
      HapticFeedbackType.light: 63,
      HapticFeedbackType.medium: 127,
      HapticFeedbackType.heavy: 255,
    };
    const amplitudeFallback = -1;

    const durationMapping = {
      HapticFeedbackType.light: 250,
      HapticFeedbackType.medium: 500,
      HapticFeedbackType.heavy: 750,
    };
    const durationFallback = 500;

    final vibrateAmplitude = _hasCustomAmplitude
        ? amplitudeMapping[type] ?? amplitudeFallback
        : amplitudeFallback;

    final vibrateDuration = _hasCustomDuration
        ? durationMapping[type] ?? durationFallback
        : durationFallback;

    Vibration.vibrate(duration: vibrateDuration, amplitude: vibrateAmplitude);
  }
}

enum HapticFeedbackType {
  light,
  medium,
  heavy,
}
