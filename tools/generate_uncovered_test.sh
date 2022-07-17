#!/usr/bin/env bash
dart pub upgrade --directory=tools/builder
dart run tools/builder/bin/generate_uncovered_test.dart
