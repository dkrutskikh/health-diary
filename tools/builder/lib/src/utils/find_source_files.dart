import 'dart:io';

import 'package:path/path.dart' as p;

Iterable<String> findSourceFiles(String package) {
  final packageDirectory = Directory('packages/$package/lib');
  if (!packageDirectory.existsSync()) {
    return [];
  }

  return _findSourceFiles(packageDirectory)
      .map((f) => p.relative(f.path, from: 'packages/$package'))
      .toSet();
}

Iterable<File> _findSourceFiles(Directory directory) {
  final sourceFiles = <File>[];

  for (final fileOrDir in directory.listSync()) {
    if (fileOrDir is File &&
        _isSourceFileHaveValidExtension(fileOrDir) &&
        _isSourceFileNotPartOfLibrary(fileOrDir)) {
      sourceFiles.add(fileOrDir);
    } else if (fileOrDir is Directory &&
        p.basename(fileOrDir.path) != 'packages') {
      sourceFiles.addAll(_findSourceFiles(fileOrDir));
    }
  }

  return sourceFiles;
}

bool _isSourceFileHaveValidExtension(File file) =>
    p.extension(file.path).endsWith('.dart');

bool _isSourceFileNotPartOfLibrary(File file) =>
    file.readAsLinesSync().every((line) => !line.startsWith('part of '));
