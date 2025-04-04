import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/domain/use_cases/get_home_menus_use_case.dart';
import 'package:wendys_challenge/features/home/presentation/cubit/get_menus_cubit.dart';

class MockGetHomeMenuUseCase extends Mock implements GetHomeMenuUseCase {}

void main() {
  late MockGetHomeMenuUseCase mockGetHomeMenuUseCase;
  late GetMenusCubit getMenusCubit;

  setUp(() {
    mockGetHomeMenuUseCase = MockGetHomeMenuUseCase();
    getMenusCubit = GetMenusCubit(mockGetHomeMenuUseCase);
  });

  tearDown(() {
    getMenusCubit.close();
  });

  test('initial state should be GetMenusState.initial', () {
    expect(getMenusCubit.state, const GetMenusState.initial());
  });

  group('getMenus', () {
    final mockCategories = [
      const CategoryEntity(name: 'Salads', products: []),
      const CategoryEntity(name: 'Combos', products: []),
      const CategoryEntity(name: 'Burgers', products: []),
    ];

    test('initial state should be GetMenusState.initial', () {
      expect(getMenusCubit.state, const GetMenusState.initial());
    });

    blocTest<GetMenusCubit, GetMenusState>(
      '''
should emit [loadInProgress, loadSuccess] when data is gotten successfully''',
      build: () {
        when(
          () => mockGetHomeMenuUseCase.execute(),
        ).thenAnswer((_) async => Right(mockCategories));

        return getMenusCubit;
      },
      act: (cubit) => cubit.getMenus(),
      expect:
          () => [
            const GetMenusState.loadInProgress(),
            GetMenusState.loadSuccess(mockCategories),
          ],
      verify: (_) {
        verify(() => mockGetHomeMenuUseCase.execute()).called(1);
        verifyNoMoreInteractions(mockGetHomeMenuUseCase);
      },
    );

    blocTest<GetMenusCubit, GetMenusState>(
      '''
should emit [loadInProgress, loadFailure] when getting data fails with Exception''',
      build: () {
        when(
          () => mockGetHomeMenuUseCase.execute(),
        ).thenAnswer((_) async => const Left(HomeExceptions.generic()));
        return getMenusCubit;
      },
      act: (cubit) => cubit.getMenus(),
      expect:
          () => [
            const GetMenusState.loadInProgress(),
            const GetMenusState.loadFailure(HomeExceptions.generic()),
          ],
      verify: (_) {
        verify(() => mockGetHomeMenuUseCase.execute()).called(1);
        verifyNoMoreInteractions(mockGetHomeMenuUseCase);
      },
    );
  });
}
