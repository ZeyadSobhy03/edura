import 'package:flutter/material.dart';

class LoadingDots extends StatefulWidget {
  const LoadingDots({
    super.key,
    this.color = Colors.white,
    this.size = 10,
    this.spacing = 8,
  });

  final Color color;
  final double size;
  final double spacing;

  @override
  State<LoadingDots> createState() => _LoadingDotsState();
}

class _LoadingDotsState extends State<LoadingDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _animations = List.generate(
      3,
          (index) => Tween<double>(
        begin: 0,
        end: -10,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            index * 0.2,
            0.6 + index * 0.2,
            curve: Curves.easeInOutCubic,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _dot(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(_animations[0]),
        SizedBox(width: widget.spacing),
        _dot(_animations[1]),
        SizedBox(width: widget.spacing),
        _dot(_animations[2]),
      ],
    );
  }
}