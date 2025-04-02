import 'package:wendys_challenge/core/utils/result_typedef.dart';
import 'package:wendys_challenge/features/home/data/data_sources/remote/home_data_source.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/domain/repositories/home_repository.dart';

/// A repository implementation for the home menu feature.
///
/// This class implements the [HomeRepository] interface to bridge the data and
/// domain layers. It transforms raw data from the remote 
/// data source into domain
/// entities and maps errors to domain-specific exceptions.
///
/// The implementation depends on a [HomeDataSource] to fetch raw menu data.
/// Different data source implementations can be used without affecting the
/// business logic.
class HomeRepositoryImpl implements HomeRepository {
  /// Creates a new instance of [HomeRepositoryImpl].
  ///
  /// Accepts a [HomeDataSource] that is responsible for retrieving 
  /// raw menu data.
  HomeRepositoryImpl(this._dataSource);

  /// The data source that provides raw menu data.
  final HomeDataSource _dataSource;

  /// Retrieves the home menu categories.
  ///
  /// This method performs the following steps:
  /// 1. Requests the home menu data from the data source.
  /// 2. Maps errors to a generic [HomeExceptions] to maintain domain
  ///    abstraction.
  /// 3. Converts raw data into a list of [CategoryEntity] objects.
  ///
  /// Returns a [Result] containing either a list of [CategoryEntity] objects or
  /// a domain-specific exception if the operation fails.
  @override
  Result<List<CategoryEntity>> getHomeMenu() async {
    final result = await _dataSource.getHomeMenu();

    return result.fold(
      (error) => failure(const HomeExceptions.generic()),
      (data) => success(
        data.menuLists.subMenus
            .map((e) => CategoryEntity(id: e.subMenuId, name: e.displayName))
            .toList(),
      ),
    );
  }
}
