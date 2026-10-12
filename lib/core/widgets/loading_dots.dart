import 'dart:math' as math;

import 'package:flutter/material.dart';


class LoadingDots extends StatefulWidget {
  const LoadingDots({
    super.key,
    this.color = Colors.white,
    this.size = 10,
    this.spacing = 8,
    this.bounce = 10,
    this.duration = const Duration(milliseconds: 1400),
  });

  final Color color;
  final double size;
  final double spacing;

  /// How high each dot travels.
  final double bounce;

  /// Duration of one full wave across all dots.
  final Duration duration;

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  static const int _count = 3;
  static const double _stagger = 0.16; // delay between dots (fraction of loop)
  static const double _active = 0.55; // portion of loop each dot is moving

  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void didUpdateWidget(covariant LoadingDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller.duration = widget.duration;
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  double _pulse(double t, int index) {
    final p = (t - index * _stagger) % 1.0;
    final phase = p < 0 ? p + 1 : p;
    if (phase > _active) return 0;
    final x = phase / _active;
    return Curves.easeInOutSine.transform(math.sin(x * math.pi));
  }

  Widget _dot(double v) {
    final s = widget.size;
    final dy = -widget.bounce * v;
    final scale = 0.72 + 0.38 * v;
    final alpha = (0.4 + 0.6 * v).clamp(0.0, 1.0);
    final color = widget.color.withAlpha((alpha * 255).round());

    return Transform.translate(
      offset: Offset(0, dy),
      child: Transform.scale(
        scale: scale,
        child: Container(
          width: s,
          height: s,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.color
                    .withAlpha((alpha * 255 * 0.45).round()),
                blurRadius: s * 1.2 * v,
                spreadRadius: s * 0.1 * v,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: SizedBox(
        height: widget.size + widget.bounce * 2,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, _) {
            final t = _controller.value;
            return Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < _count; i++) ...[
                  if (i > 0) SizedBox(width: widget.spacing),
                  _dot(_pulse(t, i)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}