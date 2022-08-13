import 'package:builder/src/utils/find_source_files.dart';
import 'package:builder/src/utils/generate_fake_test.dart';
import 'package:builder/src/utils/lcov_parser.dart';

const _package = 'health_diary_watches_app';

Future<void> main() async {
  final units = await parseLcov(_package, 'units');

  final coveredFiles = units.map((record) => record.file).toSet();

  final sourceFiles = findSourceFiles(_package).toSet();

  final uncoveredFiles = sourceFiles.difference(coveredFiles);

  generateFakeTest(_package, uncoveredFiles);
}
