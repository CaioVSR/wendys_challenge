import 'package:wendys_challenge/core/base/base_injection.dart';
import 'package:wendys_challenge/features/splash/presentation/cubit/splash_cubit.dart';

/// Injection class for the Splash feature.
///
/// This class extends [BaseInjection] and is responsible for registering the
/// dependencies required by the splash feature. It registers the lazy
/// singleton instance of [SplashCubit] that manages the splash screen state.
class SplashInjections extends BaseInjection {
  /// Creates a new instance of [SplashInjections].
  ///
  /// The constructor registers a lazy singleton of [SplashCubit] using the
  /// dependency injection container.
  SplashInjections()
    : super(
        scopeName: 'Splash',
        registrations: [(i) => i.registerLazySingleton(SplashCubit.new)],
      );
}
