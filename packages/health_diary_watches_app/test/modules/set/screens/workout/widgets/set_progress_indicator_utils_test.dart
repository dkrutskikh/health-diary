import 'package:flutter_test/flutter_test.dart';
import 'package:health_diary_watches_app/modules/set/screens/workout/widgets/set_progress_indicator_utils.dart';

const _duration = Duration(seconds: 15);

void main() {
  test('formatCountdownTime returns human readable string', () {
    expect(formatCountdownTime(_duration, 0), equals('00:15'));
    expect(formatCountdownTime(_duration, 0.5), equals('00:07'));
    expect(formatCountdownTime(_duration, 1), equals('00:00'));

    expect(formatCountdownTime(_duration, -0.5), equals('00:15'));
    expect(formatCountdownTime(_duration, 1.5), equals('00:00'));
  });
}
