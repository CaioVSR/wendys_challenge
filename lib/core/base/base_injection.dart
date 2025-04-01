import 'dart:developer';

import 'package:get_it/get_it.dart';

/// An abstract class that manages scoped dependency injection using GetIt.
///
/// This class provides methods to set up and tear down dependency injections
/// within a specific scope. Concrete implementations should
/// define the scope name
/// and provide registration functions.
///
/// Example usage:
/// ```dart
/// class AppInjection extends BaseInjection {
///   AppInjection() : super(
///     scopeName: 'app',
///     registrations: [
///       (injector) => injector.registerSingleton<SomeService>(
///         SomeServiceImpl()
///      ),
///     ],
///   );
/// }
/// ```
abstract class BaseInjection {
  /// Creates a [BaseInjection] instance.
  ///
  /// [scopeName] is a unique identifier for this injection scope.
  /// [registrations] is a list of functions that register dependencies.
  BaseInjection({required this.scopeName, required this.registrations});

  /// The name of the scope for this injection context.
  ///
  /// Used for both logging and scope identification in GetIt.
  final String scopeName;

  /// List of registration functions that will be called during [setUp].
  ///
  /// Each function receives the GetIt injector instance to register
  /// dependencies.
  final List<void Function(GetIt)> registrations;

  /// A shorthand reference to the GetIt instance.
  final injector = GetIt.I;

  /// Sets up the dependency injection scope.
  ///
  /// Creates a new GetIt scope with the specified [scopeName] and
  /// executes all registration functions defined in [registrations].
  ///
  /// Logs the setup process with a green color in the console.
  Future<void> setUp() async {
    final injector = GetIt.instance;
    log('\x1B[92mSetting up ${scopeName.toUpperCase()} injections');

    await injector.pushNewScopeAsync(
      scopeName: scopeName,
      init: (_) async {
        for (final register in registrations) {
          register(injector);
        }
      },
    );
  }

  /// Tears down the dependency injection scope.
  ///
  /// Removes the current GetIt scope, effectively cleaning up all
  /// registered dependencies in this scope.
  ///
  /// Logs the teardown process with a red color in the console.
  Future<void> tearDown() async {
    final injector = GetIt.instance;

    log('\x1B[91mTearing down ${scopeName.toUpperCase()} injections');
    await injector.popScope();
  }
}
