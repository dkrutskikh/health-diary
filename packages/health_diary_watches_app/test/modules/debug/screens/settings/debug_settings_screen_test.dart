import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:health_diary_watches_app/modules/debug/screens/settings/debug_settings_screen.dart';
import 'package:health_diary_watches_app/modules/debug/screens/settings/debug_settings_screen_model.dart';
import 'package:health_diary_watches_app/modules/debug/screens/settings/debug_settings_screen_wm.dart';
import 'package:health_diary_watches_app/services/theme_service.dart';
import 'package:mocktail/mocktail.dart';

class DebugSettingsScreenModelMock extends Mock
    implements DebugSettingsScreenModel {}

void main() {
  group('Debug settings screen', () {
    late DebugSettingsScreenModelMock model;

    setUp(() {
      model = DebugSettingsScreenModelMock();

      when(model.fetchDeviceModel)
          .thenAnswer((_) => Future<String>.value('mock device'));
    });

    testGoldens('golden test', (tester) async {
      await tester.pumpWidgetBuilder(
        DebugSettingsScreen(wmFactory: (_) => DebugSettingsScreenWM(model)),
        wrapper: materialAppWrapper(theme: const ThemeService().lightTheme),
      );

      await multiScreenGolden(tester, 'debug_settings_screen');
    });

    testWidgets('widget test', (tester) async {
      await tester.pumpWidgetBuilder(
        DebugSettingsScreen(wmFactory: (_) => DebugSettingsScreenWM(model)),
        wrapper: materialAppWrapper(theme: const ThemeService().lightTheme),
      );

      expect(find.text('Device: mock device'), findsOneWidget);
      expect(find.textContaining('screen:'), findsOneWidget);
      expect(find.textContaining('screen safe area:'), findsOneWidget);
      expect(find.textContaining('text scale:'), findsOneWidget);
    });
  });
}
