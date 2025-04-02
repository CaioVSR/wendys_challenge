import 'package:wendys_challenge/core/utils/result_typedef.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';

/// A repository interface for fetching home menu data.
///
/// This abstract class defines the contract for retrieving home menu
/// categories. Implementations should transform raw data into a list of
/// [CategoryEntity] objects and handle errors properly.
abstract class HomeRepository {
  /// Retrieves the home menu categories.
  ///
  /// Returns a [Result] containing a list of [CategoryEntity] objects or an
  /// error if the operation fails.
  Result<List<CategoryEntity>> getHomeMenu();
}
