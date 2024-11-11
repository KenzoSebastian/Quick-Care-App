import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedScaleCustom extends StatelessWidget {
  final Widget child;
  final int delay;
  final int duration;

  const AnimatedScaleCustom({
    super.key,
    required this.child,
    this.delay = 0,
    this.duration = 500,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().scale(delay: delay.ms, duration: duration.ms, curve: Curves.ease);
  }
}
