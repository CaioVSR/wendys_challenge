import 'package:flutter/material.dart';

/// A widget that manages the lifecycle of dependencies for a specific scope.
///
/// This widget allows for proper initialization and cleanup of dependencies
/// by calling [setUp] when the widget is inserted into the tree and [tearDown]
/// when it's removed from the tree.
class InjectionScopeWrapper extends StatefulWidget {
  /// Creates an injection scope wrapper.
  ///
  /// The [child] is the widget below this widget in the tree.
  /// The [setUp] callback is called during `initState`.
  /// The [tearDown] callback is called during `dispose`.
  const InjectionScopeWrapper({
    required this.child,
    required this.tearDown,
    required this.setUp,
    super.key,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Callback for cleaning up dependencies when this widget is 
  /// removed from the tree.
  final VoidCallback tearDown;

  /// Callback for initializing dependencies when this widget is 
  /// inserted into the tree.
  final VoidCallback setUp;

  @override
  State<InjectionScopeWrapper> createState() => _InjectionScopeWrapperState();
}

class _InjectionScopeWrapperState extends State<InjectionScopeWrapper> {
  @override
  void initState() {
    super.initState();
    widget.setUp();
  }

  @override
  void dispose() {
    widget.tearDown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
