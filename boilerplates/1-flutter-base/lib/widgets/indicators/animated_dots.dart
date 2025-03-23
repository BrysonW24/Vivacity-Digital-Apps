import 'package:flutter/material.dart';
import 'dart:math';   // 👈 required for sin()

/// Animated bouncing dots indicator — often used in chat apps or splash screens.
/// Can be used to show "loading..." in a stylish way.

class AnimatedDots extends StatefulWidget {
  const AnimatedDots({super.key});

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 3.14).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (i) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Transform.translate(
              offset: Offset(0, 5 * (1 + (0.5 * i)) * (1 - sin(_animation.value))),
              child: const Dot(),
            ),
          );
        }),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(radius: 4, backgroundColor: Colors.blue);
  }
}
