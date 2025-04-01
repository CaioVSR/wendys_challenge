import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wendys_challenge/core/base/injection_scope_wrapper.dart';
import 'package:wendys_challenge/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:wendys_challenge/features/splash/presentation/screens/splash_screen.dart';
import 'package:wendys_challenge/features/splash/splash_injections.dart';

/// A route that displays the [SplashScreen] screen.
///
/// This route extends [GoRoute] and defines the settings for a particular
/// screen. It sets up dependency injection and provides the necessary state
/// management via the required providers. The route is wrapped with an
/// [InjectionScopeWrapper] to ensure proper setup and teardown of the
/// dependency injection scope.
class SplashRoutes extends GoRoute {
  /// Creates a new instance of the route.
  ///
  /// The route is defined with a specific path and name. The builder function
  /// initializes the required state management and dependency injection, and
  /// wraps the target screen with the necessary providers and wrappers.
  SplashRoutes()
    : super(
        path: '/',
        name: 'splash',
        builder: (context, state) {
          final splashInjector = SplashInjections();

          return InjectionScopeWrapper(
            tearDown: splashInjector.tearDown,
            setUp: splashInjector.setUp,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (_) =>
                          splashInjector.injector<SplashCubit>()..initialize(),
                ),
              ],
              child: const SplashScreen(),
            ),
          );
        },
      );
}
