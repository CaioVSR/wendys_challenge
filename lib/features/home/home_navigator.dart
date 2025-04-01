import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Extension on [BuildContext] that provides convenient navigation methods.
///
/// This extension simplifies route management by exposing helper methods to
/// navigate between screens using named routes with the [GoRouter] package.
extension HomeNavigator on BuildContext {
  /// Navigates to the home screen
  void goToHome() => goNamed('home');
}
