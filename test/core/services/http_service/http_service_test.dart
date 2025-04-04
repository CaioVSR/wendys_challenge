import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/core/services/http_service/http_service.dart';
import 'package:wendys_challenge/core/services/http_service/interceptors/e_tag_interceptor.dart';

class MockDio extends Mock implements Dio {}

class MockETagInterceptor extends Mock implements ETagInterceptor {}

class MockInterceptors extends Mock implements Interceptors {}

class MockBaseOptions extends Mock implements BaseOptions {}

class FakeInterceptor extends Fake implements Interceptor {}

class FakeETagInterceptor extends Fake implements ETagInterceptor {}

class FakeMap extends Fake implements Map<String, dynamic> {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeInterceptor());
    registerFallbackValue(FakeETagInterceptor());
    registerFallbackValue(FakeMap());
  });

  late MockDio mockDio;
  late MockETagInterceptor mockETagInterceptor;
  late HttpServiceImpl httpService;
  late MockInterceptors mockInterceptors;
  late MockBaseOptions mockOptions;

  setUp(() {
    mockDio = MockDio();
    mockETagInterceptor = MockETagInterceptor();
    mockInterceptors = MockInterceptors();
    mockOptions = MockBaseOptions();

    when(() => mockDio.interceptors).thenReturn(mockInterceptors);
    when(() => mockDio.options).thenReturn(mockOptions);
    when(() => mockInterceptors.add(any())).thenReturn(null);

    httpService = HttpServiceImpl(mockDio, mockETagInterceptor);
  });

  group('HttpServiceImpl', () {
    test('constructor adds ETagInterceptor to Dio interceptors', () {
      verify(() => mockInterceptors.add(mockETagInterceptor)).called(1);
    });

    test('constructor sets the correct base URL', () {
      verify(
        () =>
            mockOptions.baseUrl =
                'https://api.app.tst.wendys.digital/web-client-gateway',
      ).called(1);
    });

    group('get', () {
      const testPath = '/menu/categories';
      final testQueryParams = {'param1': 'value1', 'param2': 'value2'};
      final mockResponse = Response(
        requestOptions: RequestOptions(path: testPath),
        statusCode: 200,
        data: {'key': 'value'},
      );

      test('calls Dio.get with correct path and query parameters', () async {
        when(
          () => mockDio.get<dynamic>(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer((_) async => mockResponse);

        final response = await httpService.get(
          testPath,
          queryParameters: testQueryParams,
        );

        expect(response.data, mockResponse.data);
        verify(
          () =>
              mockDio.get<dynamic>(testPath, queryParameters: testQueryParams),
        ).called(1);
      });
    });
  });
}
