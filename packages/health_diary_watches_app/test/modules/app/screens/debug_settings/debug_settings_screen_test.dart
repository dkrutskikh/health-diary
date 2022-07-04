import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:health_diary_watches_app/modules/app/screens/debug_settings/debug_settings_screen.dart';
import 'package:health_diary_watches_app/modules/app/screens/debug_settings/debug_settings_screen_model.dart';
import 'package:health_diary_watches_app/modules/app/screens/debug_settings/debug_settings_screen_wm.dart';
import 'package:health_diary_watches_app/services/theme_service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DebugSettingsScreenModelMock extends Mock
    implements DebugSettingsScreenModel {}

void main() {
  group('Debug settings screen', () {
    late DebugSettingsScreenModelMock modelMock;

    setUp(() {
      modelMock = DebugSettingsScreenModelMock();

      when(() => modelMock.branchName).thenReturn('mock branch');

      when(modelMock.fetchDeviceModel)
          .thenAnswer((_) => Future<String>.value('mock device'));

      when(modelMock.fetchDeviceOS)
          .thenAnswer((_) => Future<String>.value('mock os'));

      when(modelMock.isPhysicalDevice)
          .thenAnswer((_) => Future<bool>.value(false));

      when(modelMock.fetchPackageInfo).thenAnswer(
        (_) => Future<PackageInfo>.value(
          PackageInfo(
            appName: 'testAppName',
            buildNumber: 'testBuildNumber',
            packageName: 'testPackageName',
            version: 'testVersion',
          ),
        ),
      );
    });

    testGoldens('golden test', (tester) async {
      await tester.pumpWidgetBuilder(
        DebugSettingsScreen(wmFactory: (_) => DebugSettingsScreenWM(modelMock)),
        wrapper: materialAppWrapper(theme: const ThemeService().lightTheme),
      );

      await multiScreenGolden(tester, 'debug_settings_screen');
    });
  });
}
