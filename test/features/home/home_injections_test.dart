import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import 'package:wendys_challenge/features/home/data/data_sources/remote/home_data_source.dart';

import 'package:wendys_challenge/features/home/domain/repositories/home_repository.dart';
import 'package:wendys_challenge/features/home/domain/use_cases/get_home_menus_use_case.dart';
import 'package:wendys_challenge/features/home/home_injections.dart';
import 'package:wendys_challenge/features/home/presentation/cubit/get_menus_cubit.dart';

void main() {
  final getIt = GetIt.instance;

  setUp(() async {
    await getIt.reset();
  });

  tearDown(() async {
    if (getIt.currentScopeName == 'Home') {
      await getIt.popScope();
    }
  });

  group('HomeInjections', () {
    test('should register all dependencies correctly', () async {
      final homeInjections = HomeInjections();
      await homeInjections.setUp();

      expect(getIt.isRegistered<HomeDataSource>(), isTrue);
      expect(getIt.isRegistered<HomeRepository>(), isTrue);
      expect(getIt.isRegistered<GetHomeMenuUseCase>(), isTrue);
      expect(getIt.isRegistered<GetMenusCubit>(), isTrue);
    });

    test('should clean up dependencies when tearDown is called', () async {
      final homeInjections = HomeInjections();
      await homeInjections.setUp();

      await homeInjections.tearDown();

      expect(getIt.isRegistered<HomeDataSource>(), isFalse);
      expect(getIt.isRegistered<HomeRepository>(), isFalse);
      expect(getIt.isRegistered<GetHomeMenuUseCase>(), isFalse);
      expect(getIt.isRegistered<GetMenusCubit>(), isFalse);
    });
  });
}
