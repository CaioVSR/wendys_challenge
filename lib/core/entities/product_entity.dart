import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';

/// A domain entity representing a menu item in the Wendy's app.
///
/// This entity contains the essential data about food items on the menu,
/// including their identifiers, description, and optional nutritional and
/// pricing information.
///
/// [ProductEntity] is used by the presentation layer to display individual menu
/// items within categories and provide users with information needed to make
/// ordering decisions.
@freezed
abstract class ProductEntity with _$ProductEntity {
  /// Creates a new [ProductEntity] instance.
  ///
  /// Required parameters:
  /// - [id]: The unique identifier of the menu item
  /// - [name]: The display name of the menu item
  /// - [description]: A detailed description of the menu item
  /// - [menuItemId]: The API-specific identifier for the menu item
  ///
  /// Optional parameters:
  /// - [calorieRange]: The calorie information (e.g., "490 Cal")
  /// - [priceRange]: The price information (e.g., "$4.09" or "$0.99-$2.19")
  const factory ProductEntity({
    required int id,
    required String name,
    required String description,
    required int menuItemId,
    String? calorieRange,
    String? priceRange,
  }) = _ProductEntity;
}
