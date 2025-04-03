import 'package:dartz/dartz.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/exceptions/home_exceptions.dart';
import 'package:wendys_challenge/features/home/domain/repositories/home_repository.dart';

/// A use case for retrieving and processing home menu categories.
///
/// This use case interacts with the [HomeRepository] to fetch the home menu
/// categories, then applies business logic (e.g., sorting) on the data. It
/// returns either a processed list of [CategoryEntity] objects
/// or a domain-specific error.
class GetHomeMenuUseCase {
  /// Creates a new instance of [GetHomeMenuUseCase].
  ///
  /// The `repository`` parameter is used to perform the data retrieval.
  GetHomeMenuUseCase(this._repository);

  /// The repository used to retrieve home menu data.
  final HomeRepository _repository;

  /// Executes the use case.
  ///
  /// Retrieves the home menu categories, sorts them alphabetically by name,
  /// and returns the result. If the operation fails, returns an error.
  Future<Either<HomeExceptions, List<CategoryEntity>>> execute() async {
    final result = await _repository.getHomeMenu();

    return result.fold(
      (exception) {
        return Left(exception);
      },
      (categories) {
        final sortedCategories = List<CategoryEntity>.from(categories)
          ..sort((a, b) => a.name.compareTo(b.name));

        return Right(sortedCategories);
      },
    );
  }
}
