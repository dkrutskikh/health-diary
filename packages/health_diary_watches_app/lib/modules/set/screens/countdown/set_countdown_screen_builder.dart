import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/services/haptic_feedback_service.dart';
import 'package:provider/provider.dart';

import 'set_countdown_screen_model.dart';
import 'set_countdown_screen_wm.dart';

SetCountdownScreenWM createSetCountdownScreenWM(BuildContext context) =>
    SetCountdownScreenWM(
      context.read<HapticFeedbackService>(),
      GoRouter.of(context),
      SetCountdownScreenModel(),
    );
