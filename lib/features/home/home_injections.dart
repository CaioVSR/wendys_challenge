import 'package:wendys_challenge/core/base/base_injection.dart';
import 'package:wendys_challenge/features/home/data/data_sources/remote/home_data_source.dart';
import 'package:wendys_challenge/features/home/data/repositories/home_repository_impl.dart';
import 'package:wendys_challenge/features/home/domain/repositories/home_repository.dart';
import 'package:wendys_challenge/features/home/domain/use_cases/get_home_menus_use_case.dart';

/// Injection class for the `Home` feature.
///
/// This class extends [BaseInjection] and is responsible for registering the
/// dependencies required by a specific feature. It registers the necessary
/// dependencies (such as cubits, repositories, or services) needed to manage
/// the feature's state and functionality.
class HomeInjections extends BaseInjection {
  /// Creates a new instance of the injection class.
  ///
  /// The constructor registers the necessary dependencies using the dependency
  /// injection container.
  HomeInjections()
    : super(
        scopeName: 'Home',
        registrations: [
          (i) => i.registerLazySingleton<HomeDataSource>(
            () => HomeDataSourceImpl(i.get()),
          ),
          (i) => i.registerLazySingleton<HomeRepository>(
            () => HomeRepositoryImpl(i.get()),
          ),
          (i) => i.registerLazySingleton<GetHomeMenuUseCase>(
            () => GetHomeMenuUseCase(i.get()),
          ),
        ],
      );
}
