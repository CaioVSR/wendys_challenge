import 'package:shared_preferences/shared_preferences.dart';
import 'package:wendys_challenge/core/base/base_injection.dart';

/// [AppInjections] is responsible for registering application-wide dependencies
/// that need to be accessible throughout the app lifecycle.
///
/// This class extends [BaseInjection] to leverage the dependency injection
/// framework for registering and resolving dependencies.
class AppInjections extends BaseInjection {
  /// Creates a new instance of [AppInjections].
  ///
  /// Initializes the dependency injection container with app-level
  /// dependencies like [SharedPreferences] which provides persistent storage
  /// capabilities for the application.
  AppInjections()
    : super(
        scopeName: 'App',
        registrations: [
          (i) => i.registerSingletonAsync<SharedPreferences>(
            SharedPreferences.getInstance,
          ),
        ],
      );
}
