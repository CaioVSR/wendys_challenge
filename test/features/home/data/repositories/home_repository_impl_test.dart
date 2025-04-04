import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/core/entities/product_entity.dart';
import 'package:wendys_challenge/features/home/data/data_sources/remote/home_data_source.dart';
import 'package:wendys_challenge/features/home/data/models/menu_response_model.dart';
import 'package:wendys_challenge/features/home/data/repositories/home_repository_impl.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';

import '../../../../fixtures/fixture_converter.dart';

class MockHomeDataSource extends Mock implements HomeDataSource {}

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeDataSource mockDataSource;
  late Map<String, dynamic> mockSuccessJson;
  late MenuResponseModel mockSuccessResponse;

  setUpAll(() async {
    mockDataSource = MockHomeDataSource();
    repository = HomeRepositoryImpl(mockDataSource);
    mockSuccessJson = await fixtureConverter(
      'test/fixtures/menu_response_fixture.json',
    );
    mockSuccessResponse = MenuResponseModel.fromJson(mockSuccessJson);
  });

  group('HomeRepositoryImpl', () {
    test('should return an HomeException', () async {
      when(
        () => mockDataSource.getHomeMenu(),
      ).thenAnswer((_) async => Left(Exception('Error')));

      final result = await repository.getHomeMenu();

      expect(
        result,
        const Left<HomeExceptions, List<CategoryEntity>>(
          HomeExceptions.generic(),
        ),
      );
      verify(() => mockDataSource.getHomeMenu()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });

    test('should return a list of CategoryEntity', () async {
      when(
        () => mockDataSource.getHomeMenu(),
      ).thenAnswer((_) async => Right(mockSuccessResponse));

      final result = await repository.getHomeMenu();

      expect(result.isRight(), true);
      expect(result.fold((l) => null, (r) => r.length), 25);
      expect(result.fold((l) => null, (r) => r[0].name), 'Combos');
      verify(() => mockDataSource.getHomeMenu()).called(1);
      verifyNoMoreInteractions(mockDataSource);
    });
  });
}
