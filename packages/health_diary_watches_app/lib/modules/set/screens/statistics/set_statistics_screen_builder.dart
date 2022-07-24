import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/utils/stub_model.dart';

import 'set_statistics_screen_wm.dart';

SetStatisticsScreenWM createSetStatisticsScreenWM(BuildContext context) =>
    SetStatisticsScreenWM(GoRouter.of(context), StubModel());
