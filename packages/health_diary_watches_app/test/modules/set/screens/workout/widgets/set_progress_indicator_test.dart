import 'package:flutter/widgets.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:health_diary_watches_app/modules/set/screens/workout/widgets/set_progress_indicator.dart';
import 'package:health_diary_watches_app/services/theme_service.dart';

const _duration = Duration(seconds: 15);

void main() {
  testGoldens(
    'SetProgressIndicator',
    (tester) async {
      final builder = GoldenBuilder.column()
        ..addScenario(
          'SetProgressIndicator not filled',
          const SizedBox(
            width: 300,
            height: 300,
            child: SetProgressIndicator(duration: _duration),
          ),
        )
        ..addScenario(
          'SetProgressIndicator half filled',
          const SizedBox(
            width: 300,
            height: 300,
            child: SetProgressIndicator(progress: 0.5, duration: _duration),
          ),
        )
        ..addScenario(
          'SetProgressIndicator filled',
          const SizedBox(
            width: 300,
            height: 300,
            child: SetProgressIndicator(progress: 1.0, duration: _duration),
          ),
        )
        ..addScenario(
          'SetProgressIndicator overfilled',
          const SizedBox(
            width: 300,
            height: 300,
            child: SetProgressIndicator(progress: 1.5, duration: _duration),
          ),
        );

      await tester.pumpWidgetBuilder(
        builder.build(),
        surfaceSize: const Size(316, 1380),
        wrapper: materialAppWrapper(theme: const ThemeService().lightTheme),
      );

      await screenMatchesGolden(tester, 'set_progress_indicator');
    },
  );
}
