import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeAnimation extends StatefulWidget {
  const LikeAnimation({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    required this.onEnd,
    this.smallLike = false,
  });
  final Widget child; // to make LikeAnimation  parent
  final bool isAnimating; //
  final Duration duration; // duration the like should animate
  final VoidCallback? onEnd; // to end LikeAnimation
  final bool smallLike; // whether like button already clicked or not

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scale;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: widget.duration.inMilliseconds ~/
              2, // divides and converts to int
        ));
    scale = Tween<double>(begin: 1, end: 1.2).animate(_animationController);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await _animationController.forward();

      await _animationController.reverse();
      await Future.delayed(
        Duration(
          milliseconds: 1000,
        ),
      ); // delay the heart shown on liking.
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
