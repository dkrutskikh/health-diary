class Line {
  final int index;
  final int hits;
  final bool onlyFromGoldens;

  const Line({
    required this.index,
    required this.hits,
    required this.onlyFromGoldens,
  });
}

class CoverageRecord {
  final String file;
  final Iterable<Line> lines;

  const CoverageRecord({required this.file, required this.lines});
}
