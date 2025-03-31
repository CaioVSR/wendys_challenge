import 'dart:developer';

import 'package:flutter/material.dart';

/// A [NavigatorObserver] that logs route navigation events to the console.
///
/// This observer logs route transitions with formatted output including:
/// - The type of navigation action (push, pop, replace, remove)
/// - The source route name (where navigation started from)
/// - The destination route name (where navigation is going to)
/// - Any data/arguments passed during navigation
class AppRouteLogger extends NavigatorObserver {
  /// Logs navigation events with formatted output.
  ///
  /// Displays the navigation action, source route, destination route, and any
  /// passed data to the console with purple-colored text.
  ///
  /// [action] The type of navigation action (e.g., "Push", "Pop")
  /// [route] The current/destination route
  /// [previousRoute] The previous/source route
  void _log(
    String action,
    Route<dynamic>? route,
    Route<dynamic>? previousRoute,
  ) {
    final from = previousRoute?.settings.name ?? 'none';
    final to = route?.settings.name ?? 'none';
    final data = route?.settings.arguments ?? 'none';

    log('''
\x1B[35m---------- ${action.toUpperCase()} ----------
\x1B[35mFrom: $from -> To: $to
\x1B[35mData: $data
''');
  }

  /// Called when a new route is pushed onto the navigator.
  ///
  /// Logs the push action with route information.
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Push', route, previousRoute);
    super.didPush(route, previousRoute);
  }

  /// Called when a route is popped from the navigator.
  ///
  /// Logs the pop action with route information.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Pop', previousRoute, route);
    super.didPop(route, previousRoute);
  }

  /// Called when a route is replaced on the navigator.
  ///
  /// Logs the replace action with route information.
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _log('Replace', newRoute, oldRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  /// Called when a route is removed from the navigator.
  ///
  /// Logs the remove action with route information.
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _log('Remove', previousRoute, route);
    super.didRemove(route, previousRoute);
  }
}
