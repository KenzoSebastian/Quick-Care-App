import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AnimatedFade extends StatelessWidget {
  final Widget child;
  final int delay;
  final int duration;

  const AnimatedFade({
    super.key,
    required this.child,
    this.delay = 0,
    this.duration = 200,
  });

  @override
  Widget build(BuildContext context) {
    return child.animate().fade(delay: delay.ms, duration: duration.ms);
  }
}
