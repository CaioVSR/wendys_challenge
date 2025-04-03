import 'package:wendys_challenge/core/base/base_injection.dart';
import 'package:wendys_challenge/features/splash/presentation/cubit/splash_cubit.dart';

/// Injection class for the `Splash` feature.
///
/// This class extends [BaseInjection] and is responsible for registering the
/// dependencies required by a specific feature. It registers the necessary
/// dependencies (such as cubits, repositories, or services) needed to manage
/// the feature's state and functionality.
class SplashInjections extends BaseInjection {
  /// Creates a new instance of the injection class.
  ///
  /// The constructor registers the necessary dependencies using the dependency
  /// injection container.
  SplashInjections()
    : super(
        scopeName: 'Splash',
        registrations: [(i) => i.registerLazySingleton(SplashCubit.new)],
      );
}
