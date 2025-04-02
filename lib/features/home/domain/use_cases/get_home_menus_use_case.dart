import 'package:wendys_challenge/core/utils/result_typedef.dart';
import 'package:wendys_challenge/features/home/domain/entities/category_entity.dart';
import 'package:wendys_challenge/features/home/domain/repositories/home_repository.dart';

/// A use case for retrieving and processing home menu categories.
///
/// This use case interacts with the [HomeRepository] to fetch the home menu
/// categories, then applies business logic (e.g., sorting) on the data. It
/// returns a [Result] containing either a processed list of
/// [CategoryEntity] objects or a domain-specific error.
class GetHomeMenuUseCase {
  /// Creates a new instance of [GetHomeMenuUseCase].
  ///
  /// The [repository] parameter is used to perform the data retrieval.
  GetHomeMenuUseCase(this.repository);

  /// The repository used to retrieve home menu data.
  final HomeRepository repository;

  /// Executes the use case.
  ///
  /// Retrieves the home menu categories, sorts them alphabetically by name,
  /// and returns the result. If the operation fails, returns an error.
  Future<Result<List<CategoryEntity>>> call() async {
    final result = await repository.getHomeMenu();
    return result.fold(
      failure,
      (categories) {
        final sortedCategories = List<CategoryEntity>.from(categories)
          ..sort((a, b) => a.name.compareTo(b.name));
          
        return success(sortedCategories);
      },
    );
  }
}
