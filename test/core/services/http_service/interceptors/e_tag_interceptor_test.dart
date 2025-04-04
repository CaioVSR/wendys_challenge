import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/core/services/cache_service/cache_service.dart';
import 'package:wendys_challenge/core/services/http_service/interceptors/e_tag_interceptor.dart';
import 'package:wendys_challenge/core/services/http_service/models/e_tag_model.dart';

class MockCacheService extends Mock implements CacheService {}

class TestRequestHandler extends RequestInterceptorHandler {
  bool nextCalled = false;
  @override
  void next(RequestOptions options) {
    nextCalled = true;
    super.next(options);
  }
}

class TestResponseHandler extends ResponseInterceptorHandler {
  bool nextCalled = false;
  Response<dynamic>? resolvedResponse;

  @override
  void next(Response<dynamic> response) {
    nextCalled = true;
    super.next(response);
  }

  @override
  void resolve(Response<dynamic> response, [bool? followUp]) {
    resolvedResponse = response;
  }
}

class TestErrorHandler extends ErrorInterceptorHandler {
  bool nextCalled = false;
  Response<dynamic>? resolvedResponse;
  DioException? errorPassed;

  @override
  void next(DioException err) {
    nextCalled = true;
    errorPassed = err;
  }

  @override
  void resolve(Response<dynamic> response, [bool? followUp]) {
    resolvedResponse = response;
  }
}

void main() {
  late MockCacheService mockCacheService;
  late ETagInterceptor interceptor;
  late TestRequestHandler requestHandler;
  late TestResponseHandler responseHandler;
  late TestErrorHandler errorHandler;
  const testETag = 'W/"test-etag"';
  const testUrl = 'https://example.com/test';
  final testPayload = {'data': 'response-data'};

  setUp(() {
    mockCacheService = MockCacheService();
    requestHandler = TestRequestHandler();
    responseHandler = TestResponseHandler();
    errorHandler = TestErrorHandler();
    when(
      () => mockCacheService.setString(any(), any()),
    ).thenAnswer((_) async => true);

    when(() => mockCacheService.remove(any())).thenAnswer((_) async => true);
    interceptor = ETagInterceptor(mockCacheService);
  });

  group('ETagInterceptor', () {
    group('onRequest', () {
      test('adds "If-None-Match" header when cached ETag exists', () async {
        final cachedModel = ETagModel(eTag: testETag, payload: testPayload);
        final cachedString = jsonEncode(cachedModel.toJson());
        when(
          () => mockCacheService.getString(any()),
        ).thenAnswer((_) async => cachedString);

        final options = RequestOptions(path: testUrl);

        await interceptor.onRequest(options, requestHandler);

        expect(options.headers['If-None-Match'], equals(testETag));
        expect(requestHandler.nextCalled, isTrue);
        verify(() => mockCacheService.getString(testUrl)).called(1);
      });

      test('does not add header when no cached ETag exists', () async {
        when(
          () => mockCacheService.getString(any()),
        ).thenAnswer((_) async => null);
        final options = RequestOptions(path: testUrl);

        await interceptor.onRequest(options, requestHandler);

        expect(options.headers.containsKey('If-None-Match'), isFalse);
        expect(requestHandler.nextCalled, isTrue);
        verify(() => mockCacheService.getString(testUrl)).called(1);
      });
    });

    group('onResponse', () {
      test(
        'caches ETag when response status is 200 and ETag header exists',
        () async {
          when(
            () => mockCacheService.setString(any(), any()),
          ).thenAnswer((_) async => true);
          final response = Response(
            requestOptions: RequestOptions(path: testUrl),
            statusCode: 200,
            data: testPayload,
            headers: Headers.fromMap({
              'ETag': [testETag],
            }),
          );

          await interceptor.onResponse(response, responseHandler);

          final captured =
              verify(
                () => mockCacheService.setString(testUrl, captureAny()),
              ).captured;
          final cachedJson = captured[0] as String;
          final decoded = jsonDecode(cachedJson) as Map<String, dynamic>;
          final cachedModel = ETagModel.fromJson(decoded);
          expect(cachedModel.eTag, equals(testETag));
          expect(cachedModel.payload, equals(testPayload));
          expect(responseHandler.nextCalled, isTrue);
        },
      );

      test('does nothing when response status is not 200', () async {
        final response = Response(
          requestOptions: RequestOptions(path: testUrl),
          statusCode: 404,
          data: testPayload,
          headers: Headers.fromMap({
            'ETag': [testETag],
          }),
        );

        await interceptor.onResponse(response, responseHandler);

        verifyNever(() => mockCacheService.setString(any(), any()));
        expect(responseHandler.nextCalled, isTrue);
      });
    });

    group('onError', () {
      test(
        '''
resolves with cached response when error status is 304 and cache exists''',
        () async {
          final cachedModel = ETagModel(eTag: testETag, payload: testPayload);
          final cachedString = jsonEncode(cachedModel.toJson());
          when(
            () => mockCacheService.getString(any()),
          ).thenAnswer((_) async => cachedString);

          final options = RequestOptions(path: testUrl);
          final response = Response<dynamic>(
            requestOptions: options,
            statusCode: 304,
          );
          final dioError = DioException(
            requestOptions: options,
            response: response,
            type: DioExceptionType.badResponse,
          );

          await interceptor.onError(dioError, errorHandler);

          expect(errorHandler.resolvedResponse, isNotNull);
          expect(errorHandler.resolvedResponse!.statusCode, equals(200));
          expect(errorHandler.resolvedResponse!.data, equals(testPayload));
          expect(errorHandler.nextCalled, isFalse);
          verify(() => mockCacheService.getString(testUrl)).called(1);
        },
      );

      test(
        'removes cache and passes error when 304 and no cached data',
        () async {
          when(
            () => mockCacheService.getString(any()),
          ).thenAnswer((_) async => null);

          when(
            () => mockCacheService.remove(any()),
          ).thenAnswer((_) async => true);

          final options = RequestOptions(path: testUrl);
          final response = Response<dynamic>(
            requestOptions: options,
            statusCode: 304,
          );

          final dioError = DioException(
            requestOptions: options,
            response: response,
            type: DioExceptionType.badResponse,
          );

          await interceptor.onError(dioError, errorHandler);

          expect(errorHandler.resolvedResponse, isNull);
          expect(errorHandler.errorPassed, isNotNull);
          verify(() => mockCacheService.remove(testUrl)).called(1);
        },
      );

      test('passes error to next handler when status is not 304', () async {
        final options = RequestOptions(path: testUrl);
        final response = Response(
          requestOptions: options,
          statusCode: 500,
          data: 'Internal Server Error',
        );
        final dioError = DioException(
          requestOptions: options,
          response: response,
          type: DioExceptionType.badResponse,
        );

        await interceptor.onError(dioError, errorHandler);

        expect(errorHandler.errorPassed, isNotNull);
        expect(errorHandler.resolvedResponse, isNull);
        expect(errorHandler.nextCalled, isTrue);
      });
    });
  });
}
