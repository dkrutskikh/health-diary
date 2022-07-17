import 'dart:math';

import 'package:flutter/material.dart';

import 'set_progress_indicator_painter.dart';
import 'set_progress_indicator_utils.dart';

const _kIndeterminateCircularDuration = 1800;

class SetProgressIndicator extends StatefulWidget {
  final double progress;
  final Duration duration;

  const SetProgressIndicator({
    super.key,
    this.progress = 0.0,
    required this.duration,
  });

  @override
  State<StatefulWidget> createState() => _SetProgressIndicatorState();
}

class _SetProgressIndicatorState extends State<SetProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> tweenAnimation;
  late CurvedAnimation curvedAnimation;

  double prevProgress = 0.0;
  String timer = '';

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateCircularDuration),
      vsync: this,
    );

    final progress = max(min(widget.progress, 1.0), 0).toDouble();
    prevProgress = progress;

    curvedAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    tweenAnimation =
        Tween(begin: prevProgress, end: progress).animate(curvedAnimation);

    controller.forward();

    timer = formatCountdownTime(widget.duration, progress);
  }

  @override
  void didUpdateWidget(SetProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    final progress = max(min(widget.progress, 1.0), 0).toDouble();
    prevProgress = progress;

    tweenAnimation =
        Tween(begin: prevProgress, end: progress).animate(curvedAnimation);

    controller
      ..reset()
      ..forward();

    timer = formatCountdownTime(widget.duration, progress);
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: tweenAnimation,
            builder: (_, __) => CustomPaint(
              foregroundPainter:
                  SetProgressIndicatorPainter(percent: tweenAnimation.value),
            ),
          ),
          Row(
            children: [
              const Spacer(),
              Expanded(flex: 8, child: FittedBox(child: Text(timer))),
              const Spacer(),
            ],
          ),
        ],
      );

  void stopAnimation() {
    controller.stop();
  }
}
