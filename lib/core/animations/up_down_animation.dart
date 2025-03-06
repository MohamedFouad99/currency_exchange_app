import 'package:flutter/material.dart';

///Adding Up Down Transition to a given child
class UpDownAnimation extends StatefulWidget {
  final Widget child;
  final double? y;

  ///reverse the animation to be Down To Up
  final bool? reverse;
  final double delay;
  const UpDownAnimation({
    super.key,
    required this.child,
    this.reverse,
    this.delay = 0.0,
    this.y,
  });

  @override
  UpDownAnimationState createState() => UpDownAnimationState();
}

class UpDownAnimationState extends State<UpDownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> translateAnimation;
  late Animation<double> fadeAnimation;
  final bool isAnimatable = true;

  @override

  /// Initializes the animation controller and tweens when the widget is
  /// initialized. If the widget is not animatable, this does nothing.
  void initState() {
    super.initState();
    if (isAnimatable) {
      controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      );
      translateAnimation = Tween<Offset>(
        begin: widget.reverse ?? false
            ? Offset(0, widget.y ?? 1)
            : Offset(0, widget.y ?? -1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.fastEaseInToSlowEaseOut,
        ),
      );
      fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.ease,
        ),
      );
      Future.delayed(Duration(milliseconds: (500 * widget.delay).round()))
          .then((value) {
        controller.forward();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override

  /// Builds the widget tree for the UpDownAnimation.
  ///
  /// If the widget is animatable, it wraps the provided child widget
  /// with a FadeTransition and SlideTransition, applying the fade and
  /// translation animations. If not animatable, it simply returns the
  /// child widget without any transitions.
  Widget build(BuildContext context) {
    return isAnimatable
        ? FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: translateAnimation,
              child: widget.child,
            ),
          )
        : widget.child;
  }
}
