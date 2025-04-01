import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wendys_challenge/core/base/injection_scope_wrapper.dart';
import 'package:wendys_challenge/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:wendys_challenge/features/splash/presentation/screens/splash_screen.dart';
import 'package:wendys_challenge/features/splash/splash_injections.dart';

/// A route that displays the splash screen.
///
/// [SplashRoutes] extends [GoRoute] and defines the settings for the splash
/// screen route. It sets up dependency injection and provides a
/// [SplashCubit] to manage the splash state. The route is wrapped with an
/// [InjectionScopeWrapper] to ensure the proper setup and teardown of the
/// dependency injection scope.
class SplashRoutes extends GoRoute {
  /// Creates a new instance of [SplashRoutes].
  ///
  /// The route is defined with the path '/' and the name 'splash'. The builder
  /// function initializes the [SplashCubit] using [SplashInjections] and wraps
  /// the [SplashScreen] in the required injection and Bloc providers.
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
