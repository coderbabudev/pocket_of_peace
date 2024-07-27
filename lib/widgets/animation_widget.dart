import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({
    super.key,
    required this.child,
    required this.animationType,
  });

  final Widget child;
  final String animationType;

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
    fadeAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    scaleAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: const Offset(0, 1),
    ).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return widget.animationType == 'FADE'
        ? FadeTransition(
            opacity: fadeAnimation,
            child: widget.child,
          )
        : widget.animationType == 'SCALE'
            ? ScaleTransition(
                scale: scaleAnimation,
                child: widget.child,
              )
            : SlideTransition(
                position: slideAnimation,
                child: widget.child,
              );
  }
}
