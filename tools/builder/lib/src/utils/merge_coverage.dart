import 'package:collection/collection.dart';
import 'package:lcov_parser/lcov_parser.dart';
import 'package:path/path.dart' as p;
import 'package:xml/xml.dart' as xml;

import '../models/coverage_record.dart';

xml.XmlDocument mergeLcovReports({
  required Iterable<Record> goldens,
  required Iterable<Record> units,
  required Iterable<Record> uncovered,
  required String packageName,
  required String packageVersion,
}) {
  final sources =
      _mergeRecords(goldens: goldens, units: units, uncovered: uncovered);

//  var lineHits = results.records.fold<int>(0, (p, c) => p + c.lines.hit);
  final lineFinds = sources.fold<int>(0, (p, c) => p + c.lines.length);
//  var lineRate = lineFinds > 0 ? (lineHits / lineFinds).round() : lineFinds;

  final epochTimeStamp = (DateTime.now().millisecondsSinceEpoch / 1000).round();

  var builder = xml.XmlBuilder();
  builder
    ..declaration(encoding: 'UTF-8')
    ..xml(
        '<!DOCTYPE coverage SYSTEM "http://cobertura.sourceforge.net/xml/coverage-04.dtd">')
    ..element('coverage', attributes: {
//          "lines-valid": lineFinds.toString(),
//          "lines-covered": lineHits.toString(),
//          "line-rate": lineRate.toString(),
      'branches-valid': '0',
      'branches-covered': '0',
      'branch-rate': '0',
      'timestamp': epochTimeStamp.toString(),
      'complexity': '0',
      'version': packageVersion,
    }, nest: () {
      builder
        ..element('sources', nest: () {
          for (final source in sources) {
            builder.element('source',
                nest: _realPath(source.file, packageName));
          }
        })
        ..element("packages", nest: () {
          builder.element("package", attributes: {
            "name": packageName,
//          "line-rate": lineRate.toString(),
            'branch-rate': '0',
          }, nest: () {
            builder.element("classes", nest: () {
              for (var source in sources) {
//              var classLineRate = r.lines.found > 0
//                  ? (r.lines.hit / r.lines.found).round()
//                  : r.lines.found;

                builder.element('class', attributes: {
                  'name': p.basenameWithoutExtension(source.file),
                  'filename': _realPath(source.file, packageName),
//                "line-rate": classLineRate.toString(),
                  'branch-rate': '0'
                }, nest: () {
                  builder.element('lines', nest: () {
/*
                  for (var line in r.lines.details) {
                    builder.element("line", attributes: {
                      "number": line.line.toString(),
                      "hits": line.hit.toString(),
                      "branch": "false"
                    });
                  }
*/
                  });
                });
              }
            });
          });
        });
    });

  return builder.buildDocument();
}

String _realPath(String path, String packageName) =>
    'packages/$packageName/$path';

Iterable<CoverageRecord> _mergeRecords({
  required Iterable<Record> goldens,
  required Iterable<Record> units,
  required Iterable<Record> uncovered,
}) {
  final sources =
      _getSources(goldens: goldens, units: units, uncovered: uncovered);

  return sources.map((source) {
    final goldenRecord =
        goldens.firstWhereOrNull((record) => record.file == source);
    final unitsRecord =
        units.firstWhereOrNull((record) => record.file == source);
    final uncoveredRecord =
        uncovered.firstWhereOrNull((record) => record.file == source);

    final totalLines = goldenRecord?.lines?.details?.length ??
        unitsRecord?.lines?.details?.length ??
        uncoveredRecord?.lines?.details?.length ??
        0;

    final lines = [
      for (var index = 0; index < totalLines; ++index)
        if (_isFound(
          goldens: goldenRecord,
          units: unitsRecord,
          uncovered: uncoveredRecord,
          index: index,
        ))
          Line(
            index: index,
            hits: _hitsCount(
              goldens: goldenRecord,
              units: unitsRecord,
              uncovered: uncoveredRecord,
              index: index,
            ),
            onlyFromGoldens: _onlyFromGoldens(
              goldens: goldenRecord,
              units: unitsRecord,
              index: index,
            ),
          ),
    ];

    return CoverageRecord(file: source, lines: lines);
  }).toList();
}

bool _isFound({
  required Record? goldens,
  required Record? units,
  required Record? uncovered,
  required int index,
}) =>
    (goldens?.lines?.details ?? []).any((line) => line.line == index) ||
    (units?.lines?.details ?? []).any((line) => line.line == index) ||
    (uncovered?.lines?.details ?? []).any((line) => line.line == index);

int _hitsCount({
  required Record? goldens,
  required Record? units,
  required Record? uncovered,
  required int index,
}) =>
    _lineHits(goldens, index) +
    _lineHits(units, index) +
    _lineHits(uncovered, index);

bool _onlyFromGoldens({
  required Record? goldens,
  required Record? units,
  required int index,
}) =>
    _lineHits(goldens, index) > 0 && _lineHits(units, index) == 0;

int _lineHits(Record? record, int index) {
  final details = record?.lines?.details ?? [];

  return details.firstWhereOrNull((line) => line.line == index)?.hit ?? 0;
}

Iterable<String> _getSources({
  required Iterable<Record> goldens,
  required Iterable<Record> units,
  required Iterable<Record> uncovered,
}) =>
    goldens.map((record) => record.file).whereType<String>().toSet()
      ..addAll(units.map((record) => record.file).whereType<String>())
      ..addAll(uncovered.map((record) => record.file).whereType<String>());
