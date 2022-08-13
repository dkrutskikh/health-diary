import 'dart:io';

void generateFakeTest(String package, Iterable<String> uncoveredFiles) {
  final buffer = StringBuffer()
    ..writeln('// ignore_for_file: unused_import, directives_ordering')
    ..writeln('')
    ..writeln("import 'package:flutter_test/flutter_test.dart';")
    ..writeln('');

  for (final file in uncoveredFiles) {
    buffer
        .writeln("import 'package:$package/${file.replaceFirst('lib/', '')}';");
  }

  buffer
    ..writeln('')
    ..writeln('void main() {')
    ..writeln("  test('stub', () {});")
    ..writeln('}');

  File('packages/$package/test/fake_test.dart')
      .writeAsStringSync(buffer.toString(), mode: FileMode.writeOnly);
}
