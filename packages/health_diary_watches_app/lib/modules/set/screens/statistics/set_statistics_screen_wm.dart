import 'package:elementary/elementary.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/utils/stub_model.dart';

import 'set_statistics_screen.dart';

class SetStatisticsScreenWM
    extends WidgetModel<SetStatisticsScreen, StubModel> {
  final GoRouter _router;

  SetStatisticsScreenWM(this._router, super.model);

  void onStart() {
    _router.goNamed('start');
  }
}
