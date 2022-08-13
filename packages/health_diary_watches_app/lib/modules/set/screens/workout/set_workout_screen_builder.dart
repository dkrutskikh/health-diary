import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/services/haptic_feedback_service.dart';
import 'package:provider/provider.dart';

import 'set_workout_screen_model.dart';
import 'set_workout_screen_wm.dart';

SetWorkoutScreenWM createSetWorkoutScreenWM(BuildContext context) =>
    SetWorkoutScreenWM(
      context.read<HapticFeedbackService>(),
      GoRouter.of(context),
      SetWorkoutScreenModel(),
    );
