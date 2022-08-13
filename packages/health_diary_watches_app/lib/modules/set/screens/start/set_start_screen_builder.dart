import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/utils/stub_model.dart';

import 'set_start_screen_wm.dart';

SetStartScreenWM createSetStartScreenWM(BuildContext context) =>
    SetStartScreenWM(GoRouter.of(context), StubModel());
