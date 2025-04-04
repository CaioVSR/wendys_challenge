import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wendys_challenge/core/base/base_injection.dart';
import 'package:wendys_challenge/core/services/cache_service/cache_service.dart';
import 'package:wendys_challenge/core/services/http_service/http_service.dart';
import 'package:wendys_challenge/core/services/http_service/interceptors/e_tag_interceptor.dart';
import 'package:wendys_challenge/features/cart/cart_injections.dart';

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
          (i) => i.registerSingleton<Future<SharedPreferences>>(
            SharedPreferences.getInstance(),
          ),
          (i) => i.registerSingleton<CacheService>(CacheServiceImpl(i.get())),
          (i) => i.registerSingleton<Dio>(Dio()),
          (i) => i.registerSingleton<ETagInterceptor>(
            ETagInterceptor(i.get<CacheService>()),
          ),
          (i) => i.registerSingleton<HttpService>(
            HttpServiceImpl(i.get(), i.get()),
          ),
          ...CartInjections().registrations,
        ],
      );
}
