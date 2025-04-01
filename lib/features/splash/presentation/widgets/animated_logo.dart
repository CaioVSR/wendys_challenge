import 'package:flutter/material.dart';
import 'package:wendys_challenge/core/theme/theme_images_paths.dart';

/// A widget that displays an animated logo with a fade-in effect.
///
/// This widget uses an [AnimationController] to animate the logo's opacity.
/// The animation is triggered after the first frame is rendered.
class AnimatedLogo extends StatefulWidget {
  /// Creates an instance of [AnimatedLogo].
  ///
  /// The [key] parameter is used to uniquely identify the widget.
  const AnimatedLogo({super.key});

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animationController.forward();
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(opacity: animation.value, child: child);
      },
      child: Image.asset(ThemeImagesPaths.wendysLogo, fit: BoxFit.contain),
    );
  }
}
