import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/core/services/http_service/http_service.dart';
import 'package:wendys_challenge/features/home/data/data_sources/remote/home_data_source.dart';
import 'package:wendys_challenge/features/home/data/models/menu_response_model.dart';

class MockHttpService extends Mock implements HttpService {}

void main() {
  late MockHttpService mockHttpService;
  late HomeDataSourceImpl dataSource;
  late Map<String, dynamic> mockJson;

  setUpAll(() async {
    mockHttpService = MockHttpService();
    dataSource = HomeDataSourceImpl(mockHttpService);

    final file = File('test/fixtures/menu_response_fixture.json');
    final jsonString = await file.readAsString();

    mockJson = json.decode(jsonString) as Map<String, dynamic>;
  });

  group('getHomeMenu', () {
    test('should ensure the path and query parameters', () async {
      when(
        () => mockHttpService.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/menu/getSiteMenu'),
          statusCode: 200,
          data: mockJson,
        ),
      );

      await dataSource.getHomeMenu();

      verify(
        () => mockHttpService.get(
          '/menu/getSiteMenu',
          queryParameters: {
            'cntry': 'US',
            'lang': 'en',
            'siteNum': '0',
            'sourceCode': 'ORDER.WENDYS',
            'version': '22.1.2',
          },
        ),
      ).called(1);

      verifyNoMoreInteractions(mockHttpService);
    });

    test('should be success', () async {
      when(
        () => mockHttpService.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/menu/getSiteMenu'),
          statusCode: 200,
          data: mockJson,
        ),
      );

      final result = await dataSource.getHomeMenu();

      expect(result.isRight(), true);
      result.fold((failure) => fail('Should not return failure'), (
        menuResponse,
      ) {
        expect(menuResponse, isA<MenuResponseModel>());
        expect(menuResponse.serviceStatus, 'SUCCESS');
      });
    });

    test('should return an Exception when status code is not 200', () async {
      when(
        () => mockHttpService.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/menu/getSiteMenu'),
          statusCode: 400,
          data: {'error': 'Bad Request'},
        ),
      );

      final result = await dataSource.getHomeMenu();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<Exception>()),
        (_) => fail('Should return failure'),
      );
    });

    test(
      'should return an Exception when service status is not SUCCESS',
      () async {
        final errorMockJson = mockJson;
        errorMockJson['serviceStatus'] = 'FAILED';

        when(
          () => mockHttpService.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
          ),
        ).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/menu/getSiteMenu'),
            statusCode: 200,
            data: errorMockJson,
          ),
        );

        final result = await dataSource.getHomeMenu();

        expect(result.isLeft(), true);
        result.fold(
          (failure) {
            expect(failure, isA<Exception>());
            expect(
              failure.toString(),
              'Exception: Service status is not SUCCESS',
            );
          },
          (_) {
            fail('Should return failure');
          },
        );
      },
    );

    test('returns Exception when HTTP service throws an error', () async {
      when(
        () => mockHttpService.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(Exception('Network error'));

      final result = await dataSource.getHomeMenu();

      expect(result.isLeft(), true);
      result.fold(
        (failure) => expect(failure, isA<Exception>()),
        (_) => fail('Should return failure'),
      );
    });
  });
}
