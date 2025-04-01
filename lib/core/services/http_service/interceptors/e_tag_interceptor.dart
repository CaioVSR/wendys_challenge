import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:wendys_challenge/core/services/cache_service/cache_service.dart';
import 'package:wendys_challenge/core/services/http_service/models/e_tag_model.dart';

/// An interceptor for Dio HTTP client that implements ETag-based caching.
///
/// This interceptor manages HTTP caching using the ETag mechanism, which
/// allows clients to validate cached resources with the server. When the
/// server returns an ETag header, this interceptor stores the response
/// along with the ETag. For subsequent requests to the same URL, it adds
/// the "If-None-Match" header with the stored ETag.
///
/// If the resource hasn’t changed, the server responds with a 304 status
/// code (Not Modified), and this interceptor serves the cached content
/// instead of downloading it again, improving performance and reducing
/// bandwidth usage.
class ETagInterceptor extends Interceptor {
  /// Creates a new instance of [ETagInterceptor] with the specified cache
  /// service.
  ///
  /// The [_cache] parameter is used to store and retrieve ETags and cached
  /// response data.
  const ETagInterceptor(this._cache);

  final CacheService _cache;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final eTagKey = options.uri.toString();
    final cachedETag = await _cache.getString(eTagKey);

    if (cachedETag != null) {
      log('Using cached ETag for $eTagKey');

      final eTag = ETagModel.fromJson(
        jsonDecode(cachedETag) as Map<String, dynamic>,
      );

      log('ETag: ${eTag.eTag}');

      options.headers['If-None-Match'] = eTag.eTag;
    }

    return super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (response.statusCode == 200) {
      final eTag = response.headers['ETag']?.first;

      if (eTag != null) {
        log('Caching ETag for ${response.requestOptions.uri}');

        final eTagKey = response.requestOptions.uri.toString();
        final eTagModel = ETagModel(eTag: eTag, payload: response.data);

        await _cache.setString(eTagKey, jsonEncode(eTagModel));
      }
    }

    return super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    log('Original response status code: ${err.response?.statusCode}');

    if (err.response?.statusCode == 304) {
      log('Using cached response for ${err.requestOptions.uri}');

      final cacheKey = err.requestOptions.uri.toString();
      final cachedData = await _cache.getString(cacheKey);

      if (cachedData == null) {
        log('No cached data found for $cacheKey \nRemoving ETag from cache');

        await _cache.remove(cacheKey);

        return handler.next(err);
      }

      final eTag = ETagModel.fromJson(
        jsonDecode(cachedData) as Map<String, dynamic>,
      );

      final response =
          err.response!
            ..statusCode = 200
            ..data = eTag.payload;

      return handler.resolve(response);
    }

    return handler.next(err);
  }
}
