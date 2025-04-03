import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wendys_challenge/features/home/domain/entities/menu_entity.dart';

part 'category_entity.freezed.dart';

/// A domain entity representing a menu category in the Wendy's app.
///
/// A category groups related menu items together (e.g., "Hamburgers", "Sides",
/// "Beverages"). Each category contains a list of [MenuEntity] objects that
/// represent the actual food items available within that category.
///
/// This entity is used by the presentation layer to display category sections
/// in the menu interface and is the primary organizational structure for
/// the Wendy's menu.
@freezed
abstract class CategoryEntity with _$CategoryEntity {
  /// Creates a new [CategoryEntity] instance.
  ///
  /// [name] is the display name of the category (e.g., "Hamburgers").
  /// [menus] is the list of menu items that belong to this category.
  const factory CategoryEntity({
    /// The display name of this category.
    required String name,

    /// The list of menu items that belong to this category.
    required List<MenuEntity> menus,
  }) = _CategoryEntity;
}
