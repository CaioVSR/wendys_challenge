import 'package:go_router/go_router.dart';
import 'package:wendys_challenge/app/app_route_logger.dart';
import 'package:wendys_challenge/features/splash/splash_routes.dart';

/// Manages the application's routing configuration.
///
/// This class provides a centralized place to define all routes used
/// throughout the application using the go_router package.
class AppRoutes {
  /// Private constructor to prevent instantiation.
  ///
  /// This class is not meant to be instantiated, as it serves as a
  /// static container for routing configuration.
  const AppRoutes._();

  /// The application's router configuration.
  ///
  /// This router handles all navigation within the app and includes
  /// route logging via [AppRouteLogger].
  static final routerConfig = GoRouter(
    observers: [AppRouteLogger()],
    routes: [
      SplashRoutes(),
    ],
  );
}
