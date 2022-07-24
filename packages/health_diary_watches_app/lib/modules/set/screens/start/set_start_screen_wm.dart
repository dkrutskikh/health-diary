import 'package:elementary/elementary.dart';
import 'package:go_router/go_router.dart';
import 'package:health_diary_watches_app/utils/stub_model.dart';

import 'set_start_screen.dart';

class SetStartScreenWM extends WidgetModel<SetStartScreen, StubModel> {
  final GoRouter _router;

  SetStartScreenWM(this._router, super.model);

  void onStart() {
    _router.goNamed('countdown');
  }
}
