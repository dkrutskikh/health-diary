import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_diary_watches_app/services/device_info_service/device_info_service.dart';
import 'package:health_diary_watches_app/services/platform_service/platform.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/device_info_plugin_mock.dart';
import '../../mocks/device_info_plugin_tizen_mock.dart';
import '../../mocks/platform_service_mock.dart';

class AndroidDeviceInfoMock extends Mock implements AndroidDeviceInfo {}

class AndroidBuildVersionMock extends Mock implements AndroidBuildVersion {}

class IosDeviceInfoMock extends Mock implements IosDeviceInfo {}

class WebBrowserInfoMock extends Mock implements WebBrowserInfo {}

class LinuxDeviceInfoMock extends Mock implements LinuxDeviceInfo {}

void main() {
  group('$DeviceInfoService', () {
    late DeviceInfoPluginMock deviceInfoPlugin;
    late DeviceInfoPluginTizenMock deviceInfoPluginTizen;
    late PlatformServiceMock platformService;
    late AndroidDeviceInfoMock androidDeviceInfo;
    late AndroidBuildVersionMock androidBuildVersion;
    late IosDeviceInfoMock iOSDeviceInfo;
    late WebBrowserInfoMock webDeviceInfo;
    late LinuxDeviceInfoMock linuxDeviceInfo;

    setUp(() {
      deviceInfoPlugin = DeviceInfoPluginMock();
      deviceInfoPluginTizen = DeviceInfoPluginTizenMock();
      platformService = PlatformServiceMock();
      androidDeviceInfo = AndroidDeviceInfoMock();
      androidBuildVersion = AndroidBuildVersionMock();
      iOSDeviceInfo = IosDeviceInfoMock();
      webDeviceInfo = WebBrowserInfoMock();
      linuxDeviceInfo = LinuxDeviceInfoMock();
    });

    group('fetchDeviceModel calls', () {
      test('PlatformService.current()', () async {
        when(() => platformService.current()).thenReturn(Platform.pwa);
        when(() => deviceInfoPlugin.webBrowserInfo)
            .thenAnswer((_) async => webDeviceInfo);

        await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).fetchDeviceModel();

        verify(() => platformService.current()).called(1);
      });

      test(
        'DeviceInfoPlugin.webBrowserInfo and returns web device model when run on web',
        () async {
          when(() => platformService.current()).thenReturn(Platform.pwa);
          when(() => deviceInfoPlugin.webBrowserInfo)
              .thenAnswer((_) async => webDeviceInfo);
          when(() => webDeviceInfo.vendor).thenReturn('vendor');
          when(() => webDeviceInfo.userAgent).thenReturn('userAgent');

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).fetchDeviceModel();

          verify(() => deviceInfoPlugin.webBrowserInfo).called(1);

          expect(result, equals('vendor userAgent'));
        },
      );

      test(
        'DeviceInfoPlugin.androidInfo and returns android device model when run on Android',
        () async {
          when(() => platformService.current()).thenReturn(Platform.android);
          when(() => deviceInfoPlugin.androidInfo)
              .thenAnswer((_) async => androidDeviceInfo);
          when(() => androidDeviceInfo.brand).thenReturn('Android brand');
          when(() => androidDeviceInfo.model).thenReturn('Android model');

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).fetchDeviceModel();

          verify(() => deviceInfoPlugin.androidInfo).called(1);

          expect(result, equals('Android brand Android model'));
        },
      );

      test(
        'DeviceInfoPlugin.iosInfo and returns ios device model when run on iOS',
        () async {
          when(() => platformService.current()).thenReturn(Platform.iOS);
          when(() => deviceInfoPlugin.iosInfo)
              .thenAnswer((_) async => iOSDeviceInfo);
          when(() => iOSDeviceInfo.name).thenReturn('iPhone');

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).fetchDeviceModel();

          verify(() => deviceInfoPlugin.iosInfo).called(1);

          expect(result, equals('iPhone'));
        },
      );

      test(
        'DeviceInfoPlugin.linuxInfo and returns device name when run on Linux',
        () async {
          when(() => platformService.current()).thenReturn(Platform.linux);

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).fetchDeviceModel();

          expect(result, equals('Laptop'));
        },
      );
    });

    group('fetchDeviceOS calls', () {
      test('PlatformService.current()', () async {
        when(() => platformService.current()).thenReturn(Platform.pwa);
        when(() => deviceInfoPlugin.webBrowserInfo)
            .thenAnswer((_) async => webDeviceInfo);

        await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).fetchDeviceOS();

        verify(() => platformService.current()).called(1);
      });

      test(
        'DeviceInfoPlugin.webBrowserInfo and returns device OS when run on web',
        () async {
          when(() => platformService.current()).thenReturn(Platform.pwa);
          when(() => deviceInfoPlugin.webBrowserInfo)
              .thenAnswer((_) async => webDeviceInfo);
          when(() => webDeviceInfo.appName).thenReturn('appName');
          when(() => webDeviceInfo.appVersion).thenReturn('appVersion');

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).fetchDeviceOS();

          verify(() => deviceInfoPlugin.webBrowserInfo).called(1);

          expect(result, equals('appName appVersion'));
        },
      );

      test(
        'DeviceInfoPlugin.androidInfo and returns device OS when run on Android',
        () async {
          when(() => platformService.current()).thenReturn(Platform.android);
          when(() => deviceInfoPlugin.androidInfo)
              .thenAnswer((_) async => androidDeviceInfo);
          when(() => androidDeviceInfo.version).thenReturn(androidBuildVersion);
          when(() => androidBuildVersion.release).thenReturn('release');
          when(() => androidBuildVersion.sdkInt).thenReturn(29);

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).fetchDeviceOS();

          verify(() => deviceInfoPlugin.androidInfo).called(1);

          expect(result, equals('Android release (SDK 29)'));
        },
      );

      test('DeviceInfoPlugin.iosInfo and returns device OS when run on iOS',
          () async {
        when(() => platformService.current()).thenReturn(Platform.iOS);
        when(() => deviceInfoPlugin.iosInfo)
            .thenAnswer((_) async => iOSDeviceInfo);
        when(() => iOSDeviceInfo.systemName).thenReturn('iOS');
        when(() => iOSDeviceInfo.systemVersion).thenReturn('15.5');

        final result = await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).fetchDeviceOS();

        verify(() => deviceInfoPlugin.iosInfo).called(1);

        expect(result, equals('iOS 15.5'));
      });

      test('DeviceInfoPlugin.linuxInfo when run on linux', () async {
        when(() => platformService.current()).thenReturn(Platform.linux);
        when(() => deviceInfoPlugin.linuxInfo)
            .thenAnswer((_) async => linuxDeviceInfo);
        when(() => linuxDeviceInfo.prettyName)
            .thenReturn('Fedora 17 (Beefy Miracle)');

        final result = await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).fetchDeviceOS();

        verify(() => deviceInfoPlugin.linuxInfo).called(1);

        expect(result, equals('Fedora 17 (Beefy Miracle)'));
      });
    });

    group('isPhysicalDevice', () {
      test('calls PlatformService.current()', () async {
        when(() => platformService.current()).thenReturn(Platform.pwa);
        when(() => deviceInfoPlugin.webBrowserInfo)
            .thenAnswer((_) async => webDeviceInfo);

        await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).isPhysicalDevice();

        verify(() => platformService.current()).called(1);
      });

      test('returns true when run on web', () async {
        when(() => platformService.current()).thenReturn(Platform.pwa);

        final result = await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).isPhysicalDevice();

        expect(result, isNull);
      });

      test(
        'calls DeviceInfoPlugin.androidInfo when run on Android and returns false when isPhysicalDevice is null',
        () async {
          when(() => platformService.current()).thenReturn(Platform.android);
          when(() => deviceInfoPlugin.androidInfo)
              .thenAnswer((_) async => androidDeviceInfo);

          final result = await DeviceInfoService(
            deviceInfoPlugin,
            deviceInfoPluginTizen,
            platformService,
          ).isPhysicalDevice();

          verify(() => deviceInfoPlugin.androidInfo).called(1);

          expect(result, isFalse);
        },
      );

      test(
          'calls DeviceInfoPlugin.iosInfo when run on iOS and returns true when isPhysicalDevice defined is true',
          () async {
        when(() => platformService.current()).thenReturn(Platform.iOS);
        when(() => deviceInfoPlugin.iosInfo)
            .thenAnswer((_) async => iOSDeviceInfo);
        when(() => iOSDeviceInfo.isPhysicalDevice).thenReturn(true);

        final result = await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).isPhysicalDevice();

        verify(() => deviceInfoPlugin.iosInfo).called(1);

        expect(result, isTrue);
      });

      test('returns true when run on linux', () async {
        when(() => platformService.current()).thenReturn(Platform.linux);

        final result = await DeviceInfoService(
          deviceInfoPlugin,
          deviceInfoPluginTizen,
          platformService,
        ).isPhysicalDevice();

        expect(result, isNull);
      });
    });
  });
}
