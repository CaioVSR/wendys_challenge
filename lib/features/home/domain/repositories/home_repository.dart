import 'package:dartz/dartz.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';

/// A repository interface for fetching home menu data.
///
/// This abstract class defines the contract for retrieving home menu
/// categories. Implementations should transform raw data into a list of
/// [CategoryEntity] objects and handle errors properly.
abstract class HomeRepository {
  /// Retrieves the home menu categories.
  ///
  /// Returns either a list of [CategoryEntity] objects or an
  /// error if the operation fails.
  Future<Either<HomeExceptions, List<CategoryEntity>>> getHomeMenu();
}
