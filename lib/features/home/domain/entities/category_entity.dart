import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

/// A model class representing a category in the home menu.
///
/// This class encapsulates the properties of a category, such as its unique
/// [id] and [name]. It leverages the [freezed] package to generate immutable
/// classes with value equality, copyWith, and other utility methods.
@freezed
abstract class CategoryEntity with _$CategoryEntity {
  /// Creates a new instance of [CategoryEntity].
  ///
  /// The [id] parameter is the unique identifier for the category.
  /// The [name] parameter is the display name of the category.
  const factory CategoryEntity({
    required int id,
    required String name,
  }) = _CategoryEntity;
}
