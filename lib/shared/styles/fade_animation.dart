import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  const FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    // Define the animation using a TimelineTween
    final tween = TimelineTween()
      ..addScene(
        begin: Duration(milliseconds: 0),
        end: Duration(milliseconds: 500),
      )
          .animate("opacity", tween: Tween(begin: 0.0, end: 1.0))
          .animate("translateY", tween: Tween(begin: -30.0, end: 0.0), curve: Curves.easeOut);

    return PlayAnimation<TimelineValue>(
      tween: tween,
      duration: tween.duration,
      delay: Duration(milliseconds: (500 * delay).round()),
      builder: (context, child, animation) {
        // Access the opacity and translateY directly from the animation object
        return Opacity(
          opacity: animation.get("opacity"), // animation["opacity"] gives the opacity value
          child: Transform.translate(
            offset: Offset(0, animation.get("translateY")), // animation["translateY"] gives the translate value
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}