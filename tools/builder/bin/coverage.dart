import 'dart:io';

import 'package:builder/src/utils/lcov_parser.dart';
import 'package:builder/src/utils/merge_coverage.dart';
import 'package:builder/src/utils/package_utils.dart';

const _package = 'health_diary_watches_app';

Future<void> main() async {
  final goldens = await parseLcov(_package, 'goldens');
  final units = await parseLcov(_package, 'units');
  final uncovered = await parseLcov(_package, 'uncovered');

  final merged = mergeLcovReports(
    goldens: goldens,
    units: units,
    uncovered: uncovered,
    packageName: packageName(_package),
    packageVersion: packageVersion(_package),
  );

  File('packages/$_package/coverage/cobertura.xml')
      .writeAsStringSync(merged.toXmlString(pretty: true));
}
