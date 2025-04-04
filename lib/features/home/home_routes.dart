import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wendys_challenge/core/utils/injection_scope_wrapper.dart';
import 'package:wendys_challenge/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:wendys_challenge/features/home/home_injections.dart';
import 'package:wendys_challenge/features/home/presentation/cubit/get_menus_cubit.dart';
import 'package:wendys_challenge/features/home/presentation/screens/home_screen.dart';
import 'package:wendys_challenge/features/home/presentation/screens/product_screen.dart';
import 'package:wendys_challenge/features/home/presentation/screens/sub_menu_screen.dart';

/// A route that displays the [HomeScreen] screen.
///
/// This route extends [GoRoute] and defines the settings for a particular
/// screen. It sets up dependency injection and provides the necessary state
/// management via the required providers. The route is wrapped with an
/// [InjectionScopeWrapper] to ensure proper setup and teardown of the
/// dependency injection scope.
class HomeRoutes extends GoRoute {
  /// Creates a new instance of the route.
  ///
  /// The route is defined with a specific path and name. The builder function
  /// initializes the required state management and dependency injection, and
  /// wraps the target screen with the necessary providers and wrappers.
  HomeRoutes()
    : super(
        path: '/home',
        name: 'home',
        builder: (context, state) {
          return InjectionScopeWrapper(
            tearDown: homeInjector.tearDown,
            setUp: homeInjector.setUp,
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create:
                      (context) =>
                          homeInjector.injector<GetMenusCubit>()..getMenus(),
                ),
                BlocProvider(
                  create: (context) => homeInjector.injector<CartCubit>(),
                ),
              ],
              child: const HomeScreen(),
            ),
          );
        },
        routes: [
          GoRoute(
            path: 'sub-menu',
            name: 'sub-menu',
            builder: (context, state) {
              return SubMenuScreen(params: state.extra! as SubMenuScreenParams);
            },
          ),
          GoRoute(
            path: 'product',
            name: 'product',
            builder: (context, state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: homeInjector.injector<CartCubit>()),
                ],
                child: ProductScreen(
                  params: state.extra! as ProductScreenParams,
                ),
              );
            },
          ),
        ],
      );

  /// A static instance of the [HomeRoutes] class.
  /// This instance can be used to access the route configuration
  /// without creating a new instance.
  static final homeInjector = HomeInjections();
}
