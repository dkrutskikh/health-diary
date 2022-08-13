import 'dart:math';

import 'package:flutter/material.dart';

const _startAngle = pi * 3 / 4;
const _sweepAngle = pi * 6 / 4;
const _gradientAdditionalAngle = pi / 16;
const _strokeWidth = 10.0;

const _backgroundColor = Colors.grey;
const _gradient = SweepGradient(
  endAngle: _sweepAngle + _gradientAdditionalAngle * 2,
  colors: [Colors.blue, Colors.green],
  tileMode: TileMode.mirror,
  transform: GradientRotation(_startAngle - _gradientAdditionalAngle),
);

class SetProgressIndicatorPainter extends CustomPainter {
  final double percent;

  SetProgressIndicatorPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final bgLine = _buildPaint(_backgroundColor, _strokeWidth);

    final progressLine = _buildPaint(_gradient.colors.first, _strokeWidth);

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    progressLine.shader = _gradient.createShader(
      Rect.fromCenter(height: radius, center: center, width: radius),
    );

    final arcRect = Rect.fromCenter(
      center: center,
      width: radius * 2,
      height: radius * 2,
    );

    canvas
      ..drawArc(arcRect, _startAngle, _sweepAngle, false, bgLine)
      ..drawArc(
        arcRect,
        _startAngle,
        _sweepAngle * percent,
        false,
        progressLine,
      );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  Paint _buildPaint(Color color, double width) => Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = width;
}
