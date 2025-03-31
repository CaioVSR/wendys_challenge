import 'package:flutter/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// Extension on [BuildContext] that provides utility methods for handling
/// loading overlays.
///
/// This extension simplifies showing and hiding loading overlays based on a
/// loading state.
extension LoaderOverlayX on BuildContext {
  /// Shows or hides a loading overlay based on the provided [loadInProgress]
  /// state.
  ///
  /// If [loadInProgress] is true and the overlay is not already visible,
  /// the overlay will be shown.
  /// If [loadInProgress] is false and the overlay is visible, the overlay
  /// will be hidden.
  ///
  /// Usage:
  /// ```dart
  /// context.showLoading(loadInProgress: true); // Show loading overlay
  /// context.showLoading(loadInProgress: false); // Hide loading overlay
  /// ```
  void showLoading({required bool loadInProgress}) {
    if (loadInProgress && !loaderOverlay.visible) {
      loaderOverlay.show();
    } else if (loaderOverlay.visible) {
      loaderOverlay.hide();
    }
  }
}
