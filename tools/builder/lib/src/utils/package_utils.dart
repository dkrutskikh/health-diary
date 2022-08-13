import 'dart:io';

import 'package:yaml/yaml.dart';

String packageName(String package) =>
    _loadPubSpec(package)?.contents.value['name'] ?? '';

String packageVersion(String package) =>
    _loadPubSpec(package)?.contents.value['version'] ?? '';

YamlDocument? _loadPubSpec(String package) {
  final pubSpecFile = File('packages/$package/pubspec.yaml');

  if (pubSpecFile.existsSync()) {
    return loadYamlDocument(
      pubSpecFile.readAsStringSync(),
      sourceUrl: Uri.file(pubSpecFile.path),
    );
  }

  return null;
}
