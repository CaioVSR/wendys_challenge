import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

/// A reusable widget that displays a centered loading animation.
///
/// This widget presents a staggered dots wave animation in red accent color,
/// providing visual feedback to users during asynchronous operations like
/// data fetching or processing.
///
/// The animation is centered within its parent container and uses a fixed
/// size of 64 logical pixels.
///
/// Example usage:
/// ```dart
/// if (state.isLoading) {
///   return const LoadingWidget();
/// }
/// ```
class LoadingWidget extends StatelessWidget {
  /// Creates a [LoadingWidget] instance.
  ///
  /// This widget doesn't require any parameters as it uses predefined
  /// styling and animation.
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: Colors.redAccent,
        size: 64,
      ),
    );
  }
}
