import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:health_diary_watches_app/services/device_info_service/device_info_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'helpers/commit_hash_helpers.dart';

// ignore: do_not_use_environment
const _branchName = String.fromEnvironment('BRANCH_NAME');

// ignore: do_not_use_environment
const _commitHash = String.fromEnvironment('COMMIT_HASH');

class DebugSettingsScreenModel extends ElementaryModel {
  final DeviceInfoService _deviceInfo;

  String get branchName => _commitHash.isNotEmpty
      ? '$_branchName (commit: ${shortCommitHash(_commitHash)})'
      : _branchName;

  DebugSettingsScreenModel(this._deviceInfo);

  Future<String> fetchDeviceModel() => _deviceInfo.fetchDeviceModel();

  Future<String> fetchDeviceOS() => _deviceInfo.fetchDeviceOS();

  Future<bool?> isPhysicalDevice() => _deviceInfo.isPhysicalDevice();

  Future<PackageInfo> fetchPackageInfo() => PackageInfo.fromPlatform();
}
