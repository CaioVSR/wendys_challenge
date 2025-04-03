import 'package:dio/dio.dart';
import 'package:wendys_challenge/core/services/http_service/interceptors/e_tag_interceptor.dart';

/// A service interface for handling HTTP requests in the app.
///
/// This sealed class defines the contract for HTTP operations, providing a
/// clean abstraction over the underlying HTTP client implementation. Using
/// this interface allows the application to easily swap HTTP clients without
/// affecting the consuming code.
sealed class HttpService {
  /// Performs an HTTP GET request to the specified path.
  ///
  /// [path] is the endpoint path to request.
  /// [queryParameters] are optional query parameters to include in the
  /// request.
  /// Returns a [Future] containing the HTTP response.
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
}


/// Implementation of [HttpService] using the Dio HTTP client.
///
/// This class provides concrete implementations of HTTP operations using the
/// Dio package. It configures the Dio instance with the necessary base URL and
/// attaches the ETag interceptor for efficient caching of responses.
class HttpServiceImpl implements HttpService {
  /// Creates a new instance of [HttpServiceImpl] with the specified
  /// dependencies.
  ///
  /// The [_dio] parameter is the Dio instance used for HTTP requests.
  /// The [_eTagInterceptor] parameter is used for HTTP caching.
  HttpServiceImpl(this._dio, this._eTagInterceptor) {
    _dio.interceptors.add(_eTagInterceptor);

    _dio.options.baseUrl =
        'https://api.app.tst.wendys.digital/web-client-gateway';
  }

  final Dio _dio;
  final ETagInterceptor _eTagInterceptor;

  @override
  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(path, queryParameters: queryParameters);
  }
}
