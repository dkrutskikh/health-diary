import 'dart:io';

import 'package:lcov_parser/lcov_parser.dart';

Future<Iterable<Record>> parseLcov(String package, String type) {
  final lcovReportFile = File('packages/$package/coverage/$type.lcov.info');
  if (!lcovReportFile.existsSync()) {
    print('Coverage lcov report does not exist.');

    return Future.value([]);
  }

  return Parser.parse(lcovReportFile.path);
}
