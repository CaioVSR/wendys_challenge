import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/domain/repositories/home_repository.dart';
import 'package:wendys_challenge/features/home/domain/use_cases/get_home_menus_use_case.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late MockHomeRepository mockRepository;
  late GetHomeMenuUseCase useCase;

  setUpAll(() {
    mockRepository = MockHomeRepository();
    useCase = GetHomeMenuUseCase(mockRepository);
  });

  group('GetHomeMenuUseCase', () {
    test('should return exception on failure', () async {
      when(() => mockRepository.getHomeMenu()).thenAnswer(
        (_) async => const Left(HomeExceptions.generic('Repo failure')),
      );

      final result = await useCase.execute();

      expect(result.isLeft(), true);
      result.fold(
        (e) => expect(e.message, 'Repo failure'),
        (_) => fail('Expected left'),
      );
    });

    test('should return a list of CategoryEntity on success', () async {
      final categories = [
        const CategoryEntity(name: 'Salads', products: []),
        const CategoryEntity(name: 'Combos', products: []),
        const CategoryEntity(name: 'Burgers', products: []),
      ];

      when(
        () => mockRepository.getHomeMenu(),
      ).thenAnswer((_) async => Right(categories));

      final result = await useCase.execute();

      expect(result.isRight(), true);
      result.fold(
        (l) {
          fail('Expected right');
        },
        (sortedCategories) {
          expect(sortedCategories.length, 3);
          expect(sortedCategories[0].name, 'Burgers');
          expect(sortedCategories[1].name, 'Combos');
          expect(sortedCategories[2].name, 'Salads');
        },
      );
    });
  });
}
